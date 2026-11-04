let test_fbm () =
  let x =
    Noize.Fractal.fbm ~noise:Noize.Perlin.noise2 ~octaves:5 ~lacunarity:2.0
      ~persistence:0.5 0.5 0.5
  in
  assert (x <> 0.)

let () = test_fbm ()
