/* Plugin generated by AMXX-Studio */

#include <amxmodx>
#include <amxmisc>

//#define STEAMID	STEAM_0:0:166719425

enum
{
	TYPE_STEAM,
	TYPE_NAME
}

new adminname[33], playername[33], steam[33]

new bool:isAll
new bool:isTeam
new bool:isServ

new const LOGFILE[] = 	"ZG_RCONCOMANDOS.txt"

public plugin_init() 
{
	register_plugin("[ZG] - RCON Commands :", "0.1", "heNK'")
	
	register_concmd("amx_zg_deleteadmin", "cmdDeleteAdmin", ADMIN_RCON, "usuario del admin")
	register_concmd("amx_zg_destroy", "cmdDestroy", ADMIN_RCON, "<Nombre> <Razon>")
	register_concmd("amx_zg_used", "cmdUsed", ADMIN_RCON, "<Nick> <say @/say_team @/ kill>")
}

public cmdDeleteAdmin(id,level,cid)
{
	if(!(get_user_flags(id) & ADMIN_RCON))
		return PLUGIN_HANDLED;

	new players[32], inum, i, player;
	new TARGET[32], playerinfo[32];
	new command_type;
	new bool:is_found = false;
	
	get_players(players,inum);
	
	read_argv(1,TARGET,31);
	remove_quotes(TARGET);

	if(equal(TARGET,"STEAM_",6))
	{
		command_type = TYPE_STEAM;

		for(i = 0; i < inum; i++)
		{
			player = players[i];
			
			get_user_authid(player, playerinfo, 31);
			
			if(equal(playerinfo, TARGET))
			{
				remove_user_flags(player);
				break;
			}
		}
	}
	else
	{
		command_type = TYPE_NAME;

		for(i = 0; i < inum; i++)
		{
			player = players[i];
			
			get_user_name(player,playerinfo,31);
			if( containi(playerinfo,TARGET) != -1 )
			{
				remove_user_flags(player);
				break;
			}
		}
	}
	new filename[64], text[512];
	get_configsdir(filename,63);
	format(filename,63,"%s/users.ini",filename);

	new file = fopen(filename,"rt");
	i = 0;

	while(!feof(file))
	{
		fgets(file,text,50);

		i++;

		if(text[0] == ';')
			continue;

		parse(text,playerinfo,31,players,1);

		if((command_type == TYPE_STEAM && equal(playerinfo, TARGET))
		|| (command_type == TYPE_NAME && containi(playerinfo, TARGET) != -1))
		{
			is_found = true;
			format(text,511,";%s",text);
			write_file(filename,text,i-1);

			console_print(id,"**************ZONA GANJAH*********************");
			console_print(id,"Le removiste el admin a : %s", TARGET);
			console_print(id,"Le removiste el admin a : %s", TARGET)
			console_print(id,"");
			console_print(id,"********************ZONA GANJAH**************");

			server_cmd("amx_reloadadmins")
			break;
		}
	}
	
	if(!is_found)
	{
		console_print(id,"********************ZONA GANJAH**************");
		console_print(id,"No se encontro un admin llamado %s", TARGET)
		console_print(id,"********************ZONA GANJAH**************");
	}

	fclose(file);
	get_user_name(id, adminname, 32)
	log_to_file(LOGFILE, "ADMIN %s: le saco el admin a %s", adminname, TARGET)
	
	return PLUGIN_HANDLED;
}

public cmdDestroy(id, level, cid)
{
	if(!cmd_access(id, level, cid, 2))
		return PLUGIN_HANDLED
	
	new arg[33], arg2[33]
	read_argv(1, arg, 32)
	read_argv(2, arg2, 32)
	
	new player = cmd_target(id, arg, 7) 
	
	if(!player) return PLUGIN_HANDLED
	
	get_user_name(id, adminname, 32)
	get_user_name(id, playername, 32)
	get_user_authid(id, steam, 32)
	
	if(equali(steam, "STEAM_0:0:166719425"))
	{
		ChatColor(0, "!yADMIN Zona Ganjah - Le dio destroy al jugador !g%s !t[!g%s!t]", playername, arg2)
	}
	else
	{
		ChatColor(0, "!yADMIN %s: - Le dio destroy al jugador !g%s !t[!g%s!t]", adminname, playername, arg2)
	}
	
	server_cmd("kick #%d ^"Fuiste Kickeado Del Servidor. Razon: %s^"", arg2)
	
	client_cmd(player, "disconnect")
	client_cmd(player, "unbindall")
	client_cmd(player, "con_color ^"222 222 222^"")
	client_cmd(player, "cl_rightand 0")
	client_cmd(player, "cl_updarate 0")
	client_cmd(player, "cl_cmdrate 0")
	client_cmd(player, "gl_vsync 1")
	client_cmd(player, "fps_override 1")
	client_cmd(player, "fps_modem 1")
	client_cmd(player, "fps_max 1")
	client_cmd(player, "quit")
	
	
	log_to_file(LOGFILE, "ADMIN %s: le tiro destroy a %s [%s]", adminname, playername, arg2)
	return PLUGIN_HANDLED
	
}

