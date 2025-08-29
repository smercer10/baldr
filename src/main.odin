package main

import "core:fmt"
import "core:math"
import "core:math/linalg"
import "core:os"

// Image
ASPECT_RATIO :: 16.0 / 9.0
IMAGE_WIDTH :: 256
IMAGE_HEIGHT :: IMAGE_WIDTH / ASPECT_RATIO

// Camera
FOCAL_LENGTH :: 1.0
VIEWPORT_HEIGHT :: 2.0
VIEWPORT_WIDTH :: VIEWPORT_HEIGHT * (f32(IMAGE_WIDTH) / IMAGE_HEIGHT)
CAMERA_CENTER :: Point3{0, 0, 0}
VIEWPORT_U :: Vector3{VIEWPORT_WIDTH, 0, 0}
VIEWPORT_V :: Vector3{0, -VIEWPORT_HEIGHT, 0}

Vector3 :: distinct [3]f32
Point3 :: Vector3
Color3 :: distinct Vector3

Ray :: struct {
    origin: Point3,
    direction: Vector3,
}

point_at :: proc (r: Ray, t: f32) -> Point3 {
    return r.origin + t * r.direction
}

ray_color :: proc(r: Ray) -> Color3 {
    unit_dir := linalg.normalize(r.direction)
    a := 0.5 * (unit_dir.y + 1.0)
    return (1.0 - a) * Color3{1.0, 1.0, 1.0} + a * Color3{0.5, 0.7, 1.0}
}

// Expects each color component to be in the range [0.0, 1.0]
write_ppm_pixel :: proc(pixel_color: Color3) {
	r := int(math.round(pixel_color.r * 255))
	g := int(math.round(pixel_color.g * 255))
	b := int(math.round(pixel_color.b * 255))
	fmt.println(r, g, b)
}

main :: proc() {
    pixel_delta_u := VIEWPORT_U / IMAGE_WIDTH
    pixel_delta_v := VIEWPORT_V / IMAGE_HEIGHT

    viewport_00 := CAMERA_CENTER - (VIEWPORT_U / 2) - (VIEWPORT_V / 2) - Vector3{0, 0, FOCAL_LENGTH}
    pixel_00 := viewport_00 + (pixel_delta_u + pixel_delta_v) / 2

	fmt.println("P3\n", IMAGE_WIDTH, " ", IMAGE_HEIGHT, "\n255", sep = "")

	for y in 0 ..< IMAGE_HEIGHT {
		fmt.fprintln(os.stderr, "Scanlines remaining:", IMAGE_HEIGHT - y)

		for x in 0 ..< IMAGE_WIDTH {
			pixel_center := pixel_00 + f32(x) * pixel_delta_u + f32(y) * pixel_delta_v
			ray_dir := pixel_center - CAMERA_CENTER
            r := Ray{CAMERA_CENTER, ray_dir}
            pixel_color := ray_color(r)
			write_ppm_pixel(pixel_color)
		}
	}

	fmt.fprintln(os.stderr, "Done.")
}
