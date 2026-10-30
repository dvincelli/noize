module type S = sig
  val noise1 : float -> float
  val noise2 : float -> float -> float
  val noise3 : float -> float -> float -> float
end
