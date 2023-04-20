open Batteries
open OUnit
open Preloaded

let suite = [
    "sum tests" >:::
        [
            "Testing 1" >:: (fun _ -> assert_equal 1 (Solution.sum 1) ~printer:print_int);
            "Testing 9" >:: (fun _ -> assert_equal 45 (Solution.sum 9) ~printer:print_int);
        ];
    "cubes tests" >:::
        [
            "Testing [1; 2; 3]" >:: (fun _ -> assert_equal [1; 8; 27] (Solution.cubes ((1 -- 3) |> List.of_enum)) ~printer:print_int_list);
            "Testing [5]" >:: (fun _ -> assert_equal [125] (Solution.cubes [5]) ~printer:print_int_list);
        ];
    ]