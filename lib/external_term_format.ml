(*
 * Copyright yutopp 2017 - .
 *
 * Distributed under the Boost Software License, Version 1.0.
 * (See accompanying file LICENSE_1_0.txt or copy at
 * http://www.boost.org/LICENSE_1_0.txt)
 *)

let uncompress_form size buf =
  (* for input *)
  let pos = ref 0 in
  let fill in_buf =
    let buf_size = Bytes.length in_buf in
    let rest_size = (Bitstring.bitstring_length buf / 8) - (!pos*8) in
    let size = min buf_size rest_size in
    let subbitstr = Bitstring.subbitstring buf (!pos*8) (size*8) in
    Bytes.blit_string (subbitstr |> Bitstring.string_of_bitstring) 0 in_buf 0 size;
    pos := !pos + size;
    size
  in
  (* for output *)
  let out_mem = Buffer.create size in
  let export out_buf len =
    Buffer.add_bytes out_mem out_buf
  in
  (* uncompress *)
  Zlib.uncompress fill export;
  (* to bitstring *)
  Buffer.sub out_mem 0 size
  |> Bitstring.bitstring_of_string

let bitstring_printer fmt buf =
  Format.fprintf fmt "%s" (Bitstring.string_of_bitstring buf)

type t =
  | SmallInteger of int
  | Integer of int32
  | Float of string (* float is stored as string *)
  | Atom of string
  | SmallTuple of int * t list
  | Map of int32 * (t * t) list
  | Nil
  | String of string
  | Binary of Bitstring.t [@printer bitstring_printer]
  | List of t list * t
  | NewFloat of float
  | AtomUtf8 of string
  | SmallAtomUtf8 of string
[@@deriving show]

(* http://erlang.org/doc/apps/erts/erl_ext_dist.html, 2018/10/11 *)
let rec parse_etf (_, buf) =
  let open Parser.Combinator in
  match%bitstring buf with
  (* 12.1: compressed term format *)
  | {| 80   : 1*8
     ; size : 4*8 : bigendian
     ; buf  : -1 : bitstring
     |} ->
     let data = uncompress_form ((Int32.to_int size)+1) buf in
     parse_etf ([], data)

  (* 12.2 and 12.3 are not implemented *)

  (* 12.4: SMALL_INTEGER_EXT *)
  | {| 97    : 1*8
     ; value : 1*8
     ; rest  : -1 : bitstring
     |} ->
     Ok (SmallInteger value, rest)

  (* 12.5: INTEGER_EXT *)
  | {| 98    : 1*8
     ; value : 4*8 : bigendian
     ; rest  : -1 : bitstring
     |} ->
     Ok (Integer value, rest)

  (* 12.6: FLOAT_EXT *)
  | {| 99    : 1*8
     ; value : 31*8 : string
     ; rest  : -1 : bitstring
     |} ->
     Ok (Float value, rest)

  (* 12.7: REFERENCE_EXT *)
  (* 12.8: PORT_EXT *)
  (* 12.9: PID_EXT *)

  (* 12.10 SMALL_TUPLE_EXT *)
  | {| 104      : 1*8
     ; arity    : 1*8
     ; elem_buf : -1 : bitstring
     |} ->
     list parse_etf arity elem_buf
     |> map (fun list -> SmallTuple (arity, list))

  (* 12.11 LARGE_TUPLE_EXT *)
  (* 12.12 MAP_EXT *)
  | {| 116       : 1*8
     ; arity     : 4*8 : bigendian
     ; pairs_buf : -1 : bitstring
     |} ->
     let forget p (_, buf) = p ([], buf) in
     let parse_pair =
       forget parse_etf >>= fun k ->
       forget parse_etf >>= fun v ->
       return (k, v)
     in
     list parse_pair (Int32.to_int arity) pairs_buf
     |> map (fun pairs -> Map (arity, pairs))

  (* 12.13 NIL_EXT *)
  | {| 106   : 1*8
     ; rest  : -1 : bitstring
     |} ->
     Ok (Nil, rest)

  (* 12.14 STRING_EXT *)
  | {| 107   : 1*8
     ; len   : 2*8
     ; chars : len*8 : string
     ; rest  : -1 : bitstring
     |} ->
     Ok (String chars, rest)

  (* 12.15 LIST_EXT *)
  | {| 108      : 1*8
     ; len      : 4*8
     ; list_buf : -1 : bitstring
     |} ->
     let parser =
       (* elements *)
       list parse_etf (Int32.to_int len)
       (* tail *)
       >> act parse_etf (fun n p -> (p, n))
     in
     parser list_buf |> map (fun (list, tail) -> List (list, tail))

  (* 12.16 BINARY_EXT *)
  | {| 109   : 1*8
     ; len   : 2*8
     ; data  : len*8 : bitstring
     ; rest  : -1 : bitstring
     |} ->
     Ok (Binary data, rest)

  (* 12.17 SMALL_BIG_EXT *)
  (* 12.18 LARGE_BIG_EXT *)
  (* 12.19 NEW_REFERENCE_EXT *)
  (* 12.20 FUN_EXT *)
  (* 12.21 NEW_FUN_EXT *)
  (* 12.22 EXPORT_EXT *)
  (* 12.23 BIT_BINARY_EXT *)

  (* 12.24 NEW_FLOAT_EXT *)
  | {| 70    : 1*8
     ; value : 8*8
     ; rest  : -1 : bitstring
     |} ->
     Ok (NewFloat (Int64.float_of_bits value), rest)

  (* 12.25 ATOM_UTF8_EXT *)
  | {| 118  : 1*8
     ; len  : 2*8
     ; name : len * 8 : string
     ; rest : -1 : bitstring
     |} ->
     Ok (AtomUtf8 name, rest)

  (* 12.26 SMALL_ATOM_UTF8_EXT *)
  | {| 119   : 1*8
     ; len   : 1*8
     ; name  : len*8 : string
     ; rest  : -1 : bitstring
     |} ->
     Ok (SmallAtomUtf8 name, rest)

  (* 12.27 ATOM_EXT (deprecated) *)
  | {| 100  : 1*8
     ; len  : 2*8
     ; name : len * 8 : string
     ; rest : -1 : bitstring
     |} ->
     Ok (Atom name, rest)

  (* 12.28  SMALL_ATOM_EXT (deprecated) *)

  (* unknown *)
  | {| head : 1*8; _ |} ->
     Error (Printf.sprintf "error (%d)" head, buf)

let parse buf =
  match%bitstring buf with
  | {| 131  : 1*8
     ; rest : -1 : bitstring
     |} ->
     parse_etf ([], rest)
  | {| _ |} ->
     Error ("unsupported version", buf)
