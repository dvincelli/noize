let () =
  print_endline "Running Perlin noise tests...";

  (* 1. Test Determinism: Same inputs must yield identical outputs *)
  let a = Noize.Perlin.noise2 1.23 4.56 in
  let b = Noize.Perlin.noise2 1.23 4.56 in
  assert (a = b);

  (* 2. Test Non-Zero: Fractional inputs should produce active wave values *)
  let sample = Noize.Perlin.noise2 0.5 0.5 in
  assert (sample <> 0.0);

  (* 3. Test Bounds: Perlin noise should stay roughly within [-1.0, 1.0] *)
  assert (sample >= -1.0 && sample <= 1.0);

  (* 4. Test 1D and 3D dimensions run without crashing *)
  let _ = Noize.Perlin.noise1 1.5 in
  let _ = Noize.Perlin.noise3 1.0 2.0 3.0 in

  print_endline "All Perlin tests passed successfully!"
