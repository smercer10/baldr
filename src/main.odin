package main

import "core:fmt"
import "core:math"
import "core:os"

IMAGE_WIDTH :: 256
IMAGE_HEIGHT :: 256

Vec3 :: distinct [3]f32
Color :: distinct Vec3

// Expects each color component to be in the range [0.0, 1.0]
write_ppm_pixel :: proc(pixel_color: Color) {
	r := int(math.round(pixel_color.r * 255))
	g := int(math.round(pixel_color.g * 255))
	b := int(math.round(pixel_color.b * 255))
	fmt.println(r, g, b)
}

main :: proc() {
	fmt.println("P3\n", IMAGE_WIDTH, " ", IMAGE_HEIGHT, "\n255", sep = "")

	for y in 0 ..< IMAGE_HEIGHT {
		fmt.fprintln(os.stderr, "Scanlines remaining:", IMAGE_HEIGHT - y)

		for x in 0 ..< IMAGE_WIDTH {
			pixel_color := Color{f32(x) / (IMAGE_WIDTH - 1), f32(y) / (IMAGE_HEIGHT - 1), 0}
			write_ppm_pixel(pixel_color)
		}
	}

	fmt.fprintln(os.stderr, "Done.")
}
