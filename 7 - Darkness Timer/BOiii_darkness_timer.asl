state("BlackOps3") 
{
	int levelTime : 0x10B315E4;
	int round : 0xA55BDEC;
	string13 currentMap : 0x940C5E8;
}

update
{
	vars.trueTime = current.levelTime - vars.fixedOffset;
}

gameTime
{
	return new TimeSpan(0, 0, 0, 0, vars.trueTime * 50);
}

init
{
	refreshRate = 100;
	vars.addr = game.MainModule.BaseAddress + 0x10;
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