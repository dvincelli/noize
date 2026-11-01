open Stdlib

let test_white () =
  let w1 = Noize.Rand.white () in
  let w2 = Noize.Rand.white () in
  assert (w1 <> w2)

let test_brown () =
  let b1 = Noize.Rand.brown () in
  let b2 = Noize.Rand.brown () in
  assert (b1 <> b2)

let test_pink () =
  let p1 = Noize.Rand.pink () in
  let p2 = Noize.Rand.pink () in
  assert (p1 <> p2)

let test_white_noise_generator () =
  (* Test Random Number Generation *)
  let white_noise = Noize.Rand.white_generator () in
  let r1 = white_noise () in
  let r2 = white_noise () in
  assert (r1 <> r2)

let test_brown_noise_generator () =
  let brown_noise = Noize.Rand.brown_generator () in
  let r1 = brown_noise () in
  let r2 = brown_noise () in
  assert (r1 <> r2)

let test_pink_noise_generator () =
  let pink_noise = Noize.Rand.pink_generator () in
  let r1 = pink_noise () in
  let r2 = pink_noise () in
  assert (r1 <> r2)

let test_lehmer_generator () =
  let lehmer = Noize.Rand.lehmer_generator () in
  let r1 = lehmer () in
  let r2 = lehmer () in
  assert (r1 <> r2)

let test_lehmer () =
  let r1 = Noize.Rand.lemher () in
  let r2 = Noize.Rand.lemher () in
  assert (r1 <> r2)

let test_xorshift_generator () =
  let xorshift = Noize.Rand.xorshift_generator () in
  let r1 = xorshift () in
  let r2 = xorshift () in
  assert (r1 <> r2)

let test_xorshift () =
  let r1 = Noize.Rand.xorshift () in
  let r2 = Noize.Rand.xorshift () in
  assert (r1 <> r2)

let test_seq_of_noise () =
  let l =
    Noize.Rand.seq_of_noise Noize.Rand.white |> Seq.take 5 |> Array.of_seq
  in
  assert (l.(0) <> l.(1));
  assert (l.(1) <> l.(2));
  assert (l.(2) <> l.(3));
  assert (l.(3) <> l.(4));
  assert (Array.length l = 5)

let () =
  test_white ();
  test_brown ();
  test_pink ();
  test_lehmer ();
  test_white_noise_generator ();
  test_pink_noise_generator ();
  test_brown_noise_generator ();
  test_lehmer_generator ();
  test_seq_of_noise ();
  print_endline "All tests passed!"
