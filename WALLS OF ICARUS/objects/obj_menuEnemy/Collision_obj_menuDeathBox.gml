switch(sprite_index)
{
	//slime
	case spr_slimeIdle:
		sprite_index = spr_slimeDie;
	break;
	//skeleton
	case spr_skeletonWalk:
		sprite_index = spr_skeletonDeath;
	break;
	//golem
	case spr_golemRun:
		sprite_index = spr_golemDeath;
	break;
	//bat
	case spr_batFly:
		sprite_index = spr_batDeath;
	break;
}

if(alive)
{
	obj_menuKnight.attacking = true;
	alive = false;
}
