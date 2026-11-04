(* fractal bownian motion *)
let fbm ~noise ?(octaves = 4) ?(persistence = 0.5) ?(lacunarity = 2.0) x y =
  let rec loop i freq amp total max_amp =
    if i >= octaves then total /. max_amp
    else
      let n = noise (x *. freq) (y *. freq) in
      loop (i + 1) (freq *. lacunarity) (amp *. persistence)
        (total +. (n *. amp))
        (max_amp +. amp)
  in
  loop 0 1.0 1.0 0.0 0.0
