if(facingDir >= 0)
{
	facingDir = 1;
	image_xscale = 1;
	move_x = facingDir * fireballSpeed;
	if(place_meeting(x + 2, y, [collisionTiles, obj_wall]))
	{
		instance_create_layer(x, y, "Instances", obj_skeletonExplode);
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
		instance_create_layer(x, y, "Instances", obj_skeletonExplode);
		instance_destroy();
	}
	move_and_collide(move_x, 0, [collisionTiles, obj_wall]);
}