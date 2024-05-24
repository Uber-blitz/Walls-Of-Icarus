/// @description Insert description here
// You can write your code in this editor
destroyHurtbox = function()
{
	instance_destroy();
}

destroyTimer = time_source_create(time_source_global, 1, time_source_units_frames, destroyHurtbox);
time_source_start(destroyTimer);
