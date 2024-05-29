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

//PowerUp in Indicator
switch(obj_player.currPowerup)
{
	case "none":
		
	break;
	case "earth":
		draw_sprite_ext(spr_powerupIco, 0, (view_wport[0] * 1.5) + 122.5, 26.5, 4, 4, 0, c_white, 1);
	break;
	case "air":
		draw_sprite_ext(spr_powerupIco, 1, (view_wport[0] * 1.5) + 122.5, 26.5, 4, 4, 0, c_white, 1);
	break;
	case "water":
		draw_sprite_ext(spr_powerupIco, 2, (view_wport[0] * 1.5) + 122.5, 26.5, 4, 4, 0, c_white, 1);
	break;
	case "fire":
		draw_sprite_ext(spr_powerupIco, 3, (view_wport[0] * 1.5) + 122.5, 26.5, 4, 4, 0, c_white, 1);
	break;
}

if (obj_player.debug)
{
	draw_text_ext((view_wport[0] / 2), view_hport[0] / 10, "DEBUG ENABLED", 3, 300);
}