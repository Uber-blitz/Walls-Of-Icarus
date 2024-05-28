if(elementType == 1 && !obj_player.wallDestroyed)
{
	obj_player.playerInvul = true;
	obj_player.wallDestroyed = true;
	layer_sequence_create("Fade", obj_playerCam.x - 50, obj_playerCam.y, sq_WallDestroy);
	show_debug_message("Created flash at: " + string(obj_playerCam.x) + ", " + string(obj_playerCam.y));
}