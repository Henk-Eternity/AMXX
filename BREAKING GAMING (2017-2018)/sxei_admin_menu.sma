#include <amxmodx>
#include <HenkStocks>

// Name for the log file
new const LogFile[] = "BG_SxeMenu.txt"

// Chat commands to open the menus
new const Commands[2][] =
{
	"/sxeban",		// For the local ban menu
	"/sxescreen"		// For the screenshot menu
}

// ================================================================

new g_action, g_connected, g_maxplayers[1 char];

#define PLUGIN "sXe-I Admin Menu"
#define VERSION "1.5"

#pragma semicolon 1

#define set_action_localban(%0) (g_action |= (1 << %0-1))
#define clear_action_localban(%0) (g_action &= ~(1 << %0-1))
#define check_action_localban(%0) (g_action & (1 << %0-1))

#define set_player_connected(%0) (g_connected |= (1 << %0-1))
#define clear_player_connected(%0) (g_connected &= ~(1 << %0-1))
#define check_player_connected(%0) (g_connected & (1 << %0-1))

new const szPrefix [ ] = "!g[BREAKING GAMING]!y";

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, "Mario AR. & heNK'");
	
	new buffer[100];
	
	formatex(buffer, charsmax(buffer), "say %s", Commands[0]);
	register_clcmd(buffer, "clcmd_localban", ADMIN_BAN);
	
	formatex(buffer, charsmax(buffer), "say %s", Commands[1]);
	register_clcmd(buffer, "clcmd_screen", ADMIN_BAN);
	
	register_dictionary("common.txt");
	
	g_maxplayers{0} = get_maxplayers();
}

public plugin_cfg ( ) {
	if ( is_plugin_loaded ( "Pause Plugins" ) != -1 )
		server_cmd ( "amx_pausecfg add ^"%s^"", PLUGIN );
}

public client_putinserver(id)
	if (!is_user_bot(id)) set_player_connected(id);
	
public client_disconnect(id)
	clear_player_connected(id);

public clcmd_localban(id, level)
{
	if (~get_user_flags(id) & level)
		return PLUGIN_CONTINUE;
	
	set_action_localban(id);
	show_menu_players(id);
	
	return PLUGIN_HANDLED;
}

public clcmd_screen(id, level)
{
	if (~get_user_flags(id) & level)
		return PLUGIN_CONTINUE;
	
	clear_action_localban(id);
	show_menu_players(id);
	
	return PLUGIN_HANDLED;
}
	
show_menu_players(id)
{
	new szItem[40];
	formatex(szItem, charsmax(szItem), "\r[BREAKING GAMING] \y%s Menu", check_action_localban(id) ? "Local Ban" : "Screenshot");
	
	new menu = menu_create(szItem, "menu_players");

	new i, szUserID[8];

	for (i = 1; i < g_maxplayers{0}; i++)
	{
		if (!check_player_connected(i))
			continue;

		get_user_name(i, szItem, charsmax(szItem));
		
		num_to_str(get_user_userid(i), szUserID, charsmax(szUserID));

		menu_additem(menu, szItem, szUserID, 0);
	}
	
	formatex(szItem, charsmax(szItem), "%L", LANG_SERVER, "MORE");
	menu_setprop(menu, MPROP_NEXTNAME, szItem);
	
	formatex(szItem, charsmax(szItem), "%L", LANG_SERVER, "EXIT");
	menu_setprop(menu, MPROP_EXITNAME, szItem);
	
	formatex(szItem, charsmax(szItem), "%L", LANG_SERVER, "BACK");
	menu_setprop(menu, MPROP_BACKNAME, szItem);

	menu_display(id, menu);
}

