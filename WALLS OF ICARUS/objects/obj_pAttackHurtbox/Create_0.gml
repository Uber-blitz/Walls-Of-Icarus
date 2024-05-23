/// @description Insert description here
// You can write your code in this editor

if (obj_player.image_xscale == -1)
{
	x = obj_player.x - 80;
	y = obj_player.y;
}
if (obj_player.image_xscale == 1)
{
	x = obj_player.x + 80;
	y = obj_player.y;
}

destroyHurtbox = function()
{
	instance_destroy();
}

destroyTimer = time_source_create(time_source_global, 5, time_source_units_frames, destroyHurtbox);
time_source_start(destroyTimer);