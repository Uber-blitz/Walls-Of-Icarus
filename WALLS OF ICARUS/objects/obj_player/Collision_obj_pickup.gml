if(lastElementType == other.elementType && powerShardCol >= neededPowerShard - 1)
{
	show_debug_message("Changing the powerup of the player");
	switch(lastElementType)
	{
		case 0:
		currPowerup = powerups[4];
		show_debug_message("Powerup now set to" + currPowerup);
		break;
		case 1:
		currPowerup = powerups[3];
		show_debug_message("Powerup now set to" + currPowerup);
		break;
		case 2:
		currPowerup = powerups[2];
		show_debug_message("Powerup now set to" + currPowerup);
		break;
		case 3:
		currPowerup = powerups[1];
		show_debug_message("Powerup now set to" + currPowerup);
		break;
		default:
		currPowerup = powerups[0];
		show_debug_message("Powerup now set to" + currPowerup);
		break;
	}
}
else if (other.elementType != 4 && lastElementType != other.elementType)
{
	show_debug_message("Replacing the current collected powerup.");
	lastElementType = other.elementType;
}