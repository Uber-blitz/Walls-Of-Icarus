sprites = [spr_batFly, spr_batAttack, spr_batHit, spr_batDeath];
HP = 3;
MaxHP = 3;
moveSpeed = 4;
canBeHurt = true;
nextObject = 80;

move_x = 0;
move_y = 0;
movingRight = 1;

hasAttacked = false;
collisionTiles = layer_tilemap_get_id("TileCollider");

resetAttackFunc = function()
{
	hasAttacked = false; 
	state = moveState;
}
makeVulnerable = function()
{
	canBeHurt = true;
	state = moveState;
}

resetAttack = time_source_create(time_source_global, 1, time_source_units_seconds, resetAttackFunc);
makeVulnerableTimer = time_source_create(time_source_global, 1, time_source_units_seconds, makeVulnerable);
moveState = function()
{
	sprite_index = sprites[0];
	if(movingRight == 1 && !place_meeting(x + 2, y, collisionTiles))
	{
		image_xscale = 1;
		move_x = movingRight * moveSpeed;
		move_y = 0;
	}
	if(movingRight == -1 && !place_meeting(x - 2, y, collisionTiles))
	{
		image_xscale = -1;
		move_x = movingRight * moveSpeed;
		move_y = 0;
	}
	if (collision_circle(x, y, 100, obj_player, false, true))
	{
		if (obj_player.x >= x)
		{
			image_xscale = 1;
			movingRight = 1;
			move_x = movingRight * moveSpeed;
		}
		else
		{
			image_xscale = -1;
			movingRight = -1;
			move_x = movingRight * moveSpeed;
		}
		
		if (obj_player.y - 30 >= y)
		{
			move_y = moveSpeed;
		}
		else
		{
			move_y = -moveSpeed
		}
		
		if(collision_rectangle(x - 50, y - 25, x + 50, y + 25, obj_player, false, true))
		{
			state = attackState;
		}
	}
	
	move_and_collide(move_x, move_y, collisionTiles);
}

attackState = function()
{
	move_y = 0;
	if (obj_player.x >= x && !hasAttacked)
		{
			image_xscale = 1;
			movingRight = 1;
			move_x = movingRight * (moveSpeed * 1.5);
		}
		else if (obj_player.x < x && !hasAttacked)
		{
			image_xscale = -1;
			movingRight = -1;
			move_x = movingRight * (moveSpeed * 1.5);
		}
		move_and_collide(move_x, move_y, collisionTiles);
	if (!hasAttacked)
	{
		sprite_index = sprites[1]
		hasAttacked = true;
	}
	if (sprite_index == sprites[1] && image_index >= image_number - 1)
	{
		sprite_index = sprites[0]
		time_source_start(resetAttack);
	}
}

hurtState = function()
{
	if(canBeHurt)
	{
		HP --;
		sprite_index = sprites[2];
	}
	canBeHurt = false;
	
	show_debug_message("oochie owchy Slime");
	
	if(sprite_index == sprites[2] && image_index >= image_number - 1)
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
	sprite_index = sprites[3];
	
	if(sprite_index == sprites[3] && image_index >= image_number - 1)
		{
			instance_destroy();
		}
	
	global.wasEnemeyKilled = true;
}

state = moveState;