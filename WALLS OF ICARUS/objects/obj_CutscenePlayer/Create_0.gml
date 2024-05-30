if(global.lightShardsCollected >= 4 && global.wasEnemeyKilled == false)
{
	if(!instance_exists(sq_GoodEnding))
	{
		layer_sequence_create("Instances", room_width / 2, room_height /2, sq_GoodEnding);
	}
}

if(global.lightShardsCollected < 4 && global.wasEnemeyKilled == false)
{
	if(!instance_exists(sq_NeutralEnding))
	{
		layer_sequence_create("Instances", room_width / 2, room_height /2, sq_NeutralEnding);
	}
}

if(global.wasEnemeyKilled == true)
{
	if(!instance_exists(sq_BadEnding))
	{
		layer_sequence_create("Instances", room_width / 2, room_height /2, sq_BadEnding);
	}
}