type easing =
  | Linear
  | EaseIn
  | EaseOut
  | EaseInOut

type curve =
  (* Standard power curves for accelerating (ease_in) or decelerating (ease_out). *)
  | Quad
  | Cubic
  | Quart
  (* Softer or more dramatic acceleration curves. *)
  | Sine
  | Exponential
  (* Fun, bouncy curves that overshoot their target slightly before settling down (great for UI pop-ups or cartoonish game feedback). *)
  | Elastic
  | Bounce
  | Back

