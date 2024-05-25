/// @description player control options
// You can write your code in this editor
if(keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("a")))
{
	opSelected --;
}
if(keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("d")))
{
	opSelected ++;
}

if (opSelected > 1)
{
	opSelected = 0;
}
if (opSelected < 0)
{
	opSelected = 1;
}

if(keyboard_check_pressed(vk_return))
{
	if(opSelected = 1)
	{
		room_goto(rm_Title);
	}
	if(opSelected = 0)
	{
		room_goto(obj_game.lastRoom);
	}
}