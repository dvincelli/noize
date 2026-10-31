let permutation = [|
  151; 160; 137;  91;  90;  15; 131;  13; 201;  95;  96;  53; 194; 233;   7; 22;
  140;  36; 103;  30;  69; 142;   8;  99;  37; 240;  21;  10;  23; 190;   6; 148;
  247; 120; 234;  75;   0;  26; 197;  62;  94; 252; 219; 203; 117;  35;  11;  32;
   57; 177;  33;  88; 237; 149;  56;  87; 174;  20; 125; 136; 171; 168;  68; 175; 
   74; 165;  71; 134; 139;  48;  27; 166;  77; 146; 158; 231;  83; 111; 229; 122;
   60; 211; 133; 230; 220; 105;  92;  41;  55;  46; 245;  40; 244; 102; 143;  54; 
   65;  25;  63; 161;   1; 216;  80;  73; 209;  76; 132; 187; 208;  89;  18; 169; 
  200; 196; 135; 130; 116; 188; 159;  86; 164; 100; 109; 198; 173; 186;   3;  64; 
   52; 217; 226; 250; 124; 123;   5; 202;  38; 147; 118; 126; 255;  82;  85; 212; 
  207; 206;  59; 227;  47;  16;  58;  17; 182; 189;  28;  42; 223; 183; 170; 213; 
  119; 248; 152;   2;  44; 154; 163;  70; 221; 153; 101; 155; 167;  43; 172;   9; 
  129;  22;  39; 253;  19;  98; 108; 110;  79; 113; 224; 232; 178; 185; 112; 104; 
  218; 246;  97; 228; 251;  34; 242; 193; 238; 210; 144;  12; 191; 179; 162; 241; 
   81;  51; 145; 235; 249;  14; 239; 107;  49; 192; 214;  31; 181; 199; 106; 157; 
  184;  84; 204; 176; 115; 121;  50;  45; 127;   4; 150; 254; 138; 236; 205;  93; 
  222; 114;  67;  29;  24;  72; 243; 141; 128; 195;  78;  66; 215;  61; 156; 180  
|]

let p = Array.append permutation permutation

let hash x y z =
  let xi = x land 255 in
  let yi = y land 255 in
  let zi = z land 255 in
  p.(p.(p.(xi) + yi) + zi)

let noise1 x = let x_ = int_of_float (floor x) land 255 in
  let x = x -. floor x in (* fractional part *)
  let u = Interpol.fade x in
  (* Hash the two surrounding grid points *)
  let h0 = p.(x_) in
  let h1 = p.(x_ + 1) in
  (* Compute gradient contributions *)
  let g0 = Grad.grad1 h0 x in
  let g1 = Grad.grad1 h1 (x -. 1.0) in
  (* Interpolate between them *)
  Interpol.lerp g0 g1 u

let noise2 x y = let x_ = int_of_float (floor x) land 255 in
  let y_ = int_of_float (floor y) land 255 in
  let x = x -. floor x in
  let y = y -. floor y in
  let u = Interpol.fade x in
  let v = Interpol.fade y in
  (* Hash the four surrounding grid points *)
  let h00 = hash x_ y_ 0 in
  let h01 = hash x_ (y_ + 1) 0 in
  let h10 = hash (x_ + 1) y_ 0 in
  let h11 = hash (x_ + 1) (y_ + 1) 0 in
  (* Compute gradient contributions *)
  let g00 = Grad.grad2 h00 x y in
  let g01 = Grad.grad2 h01 x (y -. 1.0) in
  let g10 = Grad.grad2 h10 (x -. 1.0) y in
  let g11 = Grad.grad2 h11 (x -. 1.0) (y -. 1.0) in
  (* Interpolate between them *)
  let nx0 = Interpol.lerp g00 g10 u in
  let nx1 = Interpol.lerp g01 g11 u in
  Interpol.lerp nx0 nx1 v

let noise3 x y z = let x_ = int_of_float (floor x) land 255 in
  let y_ = int_of_float (floor y) land 255 in
  let z_ = int_of_float (floor z) land 255 in
  let x = x -. floor x in
  let y = y -. floor y in
  let z = z -. floor z in
  let u = Interpol.fade x in
  let v = Interpol.fade y in
  let w = Interpol.fade z in
  (* Hash the eight surrounding grid points *)
  let h000 = hash x_ y_ z_ in
  let h001 = hash x_ y_ (z_ + 1) in
  let h010 = hash x_ (y_ + 1) z_ in
  let h011 = hash x_ (y_ + 1) (z_ + 1) in
  let h100 = hash (x_ + 1) y_ z_ in
  let h101 = hash (x_ + 1) y_ (z_ + 1) in
  let h110 = hash (x_ + 1) (y_ + 1) z_ in
  let h111 = hash (x_ + 1) (y_ + 1) (z_ + 1) in
  (* Compute gradient contributions *)
  let g000 = Grad.grad3 h000 x y z in
  let g001 = Grad.grad3 h001 x y (z -. 1.0) in
  let g010 = Grad.grad3 h010 x (y -. 1.0) z in
  let g011 = Grad.grad3 h011 x (y -. 1.0) (z -. 1.0) in
  let g100 = Grad.grad3 h100 (x -. 1.0) y z in
  let g101 = Grad.grad3 h101 (x -. 1.0) y (z -. 1.0) in
  let g110 = Grad.grad3 h110 (x -. 1.0) (y -. 1.0) z in
  let g111 = Grad.grad3 h111 (x -. 1.0) (y -. 1.0) (z -. 1.0) in
  (* Interpolate between them *)
  let nx00 = Interpol.lerp g000 g100 u in
  let nx01 = Interpol.lerp g001 g101 u in
  let nx10 = Interpol.lerp g010 g110 u in
  let nx11 = Interpol.lerp g011 g111 u in
  let nxy0 = Interpol.lerp nx00 nx10 v in
  let nxy1 = Interpol.lerp nx01 nx11 v in
  Interpol.lerp nxy0 nxy1 w

