open Batteries

let sum n = 
  (1 -- n) 
  |> Enum.map (fun i -> Num.num_of_int i |> Num.int_of_num)
  |> Enum.sum