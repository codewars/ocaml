let sum n = 
  if n = 0 then 
    0 
  else 
    n + sum (n - 1)