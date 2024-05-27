// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_nextRoom(){
	switch(room)
	{
		case rm_level1:
		room_goto(rm_level2);
		break;
		case rm_level2:
		room_goto(rm_level3);
		break;
		case rm_level3:
		room_goto(rm_level4);
		break;
		case rm_level4:
		room_goto(rm_endingCutscene);
		break;
		default:
		room_goto(rm_Title);
		break;
	}
}