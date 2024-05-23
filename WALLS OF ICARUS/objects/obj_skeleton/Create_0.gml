/// @description Insert description here
// You can write your code in this editor

//Variable Setup
sprites = [spr_skeletonIdle, spr_skeletonWalk, spr_skeletonAttack, spr_skeletonHit, spr_skeletonDeath];
HP = 3;
MaxHP = 3;
moveSpeed = 4;
canBeHurt = true;

move_x = 0;
move_y = 0;
movingRight = 1;

collisionTiles = layer_tilemap_get_id("TileCollider");
makeVulnerable = function()
{
	canBeHurt = true;
	state = movingState;
}
makeVulnerableTimer = time_source_create(time_source_global, 1, time_source_units_seconds, makeVulnerable);

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
	if(sprite_index == sprites[2] && image_index >= image_number - 1)
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
	
	show_debug_message("oochie owchy Skeleton");
	
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
	canBeHurt = false;
	sprite_index = sprites[4];
	
	if(sprite_index == sprites[4] && image_index >= image_number - 1)
		{
			instance_destroy();
		}
	
	global.wasEnemeyKilled = true;
}

state = movingState;