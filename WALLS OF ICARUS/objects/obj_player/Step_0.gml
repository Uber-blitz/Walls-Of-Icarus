/// @description state machine run and other things

state();
if (debug)
{
	if (keyboard_check_pressed(vk_numpad0))
	{
		currPowerup = "none";
	}
	if (keyboard_check_pressed(vk_numpad1))
	{
		currPowerup = "earth";
	}
	if (keyboard_check_pressed(vk_numpad2))
	{
		currPowerup = "air";
	}
	if (keyboard_check_pressed(vk_numpad3))
	{
		currPowerup = "water";
	}
	if (keyboard_check_pressed(vk_numpad4))
	{
		currPowerup = "fire";
	}
	if (keyboard_check_pressed(ord("I")))
	{
		playerInvul = true;
		image_blend = c_yellow;
	}
}

if(keyboard_check_pressed(ord("P")))
{
	if(!debug)
	{
		debug = true;
	}
	else
	{
		debug = false;
	}
}

if(keyboard_check_pressed(ord("R")))
{
	room_restart();
}
