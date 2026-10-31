
let test_rand () =
  (* Test Random Number Generation *)
  let white_noise = Noize.Rand.white_generator () in
  let r1 = white_noise () in
  let r2 = white_noise () in
  assert (r1 <> r2) (* Ensure different calls yield different results *)
