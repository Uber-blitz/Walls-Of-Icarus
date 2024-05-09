/// @description State Machine stuff and other variables to do with the player
#region variables
//Set up variables
sprites = [spr_playerIdle, spr_playerRun, spr_playerJump, spr_playerFall, spr_playerAttack, spr_playerAttack2, spr_playerHit, spr_playerDeath];
HP = 3;
maxSpeed = 5;
drag = 0.5;
acceleration = 0.5;
powerups = ["none", "earth", "air", "water", "fire"];
currPowerup = powerups[0];
jumpRising = false;
#endregion

#region States
//Set up states
idleState = function()
{
	show_debug_message("Player is now idle");
	sprite_index = sprites[0];
	//Check if the player is pressing left, a, right, or d
	if(keyboard_check(vk_left) || keyboard_check(ord("A")) || keyboard_check(vk_right) || keyboard_check(ord("D")))
	{
		state = runningState; //put the player in the running state
	}
	//check if the player is pressing up, or w
	if(keyboard_check(vk_up) || keyboard_check(ord("W")))
	{
		state = jumpingState; //put the player in the jumping state
	}
	//check if the player is falling
	if(vspeed > 0)
	{
		state = fallingState; //put the player in the falling state
	}
	//check if player is pressing K, or Z
	if(keyboard_check(ord("K")) || keyboard_check(ord("Z")))
	{
		sprite_index = sprites[4];
		state = attackingState;//put the player in the attacking state
	}
}

runningState = function()
{
	show_debug_message("Player is now moving");
	sprite_index = sprites[1];
	//Test if player has stopped moving
	if(hspeed == 0 && vspeed == 0)
	{
		//Set players state to idle
		state = idleState;
	}
	//check if left is pressed
	if(keyboard_check(vk_left) || keyboard_check(ord("A")))
	{
		image_xscale = -1
		if (hspeed > -maxSpeed)
		{
			//Gradually increase speed in left direction
			hspeed -= acceleration;
		}
	}
	//check if right is pressed
	if(keyboard_check(vk_right) || keyboard_check(ord("D")))
	{
		image_xscale = 1;
		if (hspeed < maxSpeed)
		{
			//Gradually increase speed in right direction
			hspeed += acceleration;
		}
	}
	
	//If the player isn't pressing any of the movement keys, slow them down until they stop.
	if(!keyboard_check(vk_left) && !keyboard_check(ord("A")) && !keyboard_check(vk_right) && !keyboard_check(ord("D")))
	{
		if (hspeed > 0)
		{
			hspeed -= drag;
		}
		if (hspeed < 0)
		{
			hspeed += drag;
		}
	}
	
	if(keyboard_check(ord("K")) || keyboard_check(ord("Z")))
	{
		sprite_index = sprites[4];
		state = attackingState;//put the player in the attacking state
	}
}

jumpingState = function()
{
	if (place_meeting(x, y+vspeed, obj_wall))
	{
		while(!place_meeting(x, y+sign(vspeed), obj_wall))
		{
			y = y + sign(speed);
		}
		vspeed = 0;
	}
	
	y = y + vspeed;
}

fallingState = function()
{
	show_debug_message("Player is now falling");
	sprite_index = sprites[3];
	
	//Test if player has stopped moving
	if(hspeed == 0 && vspeed == 0)
	{
		//Set players state to idle
		state = idleState;
	}
}

attackingState = function()
{
	hspeed = 0;
	//If the player presses the attack buttons
	if(keyboard_check(ord("Z")) || keyboard_check(ord("K")))
	{
		show_debug_message("Entered Attack State");
		if(sprite_index == sprites[4] && image_index >= image_number - 1)
		{
			sprite_index = sprites[5];
		}
		if(sprite_index == sprites[5] && image_index >= image_number - 1)
		{
			sprite_index = sprites[4];
		}
	}
	if(!keyboard_check(ord("Z")) && !keyboard_check(ord("K")) && image_index >= image_number - 1)
	{
		hspeed = 0;
		state = idleState;
	}
}

hurtState = function()
{
	HP--;
	show_debug_message("Player got hurt");
	sprite_index = sprites[6];
	if(HP == 0)
	{
		state = deathState;
	}
}

deathState = function()
{
	show_debug_message("Player is now dead");
	sprite_index = sprites[7];
}

state = idleState;
#endregion