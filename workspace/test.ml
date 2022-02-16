open OUnit

let _esc_lf = Str.global_replace (Str.regexp_string "\n") "<:LF:>"

let cw_print_success () = print_endline "\n<PASSED::>Test passed"
  
let cw_print_failure err = print_endline ("\n<FAILED::>" ^ _esc_lf err)

let cw_print_error err = print_endline ("\n<ERROR::>" ^ _esc_lf err)  
  
let cw_print_result = function
  | RSuccess _        -> cw_print_success ()
  | RFailure (_, err) -> cw_print_failure err
  | RError   (_, err) -> cw_print_error err
  | RSkip _ | RTodo _ -> ()
  
let cw_print_test_event = function
  | EResult result    -> cw_print_result result
  | EStart _ | EEnd _ -> ()

let dispatch_test_case label test_case =
  print_endline ("\n<IT::>" ^ label);
  perform_test cw_print_test_event test_case |> ignore;
  print_endline "\n<COMPLETEDIN::>"
  
let rec dispatch_labeled_test label test =
  match test with
  | TestLabel (nested_label, nested_test) -> dispatch_labeled_test nested_label nested_test
  | TestCase _ -> dispatch_test_case label test
  | TestList tests -> begin
    print_endline ("\n<DESCRIBE::>" ^ label);
    run_tests tests;
    print_endline "\n<COMPLETEDIN::>";
  end
  
and run_test = function
  | TestList tests -> "" >::: tests |> run_test
  | TestCase func ->  "" >::  func  |> run_test
  | TestLabel (label, test) -> dispatch_labeled_test label test

and run_tests tests = List.iter run_test tests
  
(* `solution` and `fixture` are concatenated to `fixture.ml` *)
let () = run_tests Fixture.Tests.suite
