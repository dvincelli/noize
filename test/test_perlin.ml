
let test_determinism () =
  (* 1. Test Determinism: Same inputs must yield identical outputs *)
  let a = Noize.Perlin.noise2 1.23 4.56 in
  let b = Noize.Perlin.noise2 1.23 4.56 in
  assert (a = b)

let test_active_wave_values () =
  (* 2. Test Non-Zero: Fractional inputs should produce active wave values *)
  let sample = Noize.Perlin.noise2 0.5 0.5 in
  assert (sample <> 0.0)

let test_edge_cases () =
  (* 3. Test Edge Cases: Check behavior at extreme values *)
  let extreme1 = Noize.Perlin.noise2 Float.max_float Float.max_float in
  let extreme2 = Noize.Perlin.noise2 Float.min_float Float.min_float in
  assert (extreme1 <> extreme2)

let test_perlin_1_and_3 () =
  (* 4. Test 1D and 3D dimensions run without crashing *)
  let x1 = Noize.Perlin.noise1 1.5 in
  print_endline ("1D Perlin noise output: " ^ string_of_float x1);
  assert (x1 <> 0.0);
  let x3 = Noize.Perlin.noise3 1.5 2.1 3.1 in
  print_endline ("3D Perlin noise output: " ^ string_of_float x3);
  assert (x3 <> 0.0)

let test_perlin () =
  print_endline "Running Perlin noise tests...";
  test_determinism ();
  test_active_wave_values ();
  test_edge_cases ();
  test_perlin_1_and_3 ();
  print_endline "All Perlin tests passed successfully!"

let _ =
  test_perlin ()
