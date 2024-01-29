state("BlackOps3") 
{
	int levelTime : 0xA5502C0;
	int round : 0xA55BDEC;
	string13 currentMap : 0x940C5E8;
}

update
{
	if(old.round != current.round)
	{
		vars.roundStart = current.levelTime;
	}
}

gameTime
{
	string[] arrayMaps = {"zm_zod", "zm_factory", "zm_castle", "zm_island", 
		"zm_stalingrad", "zm_genesis", "zm_prototype", "zm_asylum", "zm_sumpf", 
		"zm_theater", "zm_cosmodrome", "zm_temple", "zm_moon", "zm_tomb"};
		
	if(Array.IndexOf(arrayMaps, current.currentMap) == -1 || current.round == 0)
	{
		return TimeSpan.Zero;
	}
	
	return new TimeSpan(0, 0, 0, 0, (current.levelTime - vars.roundStart) * 50);
}

init
{
	vars.roundStart = current.levelTime;
	refreshRate = 100;
}

start
{
	return true;
}

isLoading
{
	return true;
}