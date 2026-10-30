let lerp a b t = a +. ( b -. a ) *. t

let fade t = t *. t *. t *. (t *. (t *. 6. -. 15.) +. 10.)

let inverse_lerp a b v = (v -. a) /. (b -. a)

let clamp ?(min=0.) ?(max=1.) v =
  if v < min then min
  else if v > max then max
  else v

let remap v ~from_min ~from_max ~to_min ~to_max =
  let t = inverse_lerp from_min from_max v in
  lerp to_min to_max t

let smoothstep a b t =
  let t = clamp t in
  let t = t *. ( t *. ( 3. -. 2. *. t )) in
  lerp a b t

let smooterstep a b t =
  let t = clamp t ~min:0. ~max:1. in
  lerp a b (fade t)

let ease_in_quad a b t =
  let t = clamp t ~min:0. ~max:1. in
  let t = t *. t in
  lerp a b t

let ease_out_bounce a b t =
  let t = clamp t ~min:0. ~max:1. in
  let t = 
    if t < 1. /. 2.75 then
      7.5625 *. t *. t
    else if t < 2. /. 2.75 then
      let t = t -. (1.5 /. 2.75) in
      7.5625 *. t *. t +. 0.75
    else if t < 2.5 /. 2.75 then
      let t = t -. (2.25 /. 2.75) in
      7.5625 *. t *. t +. 0.9375
    else
      let t = t -. (2.625 /. 2.75) in
      7.5625 *. t *. t +. 0.984375
  in
  lerp a b t
