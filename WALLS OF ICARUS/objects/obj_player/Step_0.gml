/// @description state machine run and other things

state();

if(place_meeting(x + 1, y, collisionTiles))
{
	hspeed = 0;
	x -= 1;
}
if(place_meeting(x - 1, y, collisionTiles))
{
	hspeed = 0;
	x += 1;
}
