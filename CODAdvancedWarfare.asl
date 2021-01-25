// Asl written by KunoDemetries#6969
// Addresses found by Klooger#1867
state("s1_sp64_ship")
{
	int loading1: 0xF6109DC;
	string50 map: 0x30740B6;
}

startup 
{
	settings.Add("missions", true, "Missions");

	vars.missions = new Dictionary<string,string> { 
		{"recovery","Atlas"},
		{"lagos","Traffic"},
		{"fusion","Fission"},
		{"detroit","Aftermath"},
		{"greece","Manhunt"},
		{"betrayal","Utopia"},
		{"irons_estate","Sentinel"},
		{"crash","Crash"},
		{"lab","Bio Lab"},
		{"sanfran","Collapse"},
		{"sanfran_b","Armada"},
		{"df_fly","Throttle"},
		{"captured","Captured"},
		{"finale","Terminus"},
	}; 
	foreach (var Tag in vars.missions)
	{
		settings.Add(Tag.Key, true, Tag.Value, "missions");
    };

  	vars.onStart = (EventHandler)((s, e) => // thanks gelly for this, it's basically making sure it always clears the vars no matter how livesplit starts
        {
            vars.starter = 0;
            vars.endsplit = 0;
            vars.FuckFinalSplit = 0;
            vars.doneMaps.Clear();
            vars.doneMaps.Add(current.map.ToString());
        });

    timer.OnStart += vars.onStart; 

	if (timer.CurrentTimingMethod == TimingMethod.RealTime) // stolen from dude simulator 3, basically asks the runner to set their livesplit to game time
        {        
        var timingMessage = MessageBox.Show (
               "This game uses Time without Loads (Game Time) as the main timing method.\n"+
                "LiveSplit is currently set to show Real Time (RTA).\n"+
                "Would you like to set the timing method to Game Time? This will make verification easier",
                "LiveSplit | Call of Duty: Advanced Warfare",
               MessageBoxButtons.YesNo,MessageBoxIcon.Question
            );
        
            if (timingMessage == DialogResult.Yes)
            {
                timer.CurrentTimingMethod = TimingMethod.GameTime;
            }
        }	
}

start
{
	if ((current.map == "seoul") && (current.loading1 == 0))
	{
		return true;
	}
}

split
{
	if (current.map != old.map) 
	{
		if (settings[(current.map)])
		{
			return true;				
		}
	}
}
 
reset
{
	return (current.map == "ui");
}

isLoading
{
	return ((current.loading1 == 1)));
}

exit 
{
    timer.OnStart -= vars.onStart;
}