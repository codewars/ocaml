open OUnit

let suite = [
    "fib_zarith tests" >:::
        [
            "Testing 42" >:: (fun _ -> assert_equal (Z.of_int 912427) (Solution.fib_zarith 42) ~cmp:Z.equal ~printer:Z.to_string);
            "Testing 100000" >:: (fun _ -> assert_equal (Z.of_int 584523) (Solution.fib_zarith 100000) ~cmp:Z.equal ~printer:Z.to_string);
            "Testing 1000000" >:: (fun _ -> assert_equal (Z.of_int 930254) (Solution.fib_zarith 1000000) ~cmp:Z.equal ~printer:Z.to_string);
        ];
    "fib_num tests" >:::
        [
            "Testing 42" >:: (fun _ -> assert_equal (Big_int.big_int_of_int 912427) (Solution.fib_num 42) ~cmp:Big_int.eq_big_int ~printer:Big_int.string_of_big_int);
            "Testing 100000" >:: (fun _ -> assert_equal (Big_int.big_int_of_int 584523) (Solution.fib_num 100000) ~cmp:Big_int.eq_big_int ~printer:Big_int.string_of_big_int);
            "Testing 1000000" >:: (fun _ -> assert_equal (Big_int.big_int_of_int 930254) (Solution.fib_num 1000000) ~cmp:Big_int.eq_big_int ~printer:Big_int.string_of_big_int);
        ];        
    ]