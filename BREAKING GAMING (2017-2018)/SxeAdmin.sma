#include < amxmodx >
#include < amxmisc >

new const szPluginInfo [ ] [ ] = {
	{ "[BG] sXe Admin" },
	{ "1.0" },
	{ "heNK'" }
};

#pragma compress 1

new const szPrefix [ ] = "!g[BREAKING GAMING]!y";

public plugin_init ( ) {
	
	register_plugin ( szPluginInfo [ 0 ], szPluginInfo [ 1 ], szPluginInfo [ 2 ] );
	
	register_clcmd ( "say /sxeadmin", "cmdSxeAdmin" );
	register_clcmd ( "say_team /sxeadmin", "cmdSxeAdmin" );
	
	register_clcmd ( "say /sxeban", "sXeBanMenu" );
	register_clcmd ( "say_team /sxeban", "sXeBanMenu" );
	
	register_clcmd ( "say /sxescreen", "sXeScreenMenu" );
	register_clcmd ( "say_team /sxescreen", "sXeScreenMenu" );
	
	register_concmd ( "amx_sxe_screen", "cmdSxeScreen", ADMIN_CVAR, "< Nombre >" );
	register_concmd ( "amx_sxe_ban", "cmdSxeBan", ADMIN_CVAR, "< Nombre >" );
	
	
}

public plugin_cfg ( ) {
	
	
	if ( is_plugin_loaded ( "Pause Plugins" ) != -1 )
		server_cmd ( "amx_pausecfg add ^"%s^"", szPluginInfo [ 0 ] );
}

public cmdSxeAdmin ( iIndex ) {
	
	if ( ! ( get_user_flags ( iIndex ) & ADMIN_CVAR ) ) { 
		console_print ( iIndex, "[BREAKING GAMING] No tienes acceso a este comando..." );
		return PLUGIN_HANDLED;
	}
	
	new Menu = menu_create ( "\r[BREAKING GAMING] \y- \wsXe Admin", "HandlerSxeAdminMenu" );
	
	menu_additem ( Menu, "sXe Ban Local" );
	menu_additem ( Menu, "sXe ScreenShot" );
	
	menu_setprop ( Menu, MPROP_EXITNAME, "Salir" );
	
	menu_display ( iIndex, Menu );
	
	return PLUGIN_HANDLED;
	
}

public HandlerSxeAdminMenu ( iIndex, Menu, Item ) {

	switch ( Item ) {
		case 0: sXeBanMenu ( iIndex );
		case 1: sXeScreenMenu ( iIndex );
		case 9: menu_destroy ( Menu );
	}
	
}

public sXeBanMenu ( iIndex )  {
	
	if ( ! ( get_user_flags ( iIndex ) & ADMIN_CVAR ) ) { 
		console_print ( iIndex, "[BREAKING GAMING] No tienes acceso a este comando..." );
		return PLUGIN_HANDLED;
	}
	
	
	new Menu = menu_create ( "\r[BREAKING GAMING] \y- \wElige al Jugador \d[BAN LOCAL]", "HandlerSxeBanMenu" );
	
	new iUserID [ 8 ];
	new name [ 33 ];
	
	for ( new i = 1; i < get_maxplayers ( ); i++ ) {	
		
		if ( !is_user_connected ( i ) )
			continue;
		
		get_user_name ( i, name, sizeof ( name ) );
		
		num_to_str ( get_user_userid ( i ), iUserID, sizeof ( iUserID ) );
		
		menu_additem ( Menu, name, iUserID );
		
	}
	
	menu_setprop ( Menu, MPROP_EXITNAME, "Salir" );
	menu_setprop ( Menu, MPROP_NEXTNAME, "Siguiente" );
	menu_setprop ( Menu, MPROP_BACKNAME, "Atras" );
	
	menu_display ( iIndex, Menu );
	
	return PLUGIN_HANDLED;
}


