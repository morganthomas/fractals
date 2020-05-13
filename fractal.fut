type complex = { re: f32, im: f32 }

let c_plus (a: complex) (b: complex): complex
  = { re = a.re + b.re, im = a.im + b.im }

let c_times (a: complex) (b: complex): complex
  = { re = a.re * b.re - a.im * b.im
    , im = a.re * b.im + a.im * b.re }

let c_square (a: complex): complex = c_times a a

let c_magnitude (a: complex): f32 = f32.sqrt (a.re * a.re + a.im * a.im)

let c_zero: complex = { re = 0, im = 0 }

-- Mandelbrot set in black & white based on testing midpoints, no interpolation
module mandelbrot = {
  let f (c: complex) (z: complex): complex = c_plus (c_square z) c

  let max_iterations: i32 = 1000
  let converges (c: complex): bool =
    c_magnitude (loop (i, z) = (0, c_zero)
		 while i < max_iterations && c_magnitude z < 2
		 do (i+1, f c z)).1
      < 2

  let boolmap (h: i32) (w: i32): [h][w]bool
    = let min_re: f32 = -2
      let max_re: f32 = 1
      let min_im: f32 = -1
      let max_im: f32 = 1
      -- Inverse of the projection of the complex plane onto the bitmap
      let inverse_project (x: f32) (y: f32): complex =
	{ re = min_re + x * ((max_re - min_re) / f32.i32 w)
	, im = min_im + y * ((max_im - min_im) / f32.i32 h) }
      in map (\i ->
		map (\j ->
		       let midpoint = inverse_project (f32.i32 i + 0.5) (f32.i32 j + 0.5)
		       in converges midpoint)
		    (0..<w) :> [w]bool)
	     (0..<h) :> [h][w]bool
}

let main: [2048][2048]bool = mandelbrot.boolmap 2048 2048
