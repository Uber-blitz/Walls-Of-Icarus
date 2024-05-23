nextObject = 10;
objectInSequence = 3;
collisionTiles = layer_tilemap_get_id("TileCollider");

spawnNextObject = function()
{
	if(place_meeting(x + (other.image_xscale * nextObject), y - 2, collisionTiles) && objectInSequence >= 0)
	{
		instance_create_layer(x + (other.image_xscale * nextObject), y, "Instances", obj_golemAttack, objectInSequence = objectInSequence - 1);
	}
}