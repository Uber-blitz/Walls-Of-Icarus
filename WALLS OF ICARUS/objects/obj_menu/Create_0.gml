/// @description Set everything up
// You can write your code in this editor

var _sequenceFunction = function()
{
	if menuLevel == 0
	{
		menuLevel = 1;
	}
	else
	{
		menuLevel = 0;
	}
}

timeSource = time_source_create(time_source_game, 2, time_source_units_seconds,_sequenceFunction);

//Option variables
op_space = 50;

pos = 0;

fullscreen = false;

//Main Menu
option[0,0] = "START GAME";
option[0,1] = "SETTINGS";
option[0,2] = "QUIT TO DESKTOP";

//Settings Menu
option[1,0] = "FULLSCREEN";
option[1,1] = "CONTROLS";
option[1,2] = "BACK";

op_length = 0;

menuLevel = 0;

//Font
draw_set_font(fnt_Text);
