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
debug = false;

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
		//check if player is pressing K, or Z
		if(keyboard_check(ord("K")) || keyboard_check(ord("Z")))
		{
			sprite_index = sprites[4];
			state = attackingState;//put the player in the attacking state
		}
		
		if(place_meeting(x, y + 2, collisionTiles))//check if the player is grounde
		{
			show_debug_message("Grounded");
			move_y = 0;//stop the player falling
			
			if (keyboard_check(vk_up) || keyboard_check(ord("W")))//check if the player is pressing the jump buttons
			{
				show_debug_message("Jump Input")
				state = movingState;//put the player in the moving state
			}
		}
		else if (move_y < 10)//If the rising of the jump is less than 10
		{
			sprite_index = sprites[3];
			move_y += 1;// make the player fall
		}
		
		move_and_collide(move_x, move_y, [collisionTiles, obj_wall, obj_boundingBox]); //Move and collide with everything that needs collided with
	}
	#endregion
	#region Moving State
	movingState = function()
	{
		if(!wallDestroyed)
		{
			//if the wall isn't destroyed make sure that all the movement options are avalible to the player
			sprite_index = sprites[1];
			move_x = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
			//Get the movement direction and multiply it so the speed is correct.
			move_x = move_x * moveSpeed;
			
			if(place_meeting(x, y + 2, collisionTiles))//If the player is grounded
			{
				move_y = 0;//stop falling
				show_debug_message("Grounded");
				if (keyboard_check(vk_up) || keyboard_check(ord("W")))//While the player is grounded if they hit the jump button
				{
					sprite_index = sprites[2];
					move_y = -jumpSpeed; //Jump
				}
			}
			else if (move_y < 10)// if the speed of the jump is less than 10
			{
				sprite_index = sprites[3];
				move_y += 1; //fall
			}
			
			move_and_collide(move_x, move_y, [collisionTiles, obj_wall, obj_boundingBox]); // move and collide with everything that needs colliding with
			
			if(move_x != 0)//If player is moving
			{
				image_xscale = sign(move_x);//make the player face the correct direction
			}
			else//If the player isn't moving
			{
				state = idleState;//Make them idle
			}
		}
	}
	#endregion
	#region Attacking State
	attackingState = function()
	{
		//If the player presses the attack buttons
		if(keyboard_check(ord("Z")) || keyboard_check(ord("K")))// If the player presses the attack input
		{
			show_debug_message("Entered Attack State");
			if(sprite_index == sprites[4] && image_index >= image_number - 1)//If the player is at the end of the second sword swing, set it to the first
			{
				sprite_index = sprites[5];
				audio_play_sound(snd_SwordSwing, 1, false);//Play sword swing sound
			}
			if(sprite_index == sprites[5] && image_index >= image_number - 1)//If the player is at the end of the first sword swing, set it to the second
			{
				sprite_index = sprites[4];
				audio_play_sound(snd_SwordSwing, 1, false);//Play sword swing sound
			}
			if(!instance_exists(obj_pAttackHurtbox))//If the hurt box doesn't exist
			{
				instance_create_layer(x, y, "Instances", obj_pAttackHurtbox);//create the hurtbox
			}
			switch(currPowerup)//check the powerups
			{
				//earth
				case "earth":
					if(!powerupUsed)//if the powerup hasn't been used yet.
					{
						powerupUsed = true;
						time_source_start(firstPillar);//Spawn first pillar after 0.5 seconds
						time_source_start(secondPillar);//Spawn second pillar after 1 second
						time_source_start(thirdPillar);//Spawn third pillar after 1.5 seconds
					}
				break;
				//air
				case "air":
					if(!powerupUsed)//if the powerup hasn't been use yet
					{
						powerupUsed = true;
						instance_create_layer(x, y, "Instances", obj_pAirBlast);//create the air blast
					}
				break;
				//water
				case "water":
				if(!powerupUsed)//If the powerup hasn't been used yet
					{
						powerupUsed = true;
						instance_create_layer(x, y, "Instances", obj_waterVortex,{facingDir : image_xscale}); //create the water vortex and make it move the direction the player is facing
					}
				break;
				//fire
				case "fire":
					if(!powerupUsed)//If the powerup hasn't been used yet
					{
						powerupUsed = true;
						instance_create_layer(x, y - 50, "Instances", obj_fireball,{facingDir : image_xscale});//create the fireball and make it move the direction the player is facing
					}
				break;
				//none
				default:
				break;
			}
		}
		if(!keyboard_check(ord("Z")) && !keyboard_check(ord("K")) && image_index >= image_number - 1)//If the player isn't holding either attack button and is at the end of the attack animation, reset to idle
		{
			state = idleState;
		}
	}
	#endregion
	#region Hurt State
	hurtState = function()
	{
		if(!playerInvul)//If the player isn't invulnerable
		{
			if(canBeHurt)//If the player can be hurt
			{
				HP--; //Remove 1 heart
				show_debug_message("Player got hurt");
				sprite_index = sprites[6];//Set sprite to hurt sprite
				canBeHurt = false; //Make it so the player can constantly be hurt
			}
		
			if(sprite_index == sprites[6] && image_index >= image_number - 1)
				{
					state = movingState; //if player is at the end of the hurt animation, go to moving state
					time_source_start(makeVulnerableTimer);
				}
			
			if(HP == 0)//if player runs out of hearts
			{
				state = deathState;//kill player
			}
		}
		if(playerInvul)//If player is invulnerable
		{
			state = movingState;// put them back to the moving state.
		}
	}
	#endregion
	#region Death State
	deathState = function()//If the player is dead
	{
		show_debug_message("Player is now dead");
		sprite_index = sprites[7];//play death animation
		
		if (image_index + image_speed >= image_number)//at the end of the animation
		{
			image_speed = 0;//freeze the animation
			layer_sequence_create("Fade", camera_get_view_x(view_camera[0]) + 50, camera_get_view_y(view_camera[0] + 30), sq_playerDieFade);//fade out screen
		}
	}
}
	#endregion

#region Gravity and Jumping
if(place_meeting(x, y + 2, collisionTiles))
{
	move_y = 0;
	show_debug_message("Grounded");
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