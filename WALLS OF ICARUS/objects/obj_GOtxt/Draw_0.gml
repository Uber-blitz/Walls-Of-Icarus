/// @description draw text
// You can write your code in this editor

draw_set_font(fnt_gameOverText);
draw_set_halign(fa_center);

draw_text_color(room_width/2, (room_height/2) - 50, text1, c_white, c_white, c_white, c_white, 255);

if(opSelected = 1)
{
	draw_text_color(room_width/3, (room_height/2) + 50, yes, c_white, c_white, c_white, c_white, 255);
	draw_text_color((room_width/3)*2, (room_height/2) + 50, no, c_yellow, c_yellow, c_yellow, c_yellow, 255);
}
else
{
	draw_text_color(room_width/3, (room_height/2) + 50, yes, c_yellow, c_yellow, c_yellow, c_yellow, 255);
	draw_text_color((room_width/3)*2, (room_height/2) + 50, no, c_white, c_white, c_white, c_white, 255);
}