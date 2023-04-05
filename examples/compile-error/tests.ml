open OUnit

let suite = [
    "sum tests" >:::
        [
            "Testing 1" >:: (fun _ -> assert_equal 1 (Solution.sum 1) ~printer:string_of_int);
            "Testing 9" >:: (fun _ -> assert_equal 45 (Solution.sum 9) ~printer:string_of_int);
        ];
    ]