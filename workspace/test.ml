open OUnit

let _esc_lf s =
  s |> Str.global_replace (Str.regexp_string "\n") "<:LF:>";;

(* TODO Fix missing `<COMPLETEDIN::>` *)
let cw_print_test_event = function
  | EStart (name::rest) -> print_endline ("\n<IT::>" ^ string_of_node name)
  | EResult result ->
    begin match result with
      | RSuccess _ -> print_endline ("\n<PASSED::>Test passed")
      | RFailure (_, err) -> print_endline ("\n<FAILED::>" ^ (_esc_lf err))
      | RError (_, err) -> print_endline ("\n<ERROR::>" ^ (_esc_lf err))
      | _ -> ()
    end
  | _ -> ()

let run_test = function
  | TestLabel (name, suite) -> begin
    print_endline ("\n<DESCRIBE::>" ^ name);
    perform_test cw_print_test_event suite
  end
  | suite -> perform_test cw_print_test_event suite

(* Solution and Tests are concatenated to `fixture.ml` *)
let _ = List.map run_test Fixture.Tests.suite |> ignore
