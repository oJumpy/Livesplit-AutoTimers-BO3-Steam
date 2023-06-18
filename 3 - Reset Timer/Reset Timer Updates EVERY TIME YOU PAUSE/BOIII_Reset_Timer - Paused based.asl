state("boiii", "blackops3")
{
	int resetTime : "blackops3.exe", 0x176F9358;
	int levelTime : "blackops3.exe", 0xA5502C0;
	int round : "blackops3.exe", 0xA55BDEC;
	byte is_paused : "blackops3.exe", 0x347EE08; 
	string13 currentMap : "blackops3.exe", 0x940C5E8;
}

state("blackops3")
{
	int resetTime : 0x176F9358;
	int levelTime : 0xA5502C0;
	int round : 0xA55BDEC;
	byte is_paused : 0x347EE08; 
	string13 currentMap : 0x940C5E8;
}

update
{
	if(old.is_paused == 0 && current.is_paused == 1)
	{
		vars.elapsedTime = vars.startTime - current.levelTime;
		vars.elapsedReset = vars.startReset - current.resetTime;

		vars.startTime = current.levelTime;
		vars.startReset = current.resetTime;
	}
}

gameTime
{
	string[] arrayMaps = {"zm_zod", "zm_factory", "zm_castle", "zm_island", 
		"zm_stalingrad", "zm_genesis", "zm_prototype", "zm_asylum", "zm_sumpf", 
		"zm_theater", "zm_cosmodrome", "zm_temple", "zm_moon", "zm_tomb"};

	if(Array.IndexOf(arrayMaps, current.currentMap) == -1 || current.round == 0 || current.resetTime == 0)
	{
		return TimeSpan.Zero;
	}

	vars.resetPerTick = vars.elapsedReset / vars.elapsedTime;
	vars.ticksLeft = (2147483647.0 - current.resetTime) / vars.resetPerTick;
	return new TimeSpan(0, 0, 0, 0, (int)(vars.ticksLeft * 50));
}

init
{
	refreshRate = 50;
	vars.startTime = current.levelTime;
	vars.startReset = current.resetTime;
	
	vars.elapsedReset = 9999999;
	vars.elapsedTime = 1;
}

start
{
	return true;
}

isLoading
{
	return true;
}