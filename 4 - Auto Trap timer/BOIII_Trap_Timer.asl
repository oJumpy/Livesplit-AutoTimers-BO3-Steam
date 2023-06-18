state("boiii", "blackops3")
{
	int levelTime : "blackops3.exe", 0xA5502C0;
	int round : "blackops3.exe", 0xA55BDEC;
	string13 currentMap : "blackops3.exe", 0x940C5E8;
	byte36 trapData : "blackops3.exe", 0xA55BDF1;
	int gum : "blackops3.exe", 0x1634C388
}

update
{
	print (current.gum.ToString("X2"));
	
	var data = new Dictionary<string, int>
	{
		{"bunker",     176},
		{"kinoft",       2},
		{"m8room",       3},
		{"camptrap",   280},
		{"comm",       147},
		{"doc",         49},
		{"fishing",     48},
		{"storage",    146},
		{"bridge",     145},
		{"jugtrap",    147},
		{"mkder",      146},
		{"doubletap",  153},
		{"speedcola",  154}
	};

	int byteOffset = 0;
	int bitMask = 0;
	
	foreach (string trapID in data.Keys)
	{
		if(settings[trapID])
		{
			byteOffset = data[trapID] / 8;
			bitMask = 0x80 >> data[trapID] % 8;
			break;
		}
	}
	
	if((old.trapData[byteOffset] & bitMask) < (current.trapData[byteOffset] & bitMask))
	{
		vars.trapStart = current.levelTime;
	}
}

gameTime
{
	string[] arrayMaps = {"zm_zod", "zm_factory", "zm_castle", "zm_island", 
		"zm_stalingrad", "zm_genesis", "zm_prototype", "zm_asylum", "zm_sumpf", 
		"zm_theater", "zm_cosmodrome", "zm_temple", "zm_moon", "zm_tomb"};
		
	if(Array.IndexOf(arrayMaps, current.currentMap) == -1 || current.round == 0 || current.levelTime - vars.trapStart >= 2020)
	{
		vars.trapStart = -2020;
		return TimeSpan.Zero;
	}
	
	return new TimeSpan(0, 0, 0, 0, (2020 - current.levelTime + vars.trapStart) * 50);
}

init
{
	vars.trapStart = -2020;
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

startup
{
	settings.Add("gk", false, "Gorod Krovi");
		settings.Add("bunker", false, "Bunker", "gk");
	
	settings.Add("kino", false, "Kino Der Toten");
		settings.Add("kinoft", false, "Crematorium", "kino");
		settings.Add("m8room", false, "West Balcony", "kino");
		
	settings.Add("rev", false, "Revelations");
		settings.Add("camptrap", false, "Verruckt Trap", "rev");
		
	settings.Add("shino", false, "Shi No Numa");
		settings.Add("comm", false, "Comm Room", "shino");
		settings.Add("doc", false, "Doctor's Quarters", "shino");
		settings.Add("fishing", false, "Fishing Hut", "shino");
		settings.Add("storage", false, "Storage", "shino");
		
	settings.Add("giant", false, "The Giant");
		settings.Add("bridge", false, "Bridge", "giant");
		settings.Add("jugtrap", false, "Juggernog", "giant");
		settings.Add("mkder", false, "Mule Kick", "giant");
		
	settings.Add("verruckt", false, "Verruckt");
		settings.Add("doubletap", false, "Double Tap", "verruckt");
		settings.Add("speedcola", false, "Speed Cola", "verruckt");
}