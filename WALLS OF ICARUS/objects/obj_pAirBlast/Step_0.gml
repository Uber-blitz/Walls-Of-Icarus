if (obj_player.image_xscale == -1)
{
	x = obj_player.x - 80;
	y = obj_player.y - 30;
}
if (obj_player.image_xscale == 1)
{
	x = obj_player.x + 80;
	y = obj_player.y - 30;
}

if(image_index >= image_number - 1)
{
	obj_player.powerupUsed = false;
	instance_destroy();
}