//Hearts
for(var i = 0; i < obj_player.MaxHP; i ++)
{
	if(obj_player.HP - 1 >= i)
	{
		draw_sprite_ext(spr_hearts, 0, 10 * (i * 6) + 50, 10, 2, 2, 0, c_white, 1);
	}
	else
	{
		draw_sprite_ext(spr_hearts, 1, 10 * (i * 6) + 50, 10, 2, 2, 0, c_white, 1);
	}
	show_debug_message("Drew heart " + string(i));
}
//PowerUp Indicator
draw_sprite_ext(spr_pIndicator, 0, (view_wport[0] * 1.5) + 90, -5, 2, 2, 0, c_white, 1);
draw_set_font(fnt_uiText);
draw_text((view_wport[0] * 1.5) + 132.5, 120, string(obj_player.powerShardCol) + "/" + string(obj_player.neededPowerShard));
