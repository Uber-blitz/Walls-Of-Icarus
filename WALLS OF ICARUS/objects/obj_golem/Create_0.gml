/// @description Insert description here
// You can write your code in this editor

//Variable Setup
sprites = [spr_golemIdle, spr_golemRun, spr_golemAttack, spr_golemHit, spr_golemDeath];
HP = 3;
MaxHP = 3;
moveSpeed = 4;
canBeHurt = true;
nextObject = 80;
golemDir = 0;

move_x = 0;
move_y = 0;
movingRight = 1;

hasAttacked = false;
makeVulnerable = function()
{
	canBeHurt = true;
	state = movingState;
}
makeVulnerableTimer = time_source_create(time_source_global, 1, time_source_units_seconds, makeVulnerable);


collisionTiles = layer_tilemap_get_id("TileCollider");

//enemy states
movingState = function()
{
	sprite_index = sprites[1];
	if(movingRight == 1)
	{
		move_x = movingRight * moveSpeed;
		if((!place_meeting(x + 4, y + 2, collisionTiles) || place_meeting(x + 2, y, collisionTiles)))
		{
			show_debug_message("Now moving left");
			movingRight = -1;
		}
	}
	else
	{
		move_x = movingRight * moveSpeed;
		if((!place_meeting(x - 4, y + 2, collisionTiles) || place_meeting(x - 2, y, collisionTiles)))
		{
			show_debug_message("Now moving Right");
			movingRight = 1;
		}
	}
	
	if(place_meeting(x, y + 2, collisionTiles))
	{
		move_y = 0;
		show_debug_message("Grounded");
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
	
	//check for player in radius
	if (collision_circle(x, y, 80, obj_player, false, true))
	{
		state = attackingState;
		sprite_index = sprites[2];
	}
}

attackingState = function()
{
	if(!hasAttacked)
	{
		time_source_start(initialPillar);
		if(obj_wall.elementType == 3)
		{
			time_source_start(firstPillar);
			time_source_start(secondPillar);
			time_source_start(thirdPillar);
		}
		hasAttacked = true;
	}
	if(!instance_exists(obj_golemAttack) && !instance_exists(obj_golemAttackInit))
	{
		hasAttacked = false;
	}
	if(sprite_index == sprites[2] && image_index >= image_number - 1 && hasAttacked == false)
	{
			state = movingState;
	}
}

hurtState = function()
{
	if(canBeHurt)
	{
		HP --;
		sprite_index = sprites[3];
	}
	canBeHurt = false;
	
	show_debug_message("oochie owchy Golem");
	
	if(sprite_index == sprites[3] && image_index >= image_number - 1)
		{
			sprite_index = sprites[0];
			image_index = 1;
			time_source_start(makeVulnerableTimer);
		}
		
	if (HP <= 0)
	{
		state = deathState;
	}
}

deathState = function()
{
	sprite_index = sprites[4];
	
	if(sprite_index == sprites[4] && image_index >= image_number - 1)
		{
			instance_destroy();
		}
	
	global.wasEnemeyKilled = true;
}
//ts functions
spawnInit = function()
{
	instance_create_layer(x + (image_xscale * nextObject), y, "Instances", obj_golemAttackInit);
}
spawnFirst = function()
{
	instance_create_layer(x + (image_xscale * (nextObject * 2)), y, "Instances", obj_golemAttack);
}
spawnSecond = function()
{
	instance_create_layer(x + (image_xscale * (nextObject * 3)), y, "Instances", obj_golemAttack);
}
spawnThird = function()
{
	instance_create_layer(x + (image_xscale * (nextObject * 4)), y, "Instances", obj_golemAttack);
}
//timesources
initialPillar = time_source_create(time_source_global, 0.5, time_source_units_seconds, spawnInit);
firstPillar =	time_source_create(time_source_global, 1, time_source_units_seconds, spawnFirst);
secondPillar =	time_source_create(time_source_global, 1.5, time_source_units_seconds, spawnSecond);
thirdPillar =	time_source_create(time_source_global, 2, time_source_units_seconds, spawnThird);

state = movingState;