let generate_perlin_ppm filename width height scale =
  let oc = open_out filename in
  Printf.fprintf oc "P3\n%d %d\n255\n" width height;
  
  for y = 0 to height - 1 do
    for x = 0 to width - 1 do
      (* Scale controls the zoom level of the noise *)
      let nx = float_of_int x /. scale in
      let ny = float_of_int y /. scale in
      
      let raw_noise = Noize.Perlin.noise2 nx ny in
      
      let normalized = (raw_noise +. 1.0) *. 0.5 in
      let intensity = int_of_float (255.0 *. max 0.0 (min 1.0 normalized)) in
      
      (* greyscale: R=G=B *)
      Printf.fprintf oc "%d %d %d\n" intensity intensity intensity
    done
  done;
  close_out oc;
  Printf.printf "Generated %s successfully!\n" filename

let () =
  generate_perlin_ppm "perlin_test.ppm" 512 512 64.0
