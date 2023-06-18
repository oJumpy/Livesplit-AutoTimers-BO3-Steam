state("boiii", "blackops3")
{
	int levelTime : "blackops3.exe", 0xA5502C0;
	int round : "blackops3.exe", 0xA55BDEC;
	string13 currentMap : "blackops3.exe", 0x940C5E8;
	byte36 trapData : "blackops3.exe", 0xA55BDF1;
	byte flogger : "blackops3.exe", 0x4713774;
}

update
{
	if(old.flogger > current.flogger )
	{
		game.WriteValue<UInt16>((IntPtr)vars.addr, (UInt16)current.levelTime);
		vars.trapStart = current.levelTime;
	}
}

gameTime
{
	string[] arrayMaps = {"zm_zod", "zm_factory", "zm_castle", "zm_island", 
		"zm_stalingrad", "zm_genesis", "zm_prototype", "zm_asylum", "zm_sumpf", 
		"zm_theater", "zm_cosmodrome", "zm_temple", "zm_moon", "zm_tomb"};
		
	if(Array.IndexOf(arrayMaps, current.currentMap) == -1 || current.round == 0 || current.levelTime - vars.trapStart >= 1540)
	{
		vars.trapStart = -1540;
		return TimeSpan.Zero;
	}
	
	return new TimeSpan(0, 0, 0, 0, (1540 - current.levelTime + vars.trapStart) * 50);
}

init
{
	vars.trapStart = -1540;
	refreshRate = 100;
	vars.addr = game.MainModule.BaseAddress + 0x4D18748;
	vars.fixedOffset = game.ReadValue<UInt16>((IntPtr)vars.addr);
}

start
{
	return true;
}

isLoading
{
	return true;
}