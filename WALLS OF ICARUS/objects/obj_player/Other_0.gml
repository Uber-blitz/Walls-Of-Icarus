if(y > 800)
{
	y = 100;
	HP --;
	if(HP <= 0)
	{
		state = deathState;
	}
}