// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createWinText(){
	show_debug_message("Text Created at: " + string(camera_get_view_x(view_camera[0])) + " " +string(camera_get_view_y(view_camera[0])));
	instance_create_layer(0,0, "Instances", obj_winText);
}