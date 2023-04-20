open OUnit

let _esc_lf = Str.global_replace (Str.regexp_string "\n") "<:LF:>"

let cw_print_success () = print_endline "\n<PASSED::>Test passed"
  
let cw_print_failure err = print_endline ("\n<FAILED::>" ^ _esc_lf err)

let cw_print_error err = print_endline ("\n<ERROR::>" ^ _esc_lf err)  

let cw_print_it label = print_endline ("\n<IT::>" ^ label)

let cw_print_describe label = print_endline ("\n<DESCRIBE::>" ^ label)

let cw_print_completed t = 
  Printf.sprintf "\n<COMPLETEDIN::>%.2f" (t *. 1000.0)
  |> print_endline

let cw_print_result = function
  | RSuccess _        -> cw_print_success ()
  | RFailure (_, err) -> cw_print_failure err
  | RError   (_, err) -> cw_print_error err
  | RSkip _ | RTodo _ -> ()
  
let cw_print_test_event = function
  | EResult result    -> cw_print_result result
  | EStart _ | EEnd _ -> ()

let dispatch_test_case label test_case =
  cw_print_it label;
  let start = Unix.gettimeofday () in
  perform_test cw_print_test_event test_case |> ignore;
  cw_print_completed (Unix.gettimeofday () -. start)
  
let rec dispatch_labeled_test label test =
  match test with
  | TestLabel (nested_label, nested_test) -> begin
    cw_print_describe label;
    let start = Unix.gettimeofday () in
    dispatch_labeled_test nested_label nested_test;
    cw_print_completed (Unix.gettimeofday () -. start)
  end
  | TestCase _ -> dispatch_test_case label test
  | TestList tests -> begin
    cw_print_describe label;
    let start = Unix.gettimeofday () in
    run_tests tests;
    cw_print_completed (Unix.gettimeofday () -. start)
  end

and run_test = function
  | TestList tests -> "" >::: tests |> run_test
  | TestCase func ->  "" >::  func  |> run_test
  | TestLabel (label, test) -> dispatch_labeled_test label test

and run_tests tests = List.iter run_test tests
  
let () = run_tests Tests.suite
