if(facingDir >= 0)
{
	facingDir = 1;
	image_xscale = 1;
	move_x = facingDir * fireballSpeed;
	if(place_meeting(x + 2, y, [collisionTiles, obj_wall]))
	{
		obj_player.powerupUsed = false;
		instance_create_layer(x, y, "Instances", obj_waterExplode);
		instance_destroy();
	}
	move_and_collide(move_x, 0, [collisionTiles, obj_wall]);
}
if(facingDir < 0)
{
	facingDir = -1;
	image_xscale = -1;
	move_x = facingDir * fireballSpeed;
	if(place_meeting(x - 2, y, [collisionTiles, obj_wall]))
	{
		obj_player.powerupUsed = false;
		instance_create_layer(x, y, "Instances", obj_waterExplode);
		instance_destroy();
	}
	move_and_collide(move_x, 0, [collisionTiles, obj_wall]);
}
if(image_index >= image_number - 1)
{
	image_index = 5;
}