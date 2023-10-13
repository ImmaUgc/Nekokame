// Converted/modified from ShaderToy: https://www.shadertoy.com/view/ldBXDD
// Attach this shader to a ColorRect

shader_type canvas_item;
void vertex() {
	VERTEX.x += sin(TIME * 4.0 + VERTEX.x * 6.0) * 0.1;
	VERTEX.x += VERTEX.x;
}