open Test_util

let%expect_test "test_operator_type.beam" =
  print_ast "test_operator_type.beam";
  [%expect {|
    (Ok (
      AbstractCode (
        ModDecl (
          (AttrFile 1 test_operator_type.erl 1)
          (AttrMod 1 test_operator_type)
          (AttrExportType 3 (
            (t 0)
            (u 0)))
          (DeclType 6 t
            ()
            (TyOp 6 (TyLit (LitInteger 6 1)) + (TyLit (LitInteger 6 1))))
          (DeclType 7 u
            ()
            (TyOp 7 (TyLit (LitInteger 7 3)) * (TyLit (LitInteger 7 3))))
          FormEof)))) |}]
