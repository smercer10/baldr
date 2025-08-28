package main

import "core:fmt"

IMAGE_WIDTH :: 256
IMAGE_HEIGHT :: 256

main :: proc() {
	fmt.println("P3\n", IMAGE_WIDTH, " ", IMAGE_HEIGHT, "\n255", sep = "")

	for y in 0 ..< IMAGE_HEIGHT {
		for x in 0 ..< IMAGE_WIDTH {
			r := f32(x) / (IMAGE_WIDTH - 1)
			g := f32(y) / (IMAGE_HEIGHT - 1)
			b := 0.

			ir := int(255.999 * r)
			ig := int(255.999 * g)
			ib := int(255.999 * b)

			fmt.println(ir, ig, ib)
		}
	}
}
