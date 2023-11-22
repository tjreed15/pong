shader_type canvas_item;

float circle(vec2 position, float radius, float feather) {
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}


void fragment() {
	COLOR.rgb = vec3(circle(UV, 0.5, 0.005) );
}
