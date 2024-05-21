if(lastElementType == other.elementType && powerShardCol >= neededPowerShard && other.elementType != 4)
{
	switch(lastElementType)
	{
		case 0:
		currPowerup = powerups[4];
		break;
		case 1:
		currPowerup = powerups[3];
		break;
		case 2:
		currPowerup = powerups[2];
		break;
		case 3:
		currPowerup = powerups[1];
		break;
		default:
		currPowerup = powerups[0];
		break;
	}
}