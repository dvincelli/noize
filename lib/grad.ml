(* 1D Gradient: maps hash to a positive or negative slope *)
let grad1 h x =
  if (h land 1) = 0 then x else -.x

(* 2D Gradient: selects from 4 diagonal directions *)
let grad2 h x y =
  let h = h land 3 in
  let u = if (h land 1) = 0 then x else -.x in
  let v = if (h land 2) = 0 then y else -.y in
  u +. v

(* 3D Gradient: Ken Perlin's classic 12 edge directions *)
let grad3 h x y z =
  let h = h land 15 in
  let u = if h < 8 then x else y in
  let v = if h < 4 then y else if h = 12 || h = 14 then x else z in
  let u_sign = if (h land 1) = 0 then u else -.u in
  let v_sign = if (h land 2) = 0 then v else -.v in
  u_sign +. v_sign
