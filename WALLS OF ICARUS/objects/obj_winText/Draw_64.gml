/// @description Insert description here
// You can write your code in this editor
if(!textCreated)
{
	layer_sequence_create("Fade", camera_get_view_x(view_camera[0]) + (view_wport[0]/2), camera_get_view_y(view_camera[0]) + (view_hport[0] / 2), sq_winAnnounce);
	textCreated = true;
}