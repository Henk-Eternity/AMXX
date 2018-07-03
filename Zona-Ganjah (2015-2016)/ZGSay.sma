/* Plugin generated by AMXX-Studio */

#include <amxmodx>
#include <amxmisc>

new name[33], steam[33]

new g_maxplayers

//#define STEAMID	STEAM_0:0:166719425

public plugin_init() 
{
	register_plugin("[BG] - Say", "0.1", "heNK'")
	
	register_clcmd("say", "cmdSay")
	register_clcmd("say_team", "cmdSayTeam")
	
	g_maxplayers = get_maxplayers()
}

public cmdSay(id)
{
	new say[192]
	read_args(say, 191) 
	
	remove_quotes(say) 
	
	if(say[0] == '#' || say[0] == '%' || equal(say, ""))
		return PLUGIN_HANDLED
	
	if(!ValidMessage(say, 1)) return PLUGIN_CONTINUE
	
	new color[11], prefix[91]
	get_user_team(id, color, 10)
	get_user_name(id, name, 32)
	get_user_authid(id, steam, 32)
	
	if(is_user_admin(id))
	{
		if(is_user_alive(id))
		{
			if(equali(steam, "STEAM_0:0:223210316"))
			{
				formatex(prefix, 90, "^x03%s", name)
			}
			else 
			{
				formatex(prefix, 90, "^x04%s", name)
			}
		}
		else 
		{
			if(equali(steam, "STEAM_0:0:223210316"))
			{
				formatex(prefix, 90, "^x01*DEAD* ^x03%s", name)
			}
			else
			{
				formatex(prefix, 90, "^x01*DEAD* ^x04%s", name)
			}
		}
	}
	else
	{
		if(is_user_alive(id))
		{
			formatex(prefix, 90, "^x03%s", name)
		}
		else 
		{
			formatex(prefix, 90, "^x01*DEAD* ^x03%s", name)
		}
	}
	
	format(say, 191, "%s^x01 : %s", prefix, say)
	
	new team[11] 
	for(new i = 1; i <= g_maxplayers; i++)
	{
		if(!is_user_connected(i)) continue 
		
		if(is_user_admin(i) || is_user_alive(id) || is_user_alive(i) || !is_user_alive(id) || !is_user_alive(i))
		{ 
			get_user_team(i, team, 10)
			
			changeTeamInfo(i, color)
			
			writeMessage(i, say)
			
			changeTeamInfo(i, team)
		}
	}
	return PLUGIN_HANDLED_MAIN
}

public cmdSayTeam(id)
{
	new say[192]
	
	read_args(say, 191)
	
	remove_quotes(say)
	
	if(say[0] == '#' || say[0] == '%' || equal(say, "")) 
		return PLUGIN_HANDLED
	
	new color[11], prefix[134]
	get_user_team(id, color, 10)
	get_user_name(id, name, 32)
	get_user_authid(id, steam, 32) 
	
	if(!ValidMessage(say, 1)) return PLUGIN_CONTINUE
	
	new playerTeam, playerTeamName[100] 
	playerTeam = get_user_team(id) 
	
	switch(playerTeam)
	{
		case 1: copy(playerTeamName, 11, "(Terorist)")
		case 2: copy(playerTeamName, 24, "(Counter-Terrorist)")
		default: copy(playerTeamName, 12, "(Spectador)")
	}
	
	if(is_user_admin(id))
	{
		if(is_user_alive(id))
		{
			if(equali(steam, "STEAM_0:0:223210316"))
			{
				formatex(prefix, 99, "^x01%s ^x03%s", playerTeamName, name)
			}
			else
			{
				formatex(prefix, 99, "^x01%s ^x04%s", playerTeamName, name)
			}
		}
		else
		{
			if(equali(steam, "STEAM_0:0:223210316"))
			{
				formatex(prefix, 99, "^x01*DEAD* %s ^x03%s", playerTeamName, name)
			}
			else
			{
				formatex(prefix, 99, "^x01*DEAD* %s ^x04%s", playerTeamName, name)
			}
		}
	}
	else
	{
		if(is_user_alive(id))
		{
			formatex(prefix, 99, "^x01%s ^x03%s", playerTeamName, name)
		}
		else
		{
			formatex(prefix, 99, "^x01*DEAD* %s ^x03%s", playerTeamName, name)
		}
	}
	
	format(say, 191, "%s^x01 : %s", prefix, say)
	
	new team[11]
	for(new i = 1; i <= g_maxplayers; i++)
	{
		if(!is_user_connected(i)) continue 
		
		if(get_user_team(i) == playerTeam)
		{
			if(is_user_alive(id) && is_user_alive(i) || !is_user_alive(id) || !is_user_alive(i))
			{
				get_user_team(i, team, 10)
				
				changeTeamInfo(i, color) 
				
				writeMessage(i, say)
				
				changeTeamInfo(i, team)
			}
		}
	}
	
	return PLUGIN_HANDLED_MAIN
}

public changeTeamInfo(player, team[]) 
{
	message_begin(MSG_ONE, get_user_msgid("TeamInfo"), _, player)
	write_byte(player)
	write_string(team)
	message_end()
}

public writeMessage(player, say[])
{
	message_begin(MSG_ONE, get_user_msgid("SayText"), {0, 0, 0}, player)
	write_byte(player)
	write_string(say) 
	message_end()
}

stock ValidMessage(text[], maxcount) {
    static len, i, count
    len = strlen(text)
    count = 0
    
    if (!len)
        return false;
    
    for (i = 0; i < len; i++) {
        if (text[i] != ' ') {
            count++
            if (count >= maxcount)
                return true;
        }
    }
    
    return false;
} 
			