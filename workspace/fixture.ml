(* TODO Avoid concatenating in the next version *)
let is_even n = n mod 2 = 0

module Tests = struct
  open OUnit
  let suite = [
      "Top level test case" >:: (fun _ -> assert_equal false (is_even 1024));
      "Test Odd" >:::
          [
              "Should return false for 1" >:: (fun _ -> assert_equal false (is_even 1));
              "Should return false for 7" >:: (fun _ -> assert_equal false (is_even 7))
          ];
      "Test even" >:::
          [
              "Should return true for 100" >:: (fun _ -> assert_equal true (is_even 100));
              "Should return true for 42" >:: (fun _ -> assert_equal true (is_even 42))
          ];
      "Test edge cases" >:::
          [
            "Test zero" >:::
                [
                    "Should return true for 0" >:: (fun _ -> assert_equal true (is_even 0))
                ];
            "Test -1" >:::
                [
                    "Should return false for -1" >:: (fun _ -> assert_equal false (is_even (-1)))
                ]
          ];
      "Unlabeled tests" >:::
        [
          TestCase (fun _ -> assert_equal false (is_even 100) ~msg:"Incorrect answer for n=100");
          TestCase (fun _ -> assert_equal false (is_even 100) ~msg:"Incorrect answer for n=100");            
          TestList [
            TestCase (fun _ -> assert_equal false (is_even 100) ~msg:"Incorrect answer for n=100");
            TestCase (fun _ -> assert_equal false (is_even 100) ~msg:"Incorrect answer for n=100");            
          ]
          
        ];
      "Nested labels" >::: [
        "Outer label" >: ("Inner label" >: ("Tests with nested labels" >::: [
          TestCase (fun _ -> assert_equal false (is_even 100) ~msg:"Incorrect answer for n=100" ~printer: string_of_bool);
          TestCase (fun _ -> assert_equal false (is_even 100) ~msg:"Incorrect answer for n=100" ~printer: string_of_bool);          
          
        ]))
      ]
      ]
  ;;
end
