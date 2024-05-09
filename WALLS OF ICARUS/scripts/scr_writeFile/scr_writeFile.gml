// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_writeFile(){
	//Write To Save File
	ini_open("save.ini");
	ini_write_real("Flags", "Light Shards", global.lightShardsCollected);
	ini_write_real("Flags", "Enemy Killed", global.wasEnemeyKilled);
	ini_close();
}