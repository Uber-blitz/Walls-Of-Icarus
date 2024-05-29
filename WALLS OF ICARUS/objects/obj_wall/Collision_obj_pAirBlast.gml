if(elementType == 2 && !obj_player.wallDestroyed)
{
	obj_player.playerInvul = true;
	obj_player.wallDestroyed = true;
	layer_sequence_create("Fade", camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), sq_WallDestroy);
	show_debug_message("Created flash at: " + string(obj_playerCam.x) + ", " + string(obj_playerCam.y));
}