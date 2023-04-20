open OUnit

let suite = [
    "fib tests" >:::
        [
            "Testing 42 (1 domain)" >:: (fun _ -> assert_equal 433494437 (Solution.fib 1 42) ~printer:string_of_int);
            "Testing 42 (2 domains)" >:: (fun _ -> assert_equal 433494437 (Solution.fib 2 42) ~printer:string_of_int);
            "Testing 42 (3 domains)" >:: (fun _ -> assert_equal 433494437 (Solution.fib 3 42) ~printer:string_of_int);
            "Testing 42 (4 domains)" >:: (fun _ -> assert_equal 433494437 (Solution.fib 4 42) ~printer:string_of_int);
        ];
    ]