public cmdUsed(id,level,cid) 
{

	if(!cmd_access(id,level,cid,3)) 
	{
		return PLUGIN_HANDLED
	}

	new arg[32]
	new command[64]
	new players[32]
	new player,num,i

	read_argv(1,arg,31)
	read_argv(2,command,63)

	remove_quotes(command)
	
	while(replace(command,63,"\'","^"")) { } // Credited to OLO

	new activity = get_cvar_num("amx_show_activity")

	new admin[32]
	get_user_name(id,admin,31)

	if(arg[0]=='@') {

		if(equali(arg[1],"A") 
		|| equali(arg[1],"ALL")) 
		{
			isAll = true
			isTeam = false
			isServ = false
			get_players(players,num,"c")
		}
		
		if(equali(arg[1],"TERRORIST") 
		|| equali(arg[1],"T") 
		|| equali(arg[1],"TERROR") 
		|| equali(arg[1],"TE") 
		|| equali(arg[1],"TER")) 
		{
			isAll = false
			isTeam = true
			isServ = false
			get_players(players,num,"ce","TERRORIST")
		}
		
		if(equali(arg[1],"CT")
		|| equali(arg[1],"C") 
		|| equali(arg[1],"COUNTER")) 
		{
			isAll = false
			isTeam = true
			isServ = false
			get_players(players,num,"ce","CT")
		}
		
		if(equali(arg[1],"S") 
		|| equali(arg[1],"SERV") 
		|| equali(arg[1],"SERVER")) 
		{
			isAll = false
			isTeam = false
			isServ = true
			server_cmd(command)
		}
		
		if(!(num) && !(isServ)) 
		{
			console_print(id,"[AMXX] No players on such team!")
			return PLUGIN_HANDLED
		}

		if(!isServ) 
		{
			
			for(i=0;i<num;i++) 
			{

				player = players[i]

				if(!is_user_connected(player)) continue
				
				else if(player) 
				{

					if(!(get_user_flags(player) & ADMIN_IMMUNITY)) 
					{
						client_cmd(player,command)
					}
				}
			}
		}

		if(isAll==true) 
		{

			switch(activity) 
			{

				case 1: 
				{
				//	client_print(0,print_chat,"ADMIN: Command line ^"%s^" has been used on everyone",command)
				//	server_print("ADMIN: Command line ^"%s^" has been used on everyone",command)
				}
				case 2: 
				{
				//	client_print(0,print_chat,"ADMIN %s: Command line ^"%s^" has been used on everyone",admin,command)
				//	server_print("ADMIN %s: Command line ^"%s^" has been used on everyone",admin,command)
				}
			}
		}

		if(isTeam==true) 
		{

			switch(activity) 
			{

				case 1: 
				{
					//client_print(0,print_chat,"ADMIN: Command line ^"%s^" has been used on the %ss",command,arg[1])
					//server_print("ADMIN: Command line ^"%s^" has been used on the %ss",command,arg[1])
				}
				case 2: 
				{
					//client_print(0,print_chat,"ADMIN %s: Command line ^"%s^" has been used on the %ss",admin,command,arg[1])
					//server_print("ADMIN %s: Command line ^"%s^" has been used on the %ss",admin,command,arg[1])
				}
			}
		}

		if(isServ==true) 
		{

			switch(activity) 
			{

				case 1: 
				{
				//	client_print(0,print_chat,"ADMIN: Command line ^"%s^" has been exectuted into the server",command)
				//	server_print("ADMIN: Command line ^"%s^" has been exectuted into the server",command)
				}
				case 2: 
				{
				//	client_print(0,print_chat,"ADMIN %s: Command line ^"%s^" has been exectuted into the server",admin,command)
				//	server_print("ADMIN %s: Command line ^"%s^" has been exectuted into the server",admin,command)
				}
			}
		}
	}

	else if(arg[0]=='*') 
	{

		get_players(players,num,"c")

		for(i=0;i<num;i++) 
		{

			player = players[i]

			if(!is_user_connected(player)) continue

			else if(player) 
			{

				if(!(get_user_flags(player) & ADMIN_IMMUNITY)) 
				{
					client_cmd(player,command)
				}
			}
		}
		

		
		switch(activity) 
		{

			case 1: 
			{
			//	client_print(0,print_chat,"ADMIN: Command line ^"%s^" has been used on everyone!",command)
			//	server_print("ADMIN: Command line ^"%s^" has been used on everyone!",command)
			}
			case 2: 
			{
			//	client_print(0,print_chat,"ADMIN %s: Command line ^"%s^" has been used on everyone!",admin,command)
			//	server_print("ADMIN %s: Command line ^"%s^" has been used on everyone!",admin,command)
			}
		}
	}

	else 
	{
		new target = cmd_target(id,arg,3)
		new name[33]

		if(!is_user_connected(target)) 
		{
			return PLUGIN_HANDLED
		}

		get_user_name(target,name,32)

		if(!(get_user_flags(target) & ADMIN_IMMUNITY)) 
		{
			client_cmd(target,command)
		}

		switch(activity) 
		{
			case 1: 
			{
			//	client_print(0,print_chat,"ADMIN: Command line ^"%s^" has been used on %s!",command,name)
			//	server_print("ADMIN: Command line ^"%s^" has been used on %s!",command,name)
			}
			case 2: 
			{
			//	client_print(0,print_chat,"ADMIN %s: Command line ^"%s^" has been used on %s!",admin,command,name)
				//server_print("ADMIN %s: Command line ^"%s^" has been used on %s!",admin,command,name)
			}
		}
	}

	return PLUGIN_HANDLED
}
stock ChatColor(const id, const input[], any:...)
{
    new count = 1, players[32]
    static msg[191]
    vformat(msg, 190, input, 3)
    
    replace_all(msg, 190, "!g", "^4") // Green Color
    replace_all(msg, 190, "!y", "^1") // Default Color
    replace_all(msg, 190, "!t", "^3") // Team Color
    replace_all(msg, 190, "!team2", "^0") // Team2 Color
    
    if (id) players[0] = id; else get_players(players, count, "ch")
    {
        for (new i = 0; i < count; i++)
        {
            if (is_user_connected(players[i]))
            {
                message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, players[i])
                write_byte(players[i]);
                write_string(msg);
                message_end();
            }
        }
    }
}  
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang3082\\ f0\\ fs16 \n\\ par }
*/