/// @description State Machine stuff and other variables to do with the player
#region variables
//Set up variables
sprites = [spr_playerIdle, spr_playerRun, spr_playerJump, spr_playerFall, spr_playerAttack, spr_playerAttack2, spr_playerHit, spr_playerDeath];
HP = 3;
moveSpeed = 6;
jumpSpeed = 16;

move_x = 0;
move_y = 0;
powerups = ["none", "earth", "air", "water", "fire"];
currPowerup = powerups[0];
jumpRising = false;

collisionTiles = layer_tilemap_get_id("TileCollider");
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
		show_debug_message("Move Input");
		state = movingState; //put the player in the running state
	}
	//check if the player is pressing up, or w
	//check if the player is falling
	//check if player is pressing K, or Z
	if(keyboard_check(ord("K")) || keyboard_check(ord("Z")))
	{
		sprite_index = sprites[4];
		state = attackingState;//put the player in the attacking state
	}
	
	if(place_meeting(x, y + 2, collisionTiles))
	{
		show_debug_message("Grounded");
		move_y = 0;
		
		if (keyboard_check(vk_up) || keyboard_check(ord("W")))
		{
			show_debug_message("Jump Input")
			state = movingState;
		}
	}
	else if (move_y < 10)
	{
		move_y += 1;
	}
	
	move_and_collide(move_x, move_y, collisionTiles);
}

movingState = function()
{
	sprite_index = sprites[1];
	move_x = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
	move_x = move_x * moveSpeed;
	
	if(place_meeting(x, y + 2, collisionTiles))
	{
		move_y = 0;
		show_debug_message("Grounded");
		if (keyboard_check(vk_up) || keyboard_check(ord("W")))
		{
			move_y = -jumpSpeed;
		}
	}
	else if (move_y < 10)
	{
		move_y += 1;
	}
	
	move_and_collide(move_x, move_y, collisionTiles);
	
	if(move_x != 0)
	{
		image_xscale = sign(move_x);
	}
	else
	{
		state = idleState;
	}
}

fallingState = function()
{
	
}

attackingState = function()
{
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

if(place_meeting(x, y + 2, collisionTiles))
{
	move_y = 0;
	show_debug_message("Grounded");
	
	if(keyboard_check(vk_up) || keyboard_check(ord("W")))
	{
		state = jumpingState;
	}
}

state = idleState;
#endregion