open Test_util

let%expect_test "test_try_stacktrace.erl" =
  print_ast "test_try_stacktrace.beam";
  match otp_version () with
  | OTP21 ->
     [%expect {| |}]
  | _ ->
     [%expect {| |}]
