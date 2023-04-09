open OUnit
open Batteries

let suite = [
    "getenv" >:::
        [
            "Test" >:: (fun _ -> assert_equal [||] (Solution.getenv ()) ~printer:(IO.to_string @@ Array.print String.print_quoted));
        ];
    ]