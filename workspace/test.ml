open OUnit

let _esc_lf s =
  s |> Str.global_replace (Str.regexp_string "\n") "<:LF:>";;

let cw_print_success = function
  | _ -> print_endline ("\n<PASSED::>Test passed")
  
let cw_print_failure = function
  | err -> print_endline ("\n<FAILED::>" ^ (_esc_lf err))

let cw_print_error = function
  | err -> print_endline ("\n<ERROR::>" ^ (_esc_lf err))  
  
let cw_print_result = function
  | RSuccess _        -> cw_print_success()
  | RFailure(_, err) -> cw_print_failure err
  | RError  (_, err) -> cw_print_error err
  | _        -> ()
  
let cw_print_test_event = function
  | EResult result -> cw_print_result result
  | _ -> ()

let rec dispatch_test_group = function
  | label, TestList tests -> begin
    print_endline("\n<DESCRIBE::>"^label);
    run_tests tests;
    print_endline("\n<COMPLETEDIN::>");
  end
  
and dispatch_test_case = function
  | label, test_case -> begin
    print_endline("\n<IT::>"^label);
    perform_test cw_print_test_event test_case |> ignore;
    print_endline("\n<COMPLETEDIN::>");
  end  
  
and dispatch_labeled_test = function
  | label, TestLabel (nested_label, test) -> dispatch_labeled_test (nested_label, test)
  | label, TestCase test_fun -> dispatch_test_case(label, TestCase test_fun)
  | label, TestList test_group -> dispatch_test_group(label, TestList test_group)
  
and run_test = function
  | TestList tests -> "" >::: tests |> run_test
  | TestCase func ->  "" >::  func  |> run_test
  | TestLabel(label, test) -> dispatch_labeled_test(label, test)

and run_tests = function
  | tests -> List.iter run_test tests
  
(* `solution` and `fixture` are concatenated to `fixture.ml` *)
let () = run_tests Fixture.Tests.suite
