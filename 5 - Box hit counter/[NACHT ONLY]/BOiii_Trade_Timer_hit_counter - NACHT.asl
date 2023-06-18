state("boiii", "blackops3")
{
    int levelTime : "blackops3.exe", 0xA5502C0;
    int round : "blackops3.exe", 0xA55BDEC;
    string13 currentMap : "blackops3.exe", 0x940C5E8;
    int box_hit : "blackops3.exe", 0x47CB2E4;
    string32 check_gun : "blackops3.exe", 0x1647B678;
}

reset
{
    if(current.box_hit > old.box_hit) return true;
    return false;
}

start
{
    return true;
}

isLoading
{
    return true;
}