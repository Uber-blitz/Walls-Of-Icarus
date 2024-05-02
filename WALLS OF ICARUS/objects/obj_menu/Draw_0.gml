/// @description Insert description here
// You can write your code in this editor

//Draw options
draw_set_font(fnt_Text);
draw_set_valign(fa_middle);
draw_set_halign(fa_left);

for(var _i = 0; _i < op_length; _i++)
{
	var _c = c_white;
	if(pos == _i)
	{
		_c = c_yellow;
	}
	draw_text_color(x,y + op_space*_i, option[menuLevel,_i],_c,_c,_c,_c,1);
}