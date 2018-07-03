#include < amxmodx >
#include < amxmisc >

new const szPluginInfo [ ] [ ] = {
	{ "[BG] Admin Check" },
	{ "1.2" },
	{ "heNK'" }
};

#pragma compress 1

new const szPrefix [ ] = "!g[BREAKING GAMING]!y";
new const no_amxx_uncompress [ ] = "no_amxx_uncompress";



public plugin_init ( ) {
	
	register_plugin ( szPluginInfo [ 0 ], szPluginInfo [ 1 ], szPluginInfo [ 2 ] );
	
	
	RegisterSayCmdTeam ( "admin", "cmdAdminCheck", ADMIN_ALL, true );
	RegisterSayCmdTeam ( "admins", "cmdAdminCheck", ADMIN_ALL, true );
	
	
}

public plugin_cfg ( ) {
	if ( is_plugin_loaded ( "Pause Plugins" ) != -1 )
		server_cmd ( "amx_pausecfg add ^"%s^"", szPluginInfo [ 0 ] );
}


public cmdAdminCheck ( iIndex ) {
	
	static iMenu;
	
	iMenu = menu_create ( "\r[BREAKING GAMING] \y- \wAdmins Online", "HandlerAdminOnline" );
	
	//static i = 1;
	new iName [ 33 ];
	new bool:Connected = false;
	
	//while ( i <= get_maxplayers ( ) ) {
	
	//new HenkCheckSteam [ 33 ]; get_user_authid ( iIndex, HenkCheckSteam, sizeof ( HenkCheckSteam ) - 1 );
	//new HenkCheckName [ 33 ]; get_user_name ( iIndex, HenkCheckName, sizeof ( HenkCheckName ) - 1 );
	
	for ( new i = 1; i <= get_maxplayers ( ); i++ ) {
		
		if ( !is_user_connected ( i ) )
			continue;


		
		if ( is_user_admin ( i ) ) {
			get_user_name ( i, iName, sizeof ( iName ) - 1 );
		
			menu_additem ( iMenu, iName );
			menu_setprop ( iMenu, MPROP_EXITNAME, "Salir" );
			menu_setprop ( iMenu, MPROP_BACKNAME, "Atras" );
			menu_setprop ( iMenu, MPROP_NEXTNAME, "Siguiente" );
			
			Connected = true;
		}
		//i++;
	}
	
	if ( Connected ) {
		
		menu_display ( iIndex, iMenu );
	}
	else {
		SayPrint ( iIndex, "%s No hay admins online", szPrefix );
		menu_destroy ( iMenu );
		
	}
	
	return PLUGIN_HANDLED;
}

public HandlerAdminOnline ( iIndex, iMenu, iItem ) {
	
	menu_destroy ( iMenu );
	return PLUGIN_HANDLED;
}

stock SayPrint ( const iIndex, const Text [ ], any:... ) { 
	
	new Say [ 192 ];
	vformat ( Say, sizeof ( Say ), Text, 3 );
	
	replace_all ( Say, sizeof ( Say ), "!y", "^1" );
	replace_all ( Say, sizeof ( Say ), "!g", "^4" );
	replace_all ( Say, sizeof ( Say ), "!t", "^3" );
	
	//Acentos
	replace_all ( Say, sizeof ( Say ), "á", "Ã¡" );
	replace_all ( Say, sizeof ( Say ), "é", "Ã©" );
	replace_all ( Say, sizeof ( Say ), "í", "Ã*" );
	replace_all ( Say, sizeof ( Say ), "ó", "Ã³" );
	replace_all ( Say, sizeof ( Say ), "ú", "Ãº" );
	replace_all ( Say, sizeof ( Say ), "ñ", "Ã±" );
	
	replace_all ( Say, sizeof ( Say ), "Á", "Ã" );
	replace_all ( Say, sizeof ( Say ), "É", "Ã‰" );
	replace_all ( Say, sizeof ( Say ), "Í", "Ã" );
	replace_all ( Say, sizeof ( Say ), "Ó", "Ã“" );
	replace_all ( Say, sizeof ( Say ), "Ú", "Ãš" );
	replace_all ( Say, sizeof ( Say ), "Ñ", "Ã‘" );
	
	
	
	
	message_begin ( iIndex ? MSG_ONE_UNRELIABLE : MSG_BROADCAST, get_user_msgid ( "SayText" ), .player = iIndex );
	write_byte ( iIndex ? iIndex : 33 );
	write_string ( Say );
	message_end (  );
	
	
}

stock RegisterSayCmdTeam ( const szSayCommand [ ], const szFunction [ ], const szFlags, bool:ComandoTrue ) { 
	
	new LenSay [ 127 ];
	new LenSayTeam [ 127 ];
	
	if ( ComandoTrue ) { 
	
		formatex ( LenSay, sizeof ( LenSay ), "say /%s",szSayCommand );
		formatex ( LenSayTeam, sizeof ( LenSayTeam ), "say_team /%s", szSayCommand );
	}
	
	else {
		formatex ( LenSay, sizeof ( LenSay ), "say %s",szSayCommand );
		formatex ( LenSayTeam, sizeof ( LenSayTeam ), "say_team %s", szSayCommand );	
	
	}
	
	register_clcmd ( LenSay, szFunction, szFlags );
	register_clcmd ( LenSayTeam, szFunction, szFlags );
	
	
}
