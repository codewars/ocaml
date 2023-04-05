open Base
open OUnit
open Preloaded

let suite = [
    "cubes tests (passing)" >:::
        [
            "Testing [1; 2; 3]" >:: (fun _ -> assert_equal [1; 8; 27] (Solution.cubes (List.range 1 4)) ~printer:print_int_list);
            "Testing [5]" >:: (fun _ -> assert_equal [125] (Solution.cubes [5]) ~printer:print_int_list);
        ];
    "cubes tests (failing)" >:::
        [
            "Testing [1; 2; 3]" >:: (fun _ -> assert_equal [1; 8; 27] (Solution.cubes (List.range 1 5)) ~printer:print_int_list);
        ];
    ]