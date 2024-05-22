/// @description Insert description here
// You can write your code in this editor

//Variable Setup
sprites = [spr_golemIdle, spr_golemRun, spr_golemAttack, spr_golemHit, spr_golemDeath];
HP = 3;
MaxHP = 3;
moveSpeed = 4;

move_x = 0;
move_y = 0;
movingRight = 1;

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
}

attackingState = function()
{
}

hurtState = function()
{
}

deathState = function()
{
}

state = movingState;