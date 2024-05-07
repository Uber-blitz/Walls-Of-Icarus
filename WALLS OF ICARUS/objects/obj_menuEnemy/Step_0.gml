x -= 3;

if(x <= -10)
{
	instance_destroy(self)
}

if (sprite_index == spr_slimeDie || sprite_index == spr_skeletonDeath || sprite_index == spr_golemDeath || sprite_index == spr_batDeath)
{
	if (image_speed > 0)
	{
	    if (image_index > image_number - 1)
		{
			image_speed = 0;
		}
	}
}