if(!obj_player.playerInvul)
{
	if(!place_meeting(x, y+2, collisionTiles))
	{
		obj_player.state = obj_player.hurtState;
	}
}