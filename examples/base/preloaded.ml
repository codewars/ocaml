open Base

let print_int_list = Fn.compose Sexp.to_string (sexp_of_list sexp_of_int)