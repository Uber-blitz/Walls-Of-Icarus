var _playSequence = function()
{
	layer_sequence_headdir(sequence, seqdir_right);
	layer_sequence_play(sequence);
}

sequence = layer_sequence_create("Assets_1", 96, 288, sq_menuOptions);
timeSource = time_source_create(time_source_game, 2, time_source_units_seconds,_playSequence)