vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
	vec4 pixel = Texel(texture, texture_coords );
	if(pixel.r < 0.65) {
		return vec4(0.193, 0.184, 0.158, pixel.a);
	} else {
		return vec4(0.747, 0.757, 0.743, pixel.a);
	}
}
