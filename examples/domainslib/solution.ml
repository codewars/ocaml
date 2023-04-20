(* Copied from https://github.com/kayceesrk/ocaml5-tutorial *)
module T = Domainslib.Task

let rec fib0 n = if n < 2 then 1 else fib0 (n - 1) + fib0 (n - 2)

let rec fib_par pool n =
  if n > 20 then begin
    let a = T.async pool (fun _ -> fib_par pool (n - 1)) in
    let b = T.async pool (fun _ -> fib_par pool (n - 2)) in
    T.await pool a + T.await pool b
  end else fib0 n

let fib num_domains n =
  let pool = T.setup_pool ~num_domains:(num_domains - 1) () in
  let res = T.run pool (fun _ -> fib_par pool n) in
  T.teardown_pool pool;
  res