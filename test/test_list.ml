open Test_util

let%expect_test "test_list.beam" =
  print_ast "test_list.beam";
  [%expect {|
    (Ok (
      AbstractCode (
        ModDecl (
          (AttrFile
            (line      1)
            (file      test_list.erl)
            (file_line 1))
          (AttrMod
            (line        1)
            (module_name test_list))
          (AttrExport
            (line 2)
            (function_arity_list (
              (f 0)
              (g 1))))
          (DeclFun
            (line          5)
            (function_name f)
            (arity         0)
            (clauses ((
              ClsFun
              (line 5)
              (patterns       ())
              (guard_sequence ())
              (body (
                ExprBody (
                  exprs (
                    (ExprMatch
                      (line 6)
                      (pattern (
                        PatVar
                        (line 6)
                        (id   List)))
                      (body (
                        ExprCons
                        (line 6)
                        (head (
                          ExprLit (
                            lit (
                              LitInteger
                              (line    6)
                              (integer 3)))))
                        (tail (
                          ExprCons
                          (line 6)
                          (head (
                            ExprLit (
                              lit (
                                LitInteger
                                (line    6)
                                (integer 1)))))
                          (tail (
                            ExprCons
                            (line 6)
                            (head (
                              ExprLit (
                                lit (
                                  LitInteger
                                  (line    6)
                                  (integer 4)))))
                            (tail (ExprNil (line 6))))))))))
                    (ExprMatch
                      (line 7)
                      (pattern (
                        PatVar
                        (line 7)
                        (id   List)))
                      (body (
                        ExprCons
                        (line 7)
                        (head (
                          ExprLit (
                            lit (
                              LitInteger
                              (line    7)
                              (integer 3)))))
                        (tail (
                          ExprCons
                          (line 7)
                          (head (
                            ExprLit (
                              lit (
                                LitInteger
                                (line    7)
                                (integer 1)))))
                          (tail (
                            ExprCons
                            (line 7)
                            (head (
                              ExprLit (
                                lit (
                                  LitInteger
                                  (line    7)
                                  (integer 4)))))
                            (tail (ExprNil (line 7))))))))))
                    (ExprMatch
                      (line 9)
                      (pattern (
                        PatVar
                        (line 9)
                        (id   List)))
                      (body (
                        ExprCons
                        (line 9)
                        (head (
                          ExprLit (
                            lit (
                              LitInteger
                              (line    9)
                              (integer 3)))))
                        (tail (
                          ExprCons
                          (line 9)
                          (head (
                            ExprLit (
                              lit (
                                LitInteger
                                (line    9)
                                (integer 1)))))
                          (tail (
                            ExprCons
                            (line 9)
                            (head (
                              ExprLit (
                                lit (
                                  LitInteger
                                  (line    9)
                                  (integer 4)))))
                            (tail (ExprNil (line 9))))))))))
                    (ExprMatch
                      (line 10)
                      (pattern (
                        PatVar
                        (line 10)
                        (id   List)))
                      (body (
                        ExprCons
                        (line 10)
                        (head (
                          ExprLit (
                            lit (
                              LitInteger
                              (line    10)
                              (integer 3)))))
                        (tail (
                          ExprCons
                          (line 10)
                          (head (
                            ExprLit (
                              lit (
                                LitInteger
                                (line    10)
                                (integer 1)))))
                          (tail (
                            ExprCons
                            (line 10)
                            (head (
                              ExprLit (
                                lit (
                                  LitInteger
                                  (line    10)
                                  (integer 4)))))
                            (tail (ExprNil (line 10))))))))))
                    (ExprMatch
                      (line 12)
                      (pattern (
                        PatVar
                        (line 12)
                        (id   ImproperList)))
                      (body (
                        ExprCons
                        (line 12)
                        (head (
                          ExprLit (
                            lit (
                              LitInteger
                              (line    12)
                              (integer 3)))))
                        (tail (
                          ExprCons
                          (line 12)
                          (head (
                            ExprLit (
                              lit (
                                LitInteger
                                (line    12)
                                (integer 1)))))
                          (tail (
                            ExprLit (
                              lit (
                                LitInteger
                                (line    12)
                                (integer 4))))))))))
                    (ExprListComprehension
                      (line 14)
                      (expr (
                        ExprBinOp
                        (line 14)
                        (op   *)
                        (lhs (
                          ExprVar
                          (line 14)
                          (id   X)))
                        (rhs (
                          ExprLit (
                            lit (
                              LitInteger
                              (line    14)
                              (integer 2)))))))
                      (qualifiers (
                        (QualifierGenerator
                          (line 14)
                          (pattern (PatVar  (line 14) (id X)))
                          (expr    (ExprVar (line 14) (id List))))
                        (QualifierFilter (
                          filter (
                            ExprBinOp
                            (line 14)
                            (op   >=)
                            (lhs (
                              ExprVar
                              (line 14)
                              (id   X)))
                            (rhs (
                              ExprLit (
                                lit (
                                  LitInteger
                                  (line    14)
                                  (integer 3)))))))))))))))))))
          (DeclFun
            (line          17)
            (function_name g)
            (arity         1)
            (clauses ((
              ClsFun
              (line 17)
              (patterns ((
                PatVar
                (line 17)
                (id   List))))
              (guard_sequence ())
              (body (
                ExprBody (
                  exprs (
                    (ExprMatch
                      (line 18)
                      (pattern (
                        PatCons
                        (line 18)
                        (head (
                          PatLit (
                            lit (
                              LitInteger
                              (line    18)
                              (integer 3)))))
                        (tail (
                          PatCons
                          (line 18)
                          (head (
                            PatLit (
                              lit (
                                LitInteger
                                (line    18)
                                (integer 1)))))
                          (tail (
                            PatCons
                            (line 18)
                            (head (
                              PatLit (
                                lit (
                                  LitInteger
                                  (line    18)
                                  (integer 4)))))
                            (tail (PatNil (line 18)))))))))
                      (body (
                        ExprVar
                        (line 18)
                        (id   List))))
                    (ExprMatch
                      (line 19)
                      (pattern (
                        PatCons
                        (line 19)
                        (head (
                          PatLit (
                            lit (
                              LitInteger
                              (line    19)
                              (integer 3)))))
                        (tail (
                          PatCons
                          (line 19)
                          (head (
                            PatLit (
                              lit (
                                LitInteger
                                (line    19)
                                (integer 1)))))
                          (tail (
                            PatCons
                            (line 19)
                            (head (
                              PatLit (
                                lit (
                                  LitInteger
                                  (line    19)
                                  (integer 4)))))
                            (tail (PatNil (line 19)))))))))
                      (body (
                        ExprVar
                        (line 19)
                        (id   List))))
                    (ExprMatch
                      (line 21)
                      (pattern (
                        PatCons
                        (line 21)
                        (head (
                          PatLit (
                            lit (
                              LitInteger
                              (line    21)
                              (integer 3)))))
                        (tail (
                          PatCons
                          (line 21)
                          (head (
                            PatLit (
                              lit (
                                LitInteger
                                (line    21)
                                (integer 1)))))
                          (tail (
                            PatCons
                            (line 21)
                            (head (
                              PatLit (
                                lit (
                                  LitInteger
                                  (line    21)
                                  (integer 4)))))
                            (tail (PatNil (line 21)))))))))
                      (body (
                        ExprVar
                        (line 21)
                        (id   List))))
                    (ExprMatch
                      (line 22)
                      (pattern (
                        PatCons
                        (line 22)
                        (head (
                          PatLit (
                            lit (
                              LitInteger
                              (line    22)
                              (integer 3)))))
                        (tail (
                          PatCons
                          (line 22)
                          (head (
                            PatLit (
                              lit (
                                LitInteger
                                (line    22)
                                (integer 1)))))
                          (tail (
                            PatCons
                            (line 22)
                            (head (
                              PatLit (
                                lit (
                                  LitInteger
                                  (line    22)
                                  (integer 4)))))
                            (tail (PatNil (line 22)))))))))
                      (body (
                        ExprVar
                        (line 22)
                        (id   List))))
                    (ExprMatch
                      (line 24)
                      (pattern (
                        PatCons
                        (line 24)
                        (head (
                          PatLit (
                            lit (
                              LitInteger
                              (line    24)
                              (integer 3)))))
                        (tail (
                          PatCons
                          (line 24)
                          (head (
                            PatLit (
                              lit (
                                LitInteger
                                (line    24)
                                (integer 1)))))
                          (tail (
                            PatLit (
                              lit (
                                LitInteger
                                (line    24)
                                (integer 4)))))))))
                      (body (
                        ExprVar
                        (line 24)
                        (id   List))))))))))))
          FormEof)))) |}]
