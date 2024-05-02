/// @description Insert description here
// You can write your code in this editor

//Get Inputs
upKey = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
downKey = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
acceptKey = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("X"));

op_length = array_length(option[menuLevel]);

pos += downKey - upKey;

if(pos >= op_length)
{
	pos = 0;
}
if(pos < 0)
{
	pos = op_length - 1;
}

//using options
if(acceptKey)
{
	switch(menuLevel)
	{
		case 0:
			switch(pos)
			{
				//Start Game
				case 0:
					room_goto_next();
				break;
				//Settings
				case 1:
					time_source_start(timeSource);
				break;
				//Quit Game
				case 2:
				game_end();
				break;
			}
		break;
		
		case 1:
			switch(pos)
			{
				//Fullscreen
				case 0:
				break;
				//Controls
				case 1:
				break;
				//Back
				case 2:
					time_source_start(timeSource);
				break;
			}
	}
}