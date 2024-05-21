/// @description Insert description here
// You can write your code in this editor

if(obj_player.image_xscale > 0)
{
	x = obj_player.x + 300;
}
else
{
	x = obj_player.x - 300;
}
y = obj_player.y;
if(keyboard_check(vk_up) || keyboard_check(ord("W")))
{
	y = obj_player.y - 150;
}

