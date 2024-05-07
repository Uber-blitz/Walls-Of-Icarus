acceptKey = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("X"));

playSequence = function()
{
	layer_sequence_headdir(sequence, seqdir_left);
	layer_sequence_play(sequence);
	time_source_start(timeSource);
}