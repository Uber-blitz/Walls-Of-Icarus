//check if element type isn't light (4)

if(elementType != 4)
{
	obj_player.powerShardCol ++;
	instance_destroy(self);
}
else
{
	global.lightShardsCollected ++;
	instance_destroy(self);
}