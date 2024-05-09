// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_readFile(){
	//Read Save Data
	ini_open("save.ini")
	global.lightShardsCollected = ini_read_real("Flags", "Light Shards", 0);
	global.wasEnemeyKilled = ini_read_real("Flags", "Enemy Killed", 0);
	ini_close();
}