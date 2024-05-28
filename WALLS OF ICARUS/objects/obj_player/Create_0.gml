/// @description State Machine stuff and other variables to do with the player
#region variables
//Set up variables
sprites = [spr_playerIdle, spr_playerRun, spr_playerJump, spr_playerFall, spr_playerAttack, spr_playerAttack2, spr_playerHit, spr_playerDeath];
HP = 3;
MaxHP = 3;
moveSpeed = 6;
jumpSpeed = 16;
lastElementType = 0;
canBeHurt = true;
nextObject = 80;
powerupUsed = false;
playerInvul = false;
wallDestroyed = false;

//script to make player vulnerable again
makeVulnerable = function()
{
	canBeHurt = true;
}

makeVulnerableTimer = time_source_create(time_source_global, 3, time_source_units_seconds, makeVulnerable);

move_x = 0;
move_y = 0;
powerups = ["none", "earth", "air", "water", "fire"];
currPowerup = powerups[0];
powerShardCol = 0;
neededPowerShard = 6;

collisionTiles = layer_tilemap_get_id("TileCollider");
#endregion

#region States
//Set up states

if(!wallDestroyed)
{
	#region Idle State
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
			sprite_index = sprites[3];
			move_y += 1;
		}
		
		move_and_collide(move_x, move_y, [collisionTiles, obj_wall]);
	}
	#endregion
	#region Moving State
	movingState = function()
	{
		if(!wallDestroyed)
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
					sprite_index = sprites[2];
					move_y = -jumpSpeed;
				}
			}
			else if (move_y < 10)
			{
				sprite_index = sprites[3];
				move_y += 1;
			}
			
			move_and_collide(move_x, move_y, [collisionTiles, obj_wall]);
			
			if(move_x != 0)
			{
				image_xscale = sign(move_x);
			}
			else
			{
				state = idleState;
			}
		}
	}
	#endregion
	#region Attacking State
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
			if(!instance_exists(obj_pAttackHurtbox))
			{
				instance_create_layer(x, y, "Instances", obj_pAttackHurtbox);
			}
			switch(currPowerup)
			{
				//earth
				case "earth":
					if(!powerupUsed)
					{
						powerupUsed = true;
						time_source_start(firstPillar);
						time_source_start(secondPillar);
						time_source_start(thirdPillar);
					}
				break;
				//air
				case "air":
				break;
				//water
				case "water":
				if(!powerupUsed)
					{
						powerupUsed = true;
						instance_create_layer(x, y - 100, "Instances", obj_waterVortex,{facingDir : image_xscale});
					}
				break;
				//fire
				case "fire":
					if(!powerupUsed)
					{
						powerupUsed = true;
						instance_create_layer(x, y - 100, "Instances", obj_fireball,{facingDir : image_xscale});
					}
				break;
				//none
				default:
				break;
			}
		}
		if(!keyboard_check(ord("Z")) && !keyboard_check(ord("K")) && image_index >= image_number - 1)
		{
			state = idleState;
		}
	}
	#endregion
	#region Hurt State
	hurtState = function()
	{
		if(!playerInvul)
		{
			if(canBeHurt)
			{
				HP--;
				show_debug_message("Player got hurt");
				sprite_index = sprites[6];
				canBeHurt = false;
			}
			
			if(sprite_index == sprites[6] && image_index >= image_number - 1)
				{
					state = movingState;
					time_source_start(makeVulnerableTimer);
				}
			
			if(HP == 0)
			{
				state = deathState;
			}
		}
		if(playerInvul)
		{
			state = movingState;
		}
	}
	#endregion
	#region Death State
	deathState = function()
	{
		show_debug_message("Player is now dead");
		sprite_index = sprites[7];
		
		if (image_index + image_speed >= image_number)
		{
			image_speed = 0;
			layer_sequence_create("Fade", obj_playerCam.x - 50, obj_playerCam.y, sq_playerDieFade);
		}
	}
}
	#endregion

#region Gravity and Jumping
if(place_meeting(x, y + 2, collisionTiles))
{
	move_y = 0;
	show_debug_message("Grounded");
	
	if(keyboard_check(vk_up) || keyboard_check(ord("W")))
	{
		state = jumpingState;
	}
}
#endregion

#region Shards needed to power up
switch(room)
{
	case rm_level1:
	neededPowerShard = 5;
	break;
	case rm_level2:
	neededPowerShard = 5;
	break;
	case rm_level3:
	neededPowerShard = 5;
	break;
	case rm_level4:
	neededPowerShard = 5;
	break;
}
#endregion

#region Powerup time sources
//Time source Functions
spawnFirst = function()
{
	instance_create_layer(x + (image_xscale * (nextObject * 2)), y, "Instances", obj_pEarthAttack);
}
spawnSecond = function()
{
	instance_create_layer(x + (image_xscale * (nextObject * 3)), y, "Instances", obj_pEarthAttack);
}
spawnThird = function()
{
	instance_create_layer(x + (image_xscale * (nextObject * 4)), y, "Instances", obj_pEarthAttack);
	powerupUsed = false;
}

//Time sources
firstPillar =	time_source_create(time_source_global, 0, time_source_units_seconds, spawnFirst);
secondPillar =	time_source_create(time_source_global, 0.5, time_source_units_seconds, spawnSecond);
thirdPillar =	time_source_create(time_source_global, 1, time_source_units_seconds, spawnThird);
#endregion

state = idleState;
#endregion