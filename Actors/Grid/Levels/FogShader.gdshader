shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}



void fragment() {
	
	float n = 10.f;
	float d = 12.f;
	float a = 5.f;
	int c = 5;
	float r = 1.5f;
	// (d * d * pow(cos(a * UV.x), a) * pow(sin(a * UV.x), a))
		if(pow(UV.x - 0.5, 2) + pow(UV.y - 0.5, 2) < pow(r, 2)/n * abs(sin(TIME)) + 0.7 + pow(sin(4.0 * a * UV.x), 5) * pow(cos(4.0 * a * UV.x), 5))
		{
			COLOR += vec4(0,0,0,1.0);
		}
		else
		{
			COLOR = vec4(0,0, 0, 0);
		}
		
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
