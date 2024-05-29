if (enemyInstance.image_xscale == -1)
{
	image_xscale = -1;
	x = enemyInstance.x - 80;
	y = enemyInstance.y - 30;
}
if (enemyInstance.image_xscale == 1)
{
	image_xscale = 1;
	x = enemyInstance.x;
	y = enemyInstance.y - 30;
}

if(image_index >= image_number - 1)
{
	instance_destroy();
}