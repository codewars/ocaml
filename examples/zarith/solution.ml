let fib_zarith n =
  let rec fib n a b =
    if n = 0 then a else fib (n - 1) b (Z.add a b) in
  Z.rem (fib n Z.zero Z.one) (Z.of_int 1000007)

let fib_num n =
  let open Big_int in
  let rec fib n a b =
    if n = 0 then a else fib (n - 1) b (add_big_int a b) in
  mod_big_int (fib n zero_big_int unit_big_int) (big_int_of_int 1000007)