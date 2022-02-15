(* TODO Avoid concatenating in the next version *)
let add x y = x + y;;

module Tests = struct
  open OUnit
  let test1 test_ctxt = assert_equal 2 (add 1 1);;
  let suite = ["1+1 is 2" >:: test1];;
end
