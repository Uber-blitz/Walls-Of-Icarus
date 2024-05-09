spawnMenuEnemy = function()
{
	if(room == rm_Title)
	{
		instance_create_layer(room_width+100, room_height+5, "Instances", obj_menuEnemy);
		time_source_start(spawnTimer);
		show_debug_message("Menu Enemy Spawned Again");
	}
}

spawnTimer = time_source_create(time_source_global, 4, time_source_units_seconds, spawnMenuEnemy)
time_source_start(spawnTimer);
show_debug_message("Menu Enemy Spawned For First Time");