public HandlerSxeBanMenu ( iIndex, Menu, Item ) {
	
	if ( Item == MENU_EXIT ) {
		menu_destroy ( Menu );
		return PLUGIN_HANDLED;
	}
	
	new szData [ 8 ], player, userid;


	menu_item_getinfo ( Menu, Item, player, szData, sizeof ( szData ), _, _, player);
	
	userid = str_to_num ( szData );
	player = find_player ( "k", userid );
	
	if ( player ) {
		server_cmd ( "sxe_ban #%d", userid );
		//server_cmd ( "amx_sxe_ban #%d", userid );
		
		
		
		new g_PlayerName [ 33 ] [ 32 ];
		get_user_name ( iIndex, g_PlayerName [ iIndex ], sizeof ( g_PlayerName [ ] ) );
		new PlayerNameAdmin [ 33 ];
		get_user_name ( player, PlayerNameAdmin, 32 );
		
		
		
		SayPrint ( 0, "%s ADMIN !g%s !ybanneo localmente a !g%s", szPrefix, g_PlayerName [ iIndex ], PlayerNameAdmin);
		new IP_Admin [ 33 ], IP_Player [ 33 ];
		get_user_ip ( iIndex, IP_Admin, 32, 1 );
		get_user_ip ( player, IP_Player, 32, 1 );
		
		PrintBanInformation ( player, g_PlayerName [ iIndex ], PlayerNameAdmin, IP_Admin, IP_Player ); 
		
		log_to_file ( "SxeBans.txt", "< SXE ADMIN > ADMIN %s: banneo localmente a %s", g_PlayerName [ iIndex ], PlayerNameAdmin  );
		
		
		
	}
	
	return PLUGIN_HANDLED;
}

public sXeScreenMenu ( iIndex ) {


	if ( ! ( get_user_flags ( iIndex ) & ADMIN_CVAR ) ) { 
		console_print ( iIndex, "[BREAKING GAMING] No tienes acceso a este comando..." );
		return PLUGIN_HANDLED;
	}
	
	
	
	new Menu = menu_create ( "\r[BREAKING GAMING] \y- \wElige al Jugador \d[SXE SCREEN]", "HandlerSxeScreenMenu" );
	
	new iUserID [ 8 ];
	new name [ 33 ];
	
	for ( new i = 1; i < get_maxplayers ( ); i++ ) {	
		
		if ( !is_user_connected ( i ) )
			continue;
		
		get_user_name ( i, name, sizeof ( name ) );
		
		num_to_str ( get_user_userid ( i ), iUserID, sizeof ( iUserID ) );
		
		menu_additem ( Menu, name, iUserID );
		
	}
	
	menu_setprop ( Menu, MPROP_EXITNAME, "Salir" );
	menu_setprop ( Menu, MPROP_NEXTNAME, "Siguiente" );
	menu_setprop ( Menu, MPROP_BACKNAME, "Atras" );
	
	menu_display ( iIndex, Menu );
	
	return PLUGIN_HANDLED;
}
	
public HandlerSxeScreenMenu ( iIndex, Menu, Item ) {
	
	if ( Item == MENU_EXIT ) {
		menu_destroy ( Menu );
		return PLUGIN_HANDLED;
	}
	
	new szData [ 8 ], player, userid;


	menu_item_getinfo ( Menu, Item, player, szData, sizeof ( szData ), _, _, player);
	
	userid = str_to_num ( szData );
	player = find_player ( "k", userid );
	
	if ( player ) {
		
		server_cmd ( "sxe_screen #%d #%d", userid, get_user_userid ( iIndex ) );
		
		new g_PlayerName [ 33 ] [ 32 ];
		get_user_name ( iIndex, g_PlayerName [ iIndex ], sizeof ( g_PlayerName [ ] ) );
		
		SayPrint ( iIndex, "%s Le sacaste screen a !g%s", szPrefix, g_PlayerName [ player ] );
		
		log_to_file ( "SxeBans.txt", "< SXE ADMIN > ADMIN %s: le saco una screen a %s", g_PlayerName [ iIndex ], g_PlayerName [ player ]  );
		
		
	}
	
	return PLUGIN_HANDLED;
}

public cmdSxeScreen ( iIndex ) {
	
	if ( ! ( get_user_flags ( iIndex ) & ADMIN_CVAR ) ) {
		console_print ( iIndex, "[BREAKING GAMING] No tienes acceso a este comando..." );
		return PLUGIN_HANDLED;
		
	}
	
		
	new Target [ 33 ];
	read_argv ( 1, Target, 32 );
	
	new TargetPlayer = cmd_target ( iIndex, Target, 0 );
	
	if ( !is_user_connected ( TargetPlayer ) )
		return PLUGIN_HANDLED;
		
	if ( is_user_bot ( TargetPlayer ) ) {
		console_print ( iIndex, "[BREAKING GAMING] Es un bot" );
		return PLUGIN_HANDLED;
		
	}
	
	new g_PlayerName [ 33 ] [ 32 ];
	get_user_name ( iIndex, g_PlayerName [ iIndex ], sizeof ( g_PlayerName [ ] ) );
		
	SayPrint ( iIndex, "%s Le sacaste screen a !g%s", szPrefix, g_PlayerName [ TargetPlayer ] );
	
	server_cmd ( "sxe_screen #%d #%d", get_user_userid ( TargetPlayer ), get_user_userid ( iIndex ) );
	
	return PLUGIN_HANDLED;
	
}

public cmdSxeBan ( iIndex ) {
	
	if ( ! ( get_user_flags ( iIndex ) & ADMIN_CVAR ) ) {
		console_print ( iIndex, "[BREAKING GAMING] No tienes acceso a este comando..." );
		return PLUGIN_HANDLED;
		
	}
	
		
	new Target [ 33 ];
	read_argv ( 1, Target, 32 );
	
	new TargetPlayer = cmd_target ( iIndex, Target, 0 );
	
	if ( strlen ( Target ) != 0 ) { 
		
		//new uId = find_player ( "k", str_to_num ( Target [ 1 ] ) );
		
		new g_PlayerName [ 33 ] [ 32 ];
		get_user_name ( iIndex, g_PlayerName [ iIndex ], sizeof ( g_PlayerName [ ] ) );
		//SayPrint ( iIndex, "%s Banneaste localmente a !g%s", szPrefix, TargetName );
		
		
	}
	
	new IP_Admin [ 33 ], IP_Player [ 33 ];
	get_user_ip ( iIndex, IP_Admin, 32, 1 );
	get_user_ip ( TargetPlayer, IP_Player, 32, 1 );
	
	new PlayerNameAdmin [ 33 ];
	get_user_name ( TargetPlayer, PlayerNameAdmin, 32 );
		
	
	PrintBanInformation ( TargetPlayer, g_PlayerName [ iIndex ], PlayerNameAdmin, IP_Admin, IP_Player ); 
	
	server_cmd ( "sxe_ban %s", TargetPlayer );
	
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

stock SayPrint ( const iIndex, const Text [ ], any:... ) { 
	
	new Say [ 192 ];
	vformat ( Say, sizeof ( Say ), Text, 3 );
	
	replace_all ( Say, sizeof ( Say ), "!y", "^1" );
	replace_all ( Say, sizeof ( Say ), "!g", "^4" );
	replace_all ( Say, sizeof ( Say ), "!t", "^3" );
	
	//Acentos
	replace_all ( Say, sizeof ( Say ), "·", "√°" );
	replace_all ( Say, sizeof ( Say ), "È", "√©" );
	replace_all ( Say, sizeof ( Say ), "Ì", "√*" );
	replace_all ( Say, sizeof ( Say ), "Û", "√≥" );
	replace_all ( Say, sizeof ( Say ), "˙", "√∫" );
	replace_all ( Say, sizeof ( Say ), "Ò", "√±" );
	
	replace_all ( Say, sizeof ( Say ), "¡", "√" );
	replace_all ( Say, sizeof ( Say ), "…", "√â" );
	replace_all ( Say, sizeof ( Say ), "Õ", "√ç" );
	replace_all ( Say, sizeof ( Say ), "”", "√ì" );
	replace_all ( Say, sizeof ( Say ), "⁄", "√ö" );
	replace_all ( Say, sizeof ( Say ), "—", "√ë" );
	
	
	
	
	message_begin ( iIndex ? MSG_ONE_UNRELIABLE : MSG_BROADCAST, get_user_msgid ( "SayText" ), .player = iIndex );
	write_byte ( iIndex ? iIndex : 33 );
	write_string ( Say );
	message_end (  );
	
	
}


