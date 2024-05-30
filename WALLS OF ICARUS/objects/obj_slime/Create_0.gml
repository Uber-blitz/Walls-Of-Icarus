/// @description Insert description here
// You can write your code in this editor

//Variable Setup
sprites = [spr_slimeIdle, spr_slimeHurt, spr_slimeDie];
HP = 1;
MaxHP = 1;
moveSpeed = 6;
canBeHurt = true;
jumpSpeed = 16;

move_x = 0;
move_y = 0;
movingRight = 1;

randomBounce = random_range(1, 5);
bounceDir = random_range(0, 1);
bounced = false;

collisionTiles = layer_tilemap_get_id("TileCollider");
makeVulnerable = function()
{
	canBeHurt = true;
	state = movingState;
}
bounceFunc = function()
{
	randomBounce = random_range(1, 5);
	bounceDir = random_range(-1, 1);
	if(place_meeting(x, y+2, collisionTiles))
	{
		bounced = false;
		if(instance_exists(obj_wall) && obj_wall.elementType == 1)
		{
			instance_create_layer(x, y, "Instances", obj_slimeWaterVort, {facingDir : image_xscale});
		}
		move_y = -jumpSpeed;
		move_and_collide(move_x, move_y, collisionTiles);
		show_debug_message("Slime should be in the air");
	}
	move_and_collide(move_x, move_y, collisionTiles);
}

bounceTimer = time_source_create(time_source_global, 1, time_source_units_seconds, bounceFunc);
makeVulnerableTimer = time_source_create(time_source_global, 1, time_source_units_seconds, makeVulnerable);

//enemy states
movingState = function()
{
	sprite_index = sprites[0];
	if(!bounced)
	{
		if(bounceDir >= 0 && !place_meeting(x, y+2, collisionTiles))
		{
			bounceDir = 1;
			move_x = bounceDir * moveSpeed;
			move_y += 1;
		}
		if(bounceDir < 0 && !place_meeting(x, y+2, collisionTiles))
		{
			bounceDir = -1;
			move_x = bounceDir * moveSpeed;
			move_y += 1;
		}
		if(place_meeting(x, y+2, collisionTiles))
		{
			time_source_start(bounceTimer);
			bounced = true;
			show_debug_message("started bounce timer");
		}
		
		move_and_collide(move_x, move_y, collisionTiles);
	}
}

hurtState = function()
{
	if(canBeHurt)
	{
		HP --;
		sprite_index = sprites[1];
	}
	canBeHurt = false;
	
	show_debug_message("oochie owchy Slime");
	
	if(sprite_index == sprites[1] && image_index >= image_number - 1)
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
	sprite_index = sprites[2];
	
	if(sprite_index == sprites[2] && image_index >= image_number - 1)
		{
			instance_destroy();
		}
	
	global.wasEnemeyKilled = true;
}

state = movingState;