let seed = 42

(* A seedable white noise generator with a closure for the random state. *)
let white_generator ?(seed = 42) () =
  let state = Random.State.make [| seed |] in
  fun () -> Random.State.float state 2.0 -. 1.0

(* a pre-seesed white noise generator using the global random state *)
let white = white_generator ()

(* A seedable brown noise generator using the cumulative sum of white noise. *)
let brown_generator ?(seed = 42) ?(leak = 0.997) () =
  let make_white_noise = white_generator ~seed () in
  let last_value = ref (make_white_noise ()) in
  fun () ->
    let new_value = (!last_value *. leak) +. make_white_noise () in
    last_value := new_value;
    new_value

(* A pre-seeded brown noise generator using the cumulative sum of white noise. *)
let brown = brown_generator ()

(* A highly efficient pink noise generator using Paul Kellet's IIR filter method *)
let pink_generator ?(seed = 42) () =
  let make_white = white_generator ~seed () in
  let b0 = ref 0.0 in
  let b1 = ref 0.0 in
  let b2 = ref 0.0 in
  let b3 = ref 0.0 in
  let b4 = ref 0.0 in
  let b5 = ref 0.0 in
  let b6 = ref 0.0 in
  fun () ->
    let white = make_white () in
    b0 := (0.99886 *. !b0) +. (white *. 0.0555179);
    b1 := (0.99332 *. !b1) +. (white *. 0.0750759);
    b2 := (0.96900 *. !b2) +. (white *. 0.1538520);
    b3 := (0.86650 *. !b3) +. (white *. 0.3104856);
    b4 := (0.55000 *. !b4) +. (white *. 0.5329522);
    b5 := (-0.7616 *. !b5) -. (white *. 0.0168980);
    let output =
      !b0 +. !b1 +. !b2 +. !b3 +. !b4 +. !b5 +. !b6 +. (white *. 0.5362)
    in
    b6 := white *. 0.115926;
    output *. 0.1 (* scale down to standard amplitude range *)

let pink = pink_generator ()

let lehmer_generator ?(seed = 42) ?(a = 48271l) ?(m = 2147483647l) () =
  let state = ref (Int32.of_int seed) in
  fun () ->
    let prod = Int32.mul !state a in
    let next = Int32.rem prod m in
    state := next;
    Int32.to_float !state /. Int32.to_float m

let lemher = lehmer_generator ()

let xorshift_generator ?(seed = 42) () =
  let state = ref (Int32.of_int seed) in
  fun () ->
    let x = !state in
    let x = Int32.logxor x (Int32.shift_left x 13) in
    let x = Int32.logxor x (Int32.shift_right x 17) in
    let x = Int32.logxor x (Int32.shift_left x 5) in
    state := x;
    Int32.to_float !state /. Int32.to_float Int32.max_int

let xorshift = xorshift_generator ()
let rec seq_of_noise f : float Seq.t = fun () -> Seq.Cons (f (), seq_of_noise f)
