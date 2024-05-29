/// @description Insert description here
// You can write your code in this editor

if (obj_player.image_xscale == -1)
{
	image_xscale = -1;
	x = obj_player.x - 80;
	y = obj_player.y - 30;
}
if (obj_player.image_xscale == 1)
{
	image_xscale = 1;
	x = obj_player.x + 80;
	y = obj_player.y - 30;
}