shader_type canvas_item;

uniform vec4 in_color;

void fragment() {
	
	if(COLOR.a > 0.0){
		COLOR = mix(COLOR, in_color, 0);
	}
	
	
	
	//if(COLOR.a > 0.0){
		//COLOR = COLOR.bbba;
	//}
}
