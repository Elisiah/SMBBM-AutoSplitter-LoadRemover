// v1.0a -> Needs to be Tested Alot to make sure false positives dont arise
state("smbbm")
{
    int isNotLoading :  "cri_ware_unity.dll", 0x001A6688, 0x78;
    int updater : "GameAssembly.dll", 0x01BDB638, 0xB8, 0x0, 0x40, 0x60, 0x10;
}

init
{
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = true;
    vars.trigger = false;
}

update
{
    // Splits when the score is updated after level completion
    if ((current.updater >= old.updater + 100) && (current.updater < old.updater + 200))
    {
        vars.trigger = true;
    }
}

split
{
    if (vars.trigger == true)
    {
        vars.trigger = false;
        return true;
    }
}

isLoading
{
    return current.isNotLoading != 1;
}