public menu_players(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menu);
		return PLUGIN_HANDLED;
	}
	
	new szData[8], player, userid;

	// We don't need &access and &callback, so we'll use player.
	menu_item_getinfo(menu, item, player, szData, charsmax(szData), _, _, player);
	
	userid = str_to_num(szData);
	player = find_player("k", userid);
	
	if (player)
	{
		if (check_action_localban(id))
			show_confirm_ban(id, player, szData);
		else
		{
			server_cmd("sxe_screen #%d #%d", userid, get_user_userid(id));
		
			new szName[2][32];
			get_user_name(id, szName[0], 31);
			get_user_name(player, szName[1], 31);
			
			Henk_SayPrint ( id, "%s Le sacaste screen a !g%s", szPrefix, szName [ 1 ] );
			
			log_to_file(LogFile, "%L %s - Screenshot %s", LANG_SERVER, "ADMIN", szName[0], szName[1]);
		}
	}
		
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}

show_confirm_ban(id, player, szUserID[])
{
	new menu, szItem[64];
	
	// We're using 'menu' to store the len of string.
	menu = copy(szItem, charsmax(szItem), "\r[BREAKING GAMING]\y Local Ban\w ");
	menu += get_user_name(player, szItem[menu], charsmax(szItem)-menu);
	copy(szItem[menu], charsmax(szItem)-menu, "\y?");
	
	// Now 'menu' is the pointer of the menu.
	menu = menu_create(szItem, "confirm_ban");
	
	formatex(szItem, charsmax(szItem), "%L", LANG_SERVER, "YES");
	menu_additem(menu, szItem, szUserID);
	
	formatex(szItem, charsmax(szItem), "%L", LANG_SERVER, "NO");
	menu_additem(menu, szItem);
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_NEVER);
	
	menu_display(id, menu);
}

public confirm_ban(id, menu, item)
{
	if (!item)
	{
		new szData[8], player, userid;

		// We don't need &access and &callback, so we'll use player.
		menu_item_getinfo(menu, item, player, szData, charsmax(szData), _, _, player);
		
		userid = str_to_num(szData);
		player = find_player("k", userid);
		
		if (player)
		{
			server_cmd("sxe_ban #%d", userid);
		
			new szName[2][32];
			get_user_name(id, szName[0], 31);
			get_user_name(player, szName[1], 31);
			
			new szIp [ 2 ] [ 32 ];
			get_user_ip ( id, szIp [ 0 ], 31, 1 );
			get_user_ip ( player, szIp [ 1 ], 31, 1 );
			
			PrintBanInformation ( player, szName [ 0 ], szName [ 1 ], szIp [ 0 ], szIp [ 1 ] );
			
			log_to_file(LogFile, "%L %s - Local ban %s", LANG_SERVER, "ADMIN", szName[0], szName[1]);
		
			Henk_SayPrint ( 0, "%s ADMIN !g%s !ybanneo localmente a !g%s", szPrefix, szName [ 0 ], szName [ 1 ] );
			//client_print(0, print_chat, "[sXe-I] %L %s - Local ban %s", LANG_SERVER, "ADMIN", szName[0], szName[1]);
		}
	}
	
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}

PrintBanInformation ( iIndex, const admin_name [ ], const player_name [ ], const ip_admin [ ], const ip_player [ ] ) {
	
	
	console_print ( iIndex, "================== BREAKING GAMING ======================" );
	console_print ( iIndex, "Fuiste banneado del Servidor." );
	console_print ( iIndex, "Tu nombre: %s", player_name );
	console_print ( iIndex, "Tu IP: %s", ip_player );
	console_print ( iIndex, "Fuiste banneado por: %s", admin_name );
	console_print ( iIndex, "IP del admin: %s", ip_admin );
	console_print ( iIndex, "" );
	console_print ( iIndex, "Fuiste banneado Localmente" );
	console_print ( iIndex, "Si crees que tu ban fue injusto , reclamalo en: www.breakingaming.com o fb.com/groups/breakingamingcs" );
	console_print ( iIndex, "================== BREAKING GAMING ======================" );
	
}
