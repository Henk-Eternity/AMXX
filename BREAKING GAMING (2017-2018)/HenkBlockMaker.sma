#include < amxmodx >
#include < amxmisc >
#include < fakemeta >
#include < cstrike >
#include < fun >
#include < engine >
#include < hamsandwich >
#include < HenkStocks >


new const szPluginInfo [ ] [ ] = {
	{ "[BG] - BlockMaker" },
	{ "2.0" },
	{ "heNK'" }
};

#define NULL 0
#pragma compress 1

enum {
	PLATAFORMA,
	BUNNYHOP,
	MUERTE,
	DANIO,
	NO_DANIO,
	VIDA,
	HIELO,
	TRAMPOLIN,
	VIDRIO,
	GRAVEDAD,
	AWP,
	DEAGLE,
	BICHOS_SNARK,
	USP,
	M3,
	SCOUT,
	
	BLOQUES_TOTALES
}

enum {
	X,
	Y,
	Z
}

enum {
	TRANSCOLOR,
	TRANSALPHA,
	TRANSWHITE,
	GLOWSHELL
}

enum {
	SMALL,
	LARGE,
	NORMAL
}

enum ( += 1000 ) {
	TASK_BHOPSOLID = 1000,
	TASK_BHOPSOLIDNOT, 
	TASK_NOSLOW,
	TASK_GRAVEDAD,
};

enum {
	//Number 1
	N1,
	N2,
	N3,
	N4,
	N5,
	N6,
	N7,
	N8,
	N9,
	N0

};

enum {
	B1 = 1 << N1,
	B2 = 1 << N2,
	B3 = 1 << N3,
	B4 = 1 << N4,
	B5 = 1 << N5,
	B6 = 1 << N6,
	B7 = 1 << N7,
	B8 = 1 << N8,
	B9 = 1 << N9,
	B0 = 1 << N0,
};


new const szBloques [ BLOQUES_TOTALES ] [ ] = {
	"Plataforma",
	"Bunny Hop",
	"Muerte",
	"Danio",
	"No Danio",
	"Vida",
	"Hielo",
	"Trampolin",
	"Vidrio",
	"Gravedad",
	"Awp",
	"Deagle",
	"Bichos Snark",
	"Usp",
	"M3",
	"Scout"

};

new const g_iPropiedad1_Default_Name [ BLOQUES_TOTALES ] [ ] = {
	"HUD Mensaje", 					//plataforma
	"No Slow Down",					//BHOP
	"", 						//Muerte
	"Cantidad", 					//Danio
	"", 						//No Danio
	"Cantidad",					//Vida
	"", 						//Hielo
	"Altura",					//Trampolin
	"",						//Vidrio
	"Altura", 					//Gravedad
	"Balas", 					//Awp
	"Balas", 					//Deagle
	"Cantidad",					//Snarks
	"Balas", 					//Usp
	"Balas", 					//M3
	"Balas" 					//Scout
}

new const g_iPropiedad1_Default_Valor [ BLOQUES_TOTALES ] [ ] = {
	"", 					//Plataforma
	"Si", 					//NO Slow Down BHOP
	"", 					//Muerte
	"3.0",				         //Danio
	"", 					//No Danio
	"1.0", 					//Vida
	"", 					//Hielo
	"500", 					//Trampolin
	"100", 					//Vidrio
	"500", 					//Gravedad
	"1", 					//Awp
	"2", 					//Deagle
	"5", 					//Snarks
	"3", 					//Usp
	"1",					//M3
	"0"					//Scout
}

new const g_iPropiedad2_Default_Name [ BLOQUES_TOTALES ] [ ] = {

	"", 			//Plataforma
	"", 			//NO Slow Down BHOP
	"", 			//Muerte
	"",		         //Danio
	"",			//No Danio
	"Experiencia", 		//Vida
	"", 			//Hielo
	"", 			//Trampolin
	"", 			//Vidrio
	"", 			//Gravedad
	"Experiencia", 		//Awp
	"Experiencia", 		//Deagle
	"Experiencia", 		//Snarks
	"Experiencia", 		//Usp
	"Experiencia",		//M3
	"Experiencia"		//Scout

}

new const g_iPropiedad2_Default_Valor [ BLOQUES_TOTALES ] [ ] = {
	
	"", 			//Plataforma
	"", 			//NO Slow Down BHOP
	"", 			//Muerte
	"",		         //Danio
	"",			//No Danio
	"500", 			//Vida
	"", 			//Hielo
	"", 			//Trampolin
	"", 			//Vidrio
	"", 			//Gravedad
	"2500", 		//Awp
	"1000", 		//Deagle
	"1000", 		//Snarks
	"1200", 		//Usp
	"2000",			//M3
	"500"			//Scout

}

new const g_iPropiedad3_Default_Name [ BLOQUES_TOTALES ] [ ] = {
	"Transparencia", 			//Plataforma
	"Transparencia", 			//NO Slow Down BHOP
	"Transparencia", 			//Muerte
	"Transparencia",		         //Danio
	"Transparencia",			//No Danio
	"Transparencia", 			//Vida
	"Transparencia", 			//Hielo
	"Transparencia", 			//Trampolin
	"Transparencia", 			//Vidrio
	"Transparencia", 			//Gravedad
	"Transparencia", 			//Awp
	"Transparencia", 			//Deagle
	"Transparencia", 			//Snarks
	"Transparencia", 			//Usp
	"Transparencia",			//M3
	"Transparencia"				//Scout
}

new const g_iPropiedad3_Default_Valor [ BLOQUES_TOTALES ] [ ] = {

	"255", 			//Plataforma
	"255", 			//NO Slow Down BHOP
	"255", 			//Muerte
	"255",		         //Danio
	"255",			//No Danio
	"255", 			//Vida
	"255", 			//Hielo
	"255", 			//Trampolin
	"255", 			//Vidrio
	"255", 			//Gravedad
	"255", 			//Awp
	"255", 			//Deagle
	"255", 			//Snarks
	"255", 			//Usp
	"255",			//M3
	"255"			//Scout

}

new const g_iPropiedad4_Default_Name [ BLOQUES_TOTALES ] [ ] = {

	"", 			//Plataforma
	"No bug", 		//NO Slow Down BHOP
	"", 			//Muerte
	"",		         //Danio
	"",			//No Danio
	"", 			//Vida
	"", 			//Hielo
	"", 			//Trampolin
	"", 			//Vidrio
	"", 			//Gravedad
	"Recargas", 		//Awp
	"Recargas", 		//Deagle
	"Recargas", 		//Snarks
	"Recargas", 		//Usp
	"Recargas",		//M3
	"Recargas"		//Scout

}

new const g_iPropiedad4_Default_Valor [ BLOQUES_TOTALES ] [ ] = {

	"", 		//Plataforma
	"No", 		//NO Slow Down BHOP
	"", 		//Muerte
	"",		//Danio
	"",		//No Danio
	"", 		//Vida
	"", 		//Hielo
	"", 		//Trampolin
	"", 		//Vidrio
	"", 		//Gravedad
	"0", 		//Awp
	"0", 		//Deagle
	"0", 		//Snarks
	"0", 		//Usp
	"0",		//M3
	"0"		//Scout

}



new const szModels [ BLOQUES_TOTALES ] [ ] = {
	"models/BREAKING GAMING/Plataforma.mdl",
	"models/BREAKING GAMING/BunnyHop.mdl",
	"models/BREAKING GAMING/Muerte.mdl",
	"models/BREAKING GAMING/Danio.mdl",
	"models/BREAKING GAMING/No_Danio.mdl",
	"models/BREAKING GAMING/Vida.mdl",
	"models/BREAKING GAMING/Hielo.mdl",
	"models/BREAKING GAMING/Trampolin.mdl",
	"models/BREAKING GAMING/Vidrio.mdl",
	"models/BREAKING GAMING/Gravedad.mdl",
	"models/BREAKING GAMING/Awp.mdl",
	"models/BREAKING GAMING/Deagle.mdl",
	"models/BREAKING GAMING/Bichos_Snark.mdl",
	"models/BREAKING GAMING/Usp.mdl",
	"models/BREAKING GAMING/M3.mdl",
	"models/BREAKING GAMING/Scout.mdl"
};


new const g_iBloques_SaveID [ BLOQUES_TOTALES ] = {

	'a', 		//Plataforma
	'b', 		//NO Slow Down BHOP
	'c', 		//Muerte
	'd',		//Danio
	'e',		//No Danio
	'f', 		//Vida
	'g', 		//Hielo
	'h', 		//Trampolin
	'i', 		//Vidrio
	'j', 		//Gravedad
	'k', 		//Awp
	'l', 		//Deagle
	'm', 		//Snarks
	'n', 		//Usp
	'o',		//M3
	'p'		//Scout	
}

#if !defined _fun_included
#define get_user_noclip(%1) ( entity_get_int( %1, EV_INT_movetype ) == MOVETYPE_NOCLIP )

stock get_user_godmode( const id ) {
	new Float:flVal = entity_get_float( id, EV_FL_takedamage );
	
	return ( flVal == DAMAGE_NO );
}

stock set_user_godmode( const id, iGodmode = 0 ) {
	entity_set_float( id, EV_FL_takedamage, iGodmode == 1 ? DAMAGE_NO : DAMAGE_AIM );
	
	return 1;
}

stock set_user_noclip( const id, iNoclip = 0 ) {
	entity_set_int( id, EV_INT_movetype, iNoclip == 1 ? MOVETYPE_NOCLIP : MOVETYPE_WALK );

	return 1;
}
#endif

/* Bloques Variables */
new g_iBloqueSelected_Type [ BLOQUES_TOTALES ];
new g_iBloqueSelected_Size [ BLOQUES_TOTALES ];
new g_iBlockSetPropiedad [ 33 ] [ 2 ];


new Float:g_iGrabLength [ 33 ];
const Float:g_snap_distance = 10.0;
new Float:g_iSnapping_gap [ 33 ];
new bool:g_iSnapping [ 33 ];


/*Entidades*/
new const g_iInfoTarget [ ] = "info_target";
new const g_iBlockClassName [ ] = "BG_Block";
new g_iRender [ BLOQUES_TOTALES ];
new g_iRed [ BLOQUES_TOTALES ];
new g_iGreen [ BLOQUES_TOTALES ];
new g_iBlue [ BLOQUES_TOTALES ];
new g_iTransparencia [ BLOQUES_TOTALES ];

new g_iGroupCount [ 33 ];
new g_iGroupedBlocks [ 33 ] [ 256 ];
new g_iGrab [ 33 ];
new g_iViewModel [ 33 ] [ 32 ];

new Float:g_iGrab_Offset [ 33 ] [ 3 ];
new Float:g_iGrab_Length [ 33 ];

/* Bloques Acciones */
new bool:g_iNoSlowDown [ 33 ];
new g_iDeagle [ 33 ];
new g_iAwp [ 33 ];
new g_iBichosSnark [ 33 ];
new g_iUsp [ 33 ];
new g_iM3 [ 33 ];
new g_iScout [ 33 ];
new g_iBlockExperiencia [ 33 ] [ BLOQUES_TOTALES ];


/* Bloques Menú */
new g_iKeysMainMenu;
new g_iKeysBloquesMenu;
new g_iKeysBloquesSelectionMenu;
new g_iKeysBloquesOpcionesMenu;

new g_iBlockMenu_Pagina [ BLOQUES_TOTALES ];
new g_iBlockMenu_PaginasMax;
new g_iBlockMenu_Principal [ 256 ];
new g_iBlockMenu_Bloques [ 256 ];
new g_iBlockMenu_Opciones [ 256 ];


/* Variables Normales */
new g_iNewFile [ 127 ];
new g_iMaxPlayers;


/* Prefix Server */
new const szPrefix [ ] = "!g[BREAKING GAMING]!y";

public plugin_init ( ) {

	register_plugin ( szPluginInfo [ 0 ], szPluginInfo [ 1 ], szPluginInfo [ 2 ] );
	
	
	register_clcmd ( "nightvision", "cmdBlockMakerMenu" );
	Henk_RegisterSayCmdTeam ( "bm", "cmdBlockMakerMenu", ADMIN_RCON, true );
	
	register_clcmd ( "BM_INGRESAR_DISTANCIA", "DistanciaSnapping" );
	register_clcmd ( "BM_INGRESAR_PROPIEDAD", "BM_INGRESAR_PROPIEDAD" );
	
	register_clcmd ( "+bmgrab", "cmdGrab" );
	register_clcmd ( "-bmgrab", "cmdUnGrab" );
	
	CargarMenus ( );
	
	register_menucmd ( register_menuid ( "MenuPrincipal" ),		g_iKeysMainMenu,	"HandlerMenuPricipal" );
	register_menucmd ( register_menuid ( "MenuBloques" ), 		g_iKeysBloquesMenu,	"HandlerBloquesMenu" );
	register_menucmd ( register_menuid ( "MenuSeleccionBloques" ),	g_iKeysBloquesSelectionMenu, "HandlerBloquesSeleccionMenu" );
	register_menucmd ( register_menuid ( "MenuOpcionesBloques" ),	g_iKeysBloquesOpcionesMenu,  "HandlerBloquesOpcionesMenu" );
	
	RegisterHam ( Ham_Spawn, "player", "Ham_Spawn_Function" );
	
	register_event ( "DeathMsg", "EventDeathMsg", "a" );
	register_event ( "TextMsg", "EventRoundRestart", "a", "2&#Game_C", "2&#Game_w" );
	register_logevent ( "EventRoundRestart", 2, "1=Round_Start" );
	
	new iDir [ 127 ], iMap [ 32 ];
	get_basedir ( iDir, sizeof ( iDir ) );
	add ( iDir, sizeof ( iDir ), "/BCM-Bloques" );
	
	if ( !dir_exists ( iDir ) )
	mkdir ( iDir );
	
	get_mapname ( iMap, sizeof ( iMap ) );
	formatex ( g_iNewFile, sizeof ( g_iNewFile ), "%s/%s.bm", iDir, iMap );
	
	g_iMaxPlayers = get_maxplayers ( );
}




public plugin_cfg ( )
	CargarBloques ( 0 );

public plugin_precache ( ) {


	new iBlockModelLarge [ 256 ], iBlockModelSmall [ 256 ];


	for ( new i = 0; i < sizeof ( szModels ); i++ ) {
		
		formatex ( iBlockModelLarge, sizeof ( iBlockModelLarge ), "%s", szModels [ i ] );
		replace ( iBlockModelLarge, sizeof ( iBlockModelLarge ), ".mdl", "_large.mdl" );
		
		formatex ( iBlockModelSmall, sizeof ( iBlockModelSmall ), "%s", szModels [ i ] );
		replace ( iBlockModelSmall, sizeof ( iBlockModelSmall ), ".mdl", "_small.mdl" );
		
		
		precache_model ( szModels [ i ] );
		precache_model ( iBlockModelLarge );
		precache_model ( iBlockModelSmall );
		
	
	}


}

public client_putinserver ( iIndex ) {
	
	g_iSnapping [ iIndex ] = true;
	
	g_iSnapping_gap [ iIndex ] = 0.0;
	
	g_iGroupCount [ iIndex ] = 0;
	
	ResetPlayers ( iIndex );

}

public client_disconnect ( iIndex ) {

	groupClear ( iIndex );

	if ( g_iGrab [ iIndex ] ) {
		if ( is_valid_ent ( g_iGrab [ iIndex ] ) ) {
			entity_set_int ( g_iGrab [ iIndex ], EV_INT_iuser2, 0 );
		}
	
		g_iGrab [ iIndex ] = 0;
	}

}

public EventRoundRestart ( iIndex ) {

	CargarBloques ( 0 );

	for ( new i = 1; i <= g_iMaxPlayers; i++ ) {
	
		if ( !is_user_connected ( i ) )
			continue;
		
		ResetPlayers ( i );
	}
	
}


public EventDeathMsg ( ) {
	
	new iPlayer = read_data ( 2 );
	
	if  ( !is_user_connected ( iPlayer ) )
		return;
	
	ResetPlayers ( iPlayer );
	
	
}

public Ham_Spawn_Function ( iIndex ) {
	
	if ( is_user_connected ( iIndex ) ) {
		
		g_iAwp [ iIndex ] = false;
		g_iDeagle [ iIndex ] = false;
		g_iM3 [ iIndex ] = false;
		g_iUsp [ iIndex ] = false;
		g_iBichosSnark [ iIndex ] = false;
		g_iScout [ iIndex ] = false;
		
		for ( new i = 0; i < BLOQUES_TOTALES; i++ )
			g_iBlockExperiencia [ iIndex ] [ i ] = false;
	}
	
}

public CargarMenus ( ) {
	
	g_iBlockMenu_PaginasMax = floatround ( ( float ( BLOQUES_TOTALES ) / 8.0 ), floatround_ceil );
	
	new iSize = sizeof ( g_iBlockMenu_Principal );
	add ( g_iBlockMenu_Principal, iSize, "\y[BREAKING GAMING] \wBlock Maker \d[PRINCIPAL]^n^n" );
	add ( g_iBlockMenu_Principal, iSize, "\y1. \wBloques^n" );
	add ( g_iBlockMenu_Principal, iSize, "\y2. \wOpciones^n^n^n" );
	add ( g_iBlockMenu_Principal, iSize, "\y3. \wPropiedades^n^n^n" );
	add ( g_iBlockMenu_Principal, iSize, "\y0. \wSalir^n" );
	g_iKeysMainMenu =  B1 | B2 | B3 | B4 | B5 | B6 | B7 | B8 | B0;
	
	iSize = sizeof ( g_iBlockMenu_Bloques );
	
	add ( g_iBlockMenu_Bloques, iSize, "\y[BREAKING GAMING] \wBlock Maker \d[BLOQUES #%d]^n^n" );
	add ( g_iBlockMenu_Bloques, iSize, "\y1. \wBloque: \r%s^n" );
	add ( g_iBlockMenu_Bloques, iSize, "\y2. \wCrear Bloque^n" );
	add ( g_iBlockMenu_Bloques, iSize, "\y3. \wBorrar Bloque^n" );
	add ( g_iBlockMenu_Bloques, iSize, "\y4. \wRotar Bloque^n^n^n" );
	add ( g_iBlockMenu_Bloques, iSize, "\y5. \wTamaÃ±o: \y%s^n^n^n" );
	add ( g_iBlockMenu_Bloques, iSize, "\y6. \wNoclip %s^n" );
	add ( g_iBlockMenu_Bloques, iSize, "\y7. \wGodmode %s^n^n^n" );
	add ( g_iBlockMenu_Bloques, iSize, "\y8. \wPropiedades^n^n^n" );
	add ( g_iBlockMenu_Bloques, iSize, "\y0. \wSalir" );
	g_iKeysBloquesMenu = B1 | B2 | B3 | B4 | B5 | B6 | B7 | B8 | B9 | B0;
	g_iKeysBloquesSelectionMenu = B1 | B2 | B3 | B4 | B5 | B6 | B7 | B8 | B9 | B0;
	
	
	iSize = sizeof ( g_iBlockMenu_Opciones );
	add ( g_iBlockMenu_Opciones, iSize, "\y[BREAKING GAMING] \wBlock Maker \d[OPCIONES]^n^n" );
	add ( g_iBlockMenu_Opciones, iSize, "\y1. \wAuto Acomodar %s^n" );
	add ( g_iBlockMenu_Opciones, iSize, "\y2. \wAcomodar Distancia^n" );
	add ( g_iBlockMenu_Opciones, iSize, "\y3. \wAgregar\d/\rSacar \wdel Grupo^n" );
	add ( g_iBlockMenu_Opciones, iSize, "\y4. \wBorrar Grupo^n" );
	add ( g_iBlockMenu_Opciones, iSize, "\y5. \wCargar Bloques^n" );
	add ( g_iBlockMenu_Opciones, iSize, "\y6. \wGuardar Bloques^n^n^n" );
	add ( g_iBlockMenu_Opciones, iSize, "\y0. \wSalir" );
	g_iKeysBloquesOpcionesMenu =  B1 | B2 | B3 | B4 | B5 | B6 | B7 | B8 | B0;
	
}

public client_PreThink ( iIndex ) {
	
	if ( !is_user_connected ( iIndex ) || !is_user_alive ( iIndex ) )
		return PLUGIN_HANDLED;
	
	
	new iEnt, iBody;
	get_user_aiming ( iIndex, iEnt, iBody, 320 );
	
	if ( isBlock ( iEnt ) && ( pev ( iIndex, pev_button ) & IN_USE && ! ( pev ( iIndex, pev_oldbuttons ) & IN_USE ) ) ) {
		
		new iBlockType = entity_get_int ( iEnt, EV_INT_body );
		/*
		new szCreador [ 33 ];
		GetCreatorName ( iEnt, szCreador, 32 );
		*/
		
		set_hudmessage ( 255, 255, 255, -1.0, 0.75, 0, 6.0, 6.0, 1.5, 1.5 );
		show_hudmessage ( iIndex, "[BREAKING GAMING]^nBloque: %s", szBloques [ iBlockType ] );
		
	}
	
	static Float:flOrigin [ 3 ], Float:vSize [ 3 ], Float:vTrace [ 3 ], Float:vReturn [ 3 ], Float:vMaxs [ 3 ];
	entity_get_vector ( iIndex, EV_VEC_origin, flOrigin );
	entity_get_vector ( iIndex, EV_VEC_size, vSize );
	entity_get_vector ( iIndex, EV_VEC_maxs, vMaxs );
	
	flOrigin [ 2 ] = flOrigin [ 2 ] - ( ( vSize [ 2 ] - 36.0 ) - ( vMaxs [ 2 ] - 36.0 ) );
	
	vTrace [ 2 ] = flOrigin [ 2 ] - 1.0;
	
	for ( new i = 0; i < 4; i++ ) {
		switch ( i ) {
			case 0: {
				vTrace [ 0 ] = flOrigin [ 0 ] - 16;
				vTrace [ 1 ] = flOrigin [ 1 ] + 16;
			}
			case 1: {
				vTrace [ 0 ] = flOrigin [ 0 ] + 16;
				vTrace [ 1 ] = flOrigin [ 1 ] + 16;
			}
			case 2: {
				vTrace [ 0 ] = flOrigin [ 0 ] + 16;
				vTrace [ 1 ] = flOrigin [ 1 ] - 16;
			}
			case 3: {
				vTrace [ 0 ] = flOrigin [ 0 ] - 16;
				vTrace [ 1 ] = flOrigin [ 1 ] - 16;
			}
		}
		
		iEnt = trace_line ( iIndex, flOrigin, vTrace, vReturn );
		
		if ( isBlock ( iEnt ) ) {
			
			new iBlockType = entity_get_int ( iEnt, EV_INT_body );
			
			switch ( iBlockType ) {
					case PLATAFORMA: 	Bloque_Plataforma ( iIndex, iEnt );
					case BUNNYHOP: 		Bloque_BunnyHop ( iEnt );
					case MUERTE:		Bloque_Muerte ( iIndex );
					case DANIO:		Bloque_Danio ( iIndex, iEnt );
					case NO_DANIO:		Bloque_NoDanio ( iIndex, iEnt );
					case VIDA:		Bloque_Vida ( iIndex, iEnt );
					//case HIELO:		Bloque_Hielo ( iIndex, iEnt );
					case TRAMPOLIN:		Bloque_Trampolin ( iIndex, iEnt );
					case GRAVEDAD:		Bloque_Gravedad ( iIndex, iEnt );
					case AWP:		Bloque_Awp ( iIndex, iEnt );
					case DEAGLE: 		Bloque_Deagle ( iIndex, iEnt );
					case USP:		Bloque_Usp ( iIndex, iEnt );
					case M3:		Bloque_M3 ( iIndex, iEnt );
					case SCOUT:		Bloque_Scout ( iIndex, iEnt );
					
				
				
			}
		}
	}
	
	vTrace [ 2 ] = flOrigin [ 2 ] - 20.0;
	
	for ( new i = 0; i < 4; i++ ) {
		switch ( i ) {
			case 0: {
				vTrace [ 0 ] = flOrigin [ 0 ] - 16;
				vTrace [ 1 ] = flOrigin [ 1 ] + 16;
			}
			case 1: {
				vTrace [ 0 ] = flOrigin [ 0 ] + 16;
				vTrace [ 1 ] = flOrigin [ 1 ] + 16;
			}
			case 2: {
				vTrace [ 0 ] = flOrigin [ 0 ] + 16;
				vTrace [ 1 ] = flOrigin [ 1 ] - 16;
			}
			case 3: {
				vTrace [ 0 ] = flOrigin [ 0 ] - 16;
				vTrace [ 1 ] = flOrigin [ 1 ] - 16;
			}
		}
		
		iEnt = trace_line ( iIndex, flOrigin, vTrace, vReturn );
		
		if ( isBlock ( iEnt ) ) {
			
			new iBlockType = entity_get_int ( iEnt, EV_INT_body );
			
			switch ( iBlockType ) {
				case TRAMPOLIN: Bloque_Trampolin ( iIndex, iEnt );
			}
		}
	}
	
	
	
	new iButtons = get_user_button ( iIndex );
	new iOldButtons = get_user_oldbutton ( iIndex );
	
	if ( g_iGrab [ iIndex ] > 0 ) {
		
		if ( iButtons & IN_JUMP && ! ( iOldButtons & IN_JUMP ) ) {
			
			if ( g_iGrab_Length [ iIndex ] > 72.0 ) 
				g_iGrab_Length [ iIndex ] -= 16.0;
			
		}
		if ( iButtons & IN_DUCK && ! ( iOldButtons & IN_DUCK ) ) {
			
			g_iGrab_Length [ iIndex ] += 16.0;
			
		}
		if ( iButtons & IN_ATTACK && ! ( iOldButtons & IN_ATTACK ) ) {
			
			if ( iButtons & IN_ATTACK2 && ! ( iOldButtons & IN_ATTACK2 ) ) {
				
				if ( isBlock ( g_iGrab [ iIndex ] ) ) {
					
					if ( isBlockInGroup ( iIndex, g_iGrab [ iIndex ] ) && g_iGroupCount [ iIndex ] > 1 ) {
						new iBlock;
						
						for ( new i = 0; i <= g_iGroupCount[ iIndex ]; i++ ) {
							iBlock = g_iGroupedBlocks [ iIndex ] [ i ];
							
							if ( isBlockInGroup ( iIndex, iBlock ) ) {
								if ( !isBlockStuck ( iBlock ) )
									CopiarBloque ( iBlock );
							}
						}
					}
					else {
						if ( !isBlockStuck ( g_iGrab [ iIndex ] ) ) {
							new iNewBlock = CopiarBloque ( g_iGrab [ iIndex ] );
							
							if ( iNewBlock ) {
								
								entity_set_int ( g_iGrab [ iIndex ], EV_INT_iuser2, 0 );
								entity_set_int ( iNewBlock, EV_INT_iuser2, iIndex );
								
								g_iGrab [ iIndex ] = iNewBlock;
							}
						}
						else Henk_SayPrint ( iIndex, "%s No puedes copiar un bloque que se encuentra trabado", szPrefix );
					}
				}
			}
		}
		
		if ( iButtons & IN_RELOAD && ! ( iOldButtons & IN_RELOAD ) ) {
			
			if ( isBlock ( g_iGrab [ iIndex ] ) ) {
				if ( isBlockInGroup ( iIndex, g_iGrab [ iIndex ] ) && g_iGroupCount [ iIndex ] > 1 ) {
					
					new iBlock;
					
					for ( new i = 0; i <= g_iGroupCount[ iIndex ]; i++ ) {
						
						iBlock = g_iGroupedBlocks [ iIndex ] [ i ];
						
						if ( isBlockInGroup ( iIndex, iBlock ) ) {
							if ( !isBlockStuck ( iBlock ) )
								RotarBloque ( iBlock );
						}
					}
				}
				else RotarBloque ( g_iGrab [ iIndex ] );
			}
		}
		
		iButtons &= ~IN_ATTACK;
		entity_set_int ( iIndex, EV_INT_button, iButtons );
		
		if ( is_valid_ent ( g_iGrab [ iIndex ] ) ) {
			if ( isBlockInGroup ( iIndex, g_iGrab [ iIndex ] ) && g_iGroupCount [ iIndex ] > 1 ) {
				static Float:vMoveTo [ 3 ], Float:vOffset [ 3 ], Float:vOrigin [ 3 ];
				new iBlock;
				
				MoveGrabEntity ( iIndex, vMoveTo );
				
				for ( new i = 0; i <= g_iGroupCount[ iIndex ]; i++ ) {
					iBlock = g_iGroupedBlocks [ iIndex ] [ i ];
					
					if ( isBlockInGroup ( iIndex, iBlock ) ) {
						entity_get_vector ( iBlock, EV_VEC_vuser1, vOffset );
						
						vOrigin [ 0 ] = vMoveTo [ 0 ] - vOffset [ 0 ];
						vOrigin [ 1 ] = vMoveTo [ 1 ] - vOffset [ 1 ];
						vOrigin [ 2 ] = vMoveTo [ 2 ] - vOffset [ 2 ];
						
						MoverEntidad ( iIndex, iBlock, vOrigin, false );
					}
				}
			}
			else MoveGrabEntity ( iIndex );
		}
		else cmdUnGrab ( iIndex );
	}
	
	
	return PLUGIN_CONTINUE;
	
}

public pfn_touch ( iEnt, iIndex ) {
	
	if ( 1 <= iIndex <= 32 && is_user_alive ( iIndex ) ) {
		
		if ( isBlock ( iEnt ) ) {
			
			new iBlockType = entity_get_int ( iEnt, EV_INT_body );
			
			if ( iBlockType == BUNNYHOP ) {
				
				if ( !task_exists ( TASK_BHOPSOLIDNOT + iEnt ) && !task_exists ( TASK_BHOPSOLID + iEnt ) ) {
					if ( iBlockType == BUNNYHOP ) {
						
						new iPropiedad [ 33 ], iPropiedad2 [ 33 ];
						ObtenerPropiedad ( iEnt, 1, iPropiedad );
						ObtenerPropiedad ( iEnt, 4, iPropiedad2 );
						
						if ( equal ( iPropiedad, "Si" ) || equal ( iPropiedad, "1" ) ) {
							g_iNoSlowDown [ iIndex ] = true; 
							set_task ( 1.0, "TaskNotNoSlowDown", iIndex );
						}
						
						if ( equal ( iPropiedad2, "No" ) || equal ( iPropiedad2, "0" ) )
							set_task ( 0.1, "taskSolidNot", TASK_BHOPSOLID + iEnt );
						else {
							static Float:flOrigin [ 3 ];
							pev ( iIndex, pev_origin, flOrigin );
							
							engfunc ( EngFunc_TraceHull, flOrigin, flOrigin, 0, ( pev ( iIndex, pev_flags ) & FL_DUCKING ) ? HULL_HEAD : HULL_HUMAN, iIndex, 0 );
							
							if ( get_tr2 ( 0, TR_StartSolid ) || get_tr2 ( 0, TR_AllSolid ) || !get_tr2 ( 0, TR_InOpen ) ) {
								if ( !task_exists ( TASK_BHOPSOLIDNOT + iEnt ) && !task_exists ( TASK_BHOPSOLID + iEnt ) )
									
								set_task ( 0.1, "taskSolidNot", TASK_BHOPSOLIDNOT + iEnt );
							}
						}
					}
				}
			}
			
			if ( iBlockType == GRAVEDAD ) {
				
				if ( pev ( iIndex, pev_flags ) & FL_ONGROUND ) {
					set_user_gravity ( iIndex, 1.0 );
				}
			}
			
			
		}
	}
	
	return PLUGIN_CONTINUE;
}

public server_frame ( ) {
	
	for ( new i = 1; i <= g_iMaxPlayers; i++ ) {
		
		if ( !is_user_alive ( i ) )
			continue;
		
		if ( g_iNoSlowDown [ i ] )
			entity_set_float ( i, EV_FL_fuser2, 0.0 );
	}
}



public TaskNotNoSlowDown ( iIndex ) {
	
	if ( g_iNoSlowDown [ iIndex ] )
		g_iNoSlowDown [ iIndex ] = false;
}

public taskSolidNot ( iEnt ) {
	
	iEnt -= TASK_BHOPSOLIDNOT;
	
	if ( is_valid_ent ( iEnt ) ) {
		
		if ( entity_get_int ( iEnt, EV_INT_iuser2 ) == NULL ) {
			
			entity_set_int ( iEnt, EV_INT_solid, SOLID_NOT );
			set_rendering ( iEnt, kRenderFxNone, 255, 255, 255, kRenderTransAdd, 25 );
			set_task ( 1.0, "TaskSolid", TASK_BHOPSOLID + iEnt );
		}
	}
}



public TaskSolid ( iEnt ) {
	
	iEnt -= TASK_BHOPSOLID;
	
	if ( isBlock ( iEnt ) ) {
		
		entity_set_int ( iEnt, EV_INT_solid, SOLID_BBOX );
		
		if ( entity_get_int ( iEnt, EV_INT_iuser1 ) > 0 ) {
			groupBlock ( 0, iEnt );
		}
		else {
			new iPropiedad [ 33 ];
			ObtenerPropiedad ( iEnt, 3, iPropiedad );
			
			new iTrans = str_to_float ( iPropiedad );
			
			set_pev ( iEnt, pev_rendermode, kRenderTransTexture );
			set_pev ( iEnt, pev_renderamt, iTrans );
			
			new iBlockType = entity_get_int ( iEnt, EV_INT_body );
			
			if ( !iTrans || iTrans == 255 ) {
				SetBlockRendering ( iEnt, g_iRender [ iBlockType ], g_iRed [ iBlockType ], g_iGreen [ iBlockType ], g_iBlue [ iBlockType ], g_iTransparencia [ iBlockType ] );
			}
			else {
				new iPropiedad [ 33 ];
				ObtenerPropiedad ( iEnt, 3, iPropiedad );
				
				set_pev ( iEnt, pev_rendermode, kRenderTransTexture );
				set_pev ( iEnt, pev_renderamt, iTrans );
			}
			
			/*
			new iTrans = str_to_num ( iPropiedad );
			
			new iBlockType = entity_get_int ( iEnt, EV_INT_body );
			
			if ( !iTrans || iTrans == 255 ) {
				
				SetBlockRendering ( iEnt, g_iRender [ iBlockType ], g_iRed [ iBlockType ], g_iGreen [ iBlockType ], g_iBlue [ iBlockType ], g_iTransparencia [ iBlockType ] );
			}
			else {
				SetBlockRendering ( iEnt, TRANSALPHA, 255, 255, 255, iTrans );
			}
			*/
			
			
			
		}
	}
}

public TaskGravedadNot ( iIndex ) {
	
	iIndex -= TASK_GRAVEDAD;
	
	if ( is_user_connected ( iIndex ) ) set_user_gravity ( iIndex, 1.0 );
}
	

public Bloque_Plataforma ( iIndex, iEnt ) {
	
	new iText [ 256 ];
	ObtenerPropiedad ( iEnt, 1, iText );
	if ( strlen ( iText ) ) {
		set_hudmessage ( random(255), random(255), random(255), -1.0, 0.35, 0, 6.0, 0.1, 0.0, 0.0 );
		show_hudmessage ( iIndex, "%s", iText );
	}
}

public Bloque_BunnyHop ( iEnt ) {
	
	set_task ( 0.1, "taskSolidNot", TASK_BHOPSOLIDNOT + iEnt );
}


public Bloque_Muerte ( iIndex ) {
	
	new iName [ 33 ]; get_user_name ( iIndex, iName, 32 );
	
	if ( get_user_godmode ( iIndex ) ) {
		
		Henk_SayPrint ( iIndex, "%s Tienes GODMODE!", szPrefix );
	}
	else {
		fakedamage ( iIndex, "The Block of Death", 10000.0, DMG_GENERIC );
		
		Henk_SayPrint ( 0, "%s El jugador !g%s !ymurio por un bloque de !gMuerte", szPrefix, iName );
	}
}

public Bloque_Vida ( iIndex, iEnt ) {
	
	if ( cs_get_user_team ( iIndex ) == CS_TEAM_T ) {
		static Float:flGameTime [ 33 ];
		if ( get_gametime ( ) - flGameTime [ iIndex ] > 1 ) {
			
			flGameTime [ iIndex ] = get_gametime ( );
			
			new iPropiedad [ 33 ]; 
			ObtenerPropiedad ( iEnt, 1, iPropiedad );
			
			new iVida = pev ( iIndex, pev_health );
			
			if ( iVida <= 100.0 ) {
				
				set_pev ( iIndex, pev_health, iVida += str_to_float ( iPropiedad ) );
			}
		}
	}
}

public Bloque_Trampolin ( iIndex, iEnt ) {
	
	new iPropiedad [ 33 ]; 
	ObtenerPropiedad ( iEnt, 1, iPropiedad );

	new Float:flVelocity [ 3 ];
	pev ( iIndex, pev_velocity, flVelocity ); 
	
	flVelocity [ 2 ] = str_to_float ( iPropiedad );
	
	set_pev ( iIndex, pev_velocity, flVelocity );
	
}



public Bloque_Danio ( iIndex, iEnt ) {
	
	if ( cs_get_user_team ( iIndex ) == CS_TEAM_T ) {
		static Float:flGameTime [ 33 ];
		
		new iName [ 33 ]; get_user_name ( iIndex, iName, 32 );
		
		if ( get_gametime ( ) - flGameTime [ iIndex ] > 1 ) {
			
			flGameTime [ iIndex ] = get_gametime ( );
			
			new iPropiedad [ 33 ]; 
			ObtenerPropiedad ( iEnt, 1, iPropiedad );
			
			static Float:flVida;
			pev ( iIndex, pev_health, flVida );
			
			if ( flVida > 0 ) {
				
				
				fakedamage ( iIndex, "damage block", str_to_float ( iPropiedad ), DMG_CRUSH );
				
				if ( get_user_health ( iIndex ) <= 0 ) Henk_SayPrint ( 0, "%s El jugador !g%s !ymurio por un bloque de !gDaño", szPrefix, iName );
			}
		}
	}
}


public Bloque_NoDanio ( iIndex, iEnt ) {
	
	set_pev ( iIndex, pev_watertype, CONTENTS_WATER );
}

public Bloque_Gravedad ( iIndex, iEnt ) {
	
	new Float:flGravedad;
	new iPropiedad [ 33 ];
	ObtenerPropiedad ( iEnt, 1, iPropiedad );
	
	flGravedad = str_to_float ( iPropiedad );
	
	set_user_gravity ( iIndex, flGravedad / 800.0 );
	if ( task_exists ( iIndex + TASK_GRAVEDAD ) )
		remove_task ( iIndex + TASK_GRAVEDAD );
		
	set_task ( 1.0, "TaskGravedadNot", TASK_GRAVEDAD + iIndex );
	
}

public Bloque_Awp ( iIndex, iEnt ) {
	
	if ( !g_iAwp [ iIndex ] && cs_get_user_team ( iIndex ) == CS_TEAM_T ) {
		
		
		new iName [ 33 ]; get_user_name ( iIndex, iName, 32 );
		
		new iPropiedad [ 33 ];
		ObtenerPropiedad ( iEnt, 1, iPropiedad );
		
		new iPropiedad2 [ 33 ];
		ObtenerPropiedad ( iEnt, 4, iPropiedad2 );
		
		new iPropiedad3 [ 33 ];
		ObtenerPropiedad ( iEnt, 2, iPropiedad3 );
		
		cs_set_weapon_ammo ( give_item ( iIndex, "weapon_awp" ), str_to_num ( iPropiedad ) );
		cs_set_user_bpammo ( iIndex, CSW_AWP, str_to_num ( iPropiedad2 ) );
		
		g_iAwp [ iIndex ] = true;
		
		new RGB [ 3 ];
		RGB [ 0 ] = random_num ( 0, 255 );
		RGB [ 1 ] = random_num ( 0, 255 );
		RGB [ 2 ] = random_num ( 0, 255 );
		
		set_hudmessage ( RGB[0], RGB[1], RGB[2], -1.0, 0.11, 2, 6.0, 12.0 );
		show_hudmessage ( 0, "El jugador %s agarro una AWP con %d bala%s", iName, str_to_num ( iPropiedad ), str_to_num ( iPropiedad ) >= 2 ? "s" : "" );
		
		new iExperiencia = str_to_num ( iPropiedad3 );
		
		if ( !strlen ( iPropiedad3 ) || cs_get_user_team ( iIndex ) != CS_TEAM_T || g_iBlockExperiencia [ iIndex ] [ AWP ] )
			return PLUGIN_HANDLED;
		
		
		g_iBlockExperiencia [ iIndex ] [ AWP ] = true;
		
		Henk_SayPrint ( iIndex, "%s El bloque !g%s !yte dio !g%s EXP", szPrefix, szBloques [ AWP ], AddComas ( iExperiencia ) );
		
		
		
	}
	
	return PLUGIN_HANDLED;
}

public Bloque_Deagle ( iIndex, iEnt ) {
	
	if ( !g_iDeagle [ iIndex ] && cs_get_user_team ( iIndex ) == CS_TEAM_T ) {
		
		
		new iName [ 33 ]; get_user_name ( iIndex, iName, 32 );
		
		new iPropiedad [ 33 ];
		ObtenerPropiedad ( iEnt, 1, iPropiedad );
		
		new iPropiedad2 [ 33 ];
		ObtenerPropiedad ( iEnt, 4, iPropiedad2 );
		
		new iPropiedad3 [ 33 ];
		ObtenerPropiedad ( iEnt, 2, iPropiedad3 );
		
		cs_set_weapon_ammo ( give_item ( iIndex, "weapon_deagle" ), str_to_num ( iPropiedad ) );
		cs_set_user_bpammo ( iIndex, CSW_DEAGLE, str_to_num ( iPropiedad2 ) );
		
		g_iDeagle [ iIndex ] = true;
		
		new RGB [ 3 ];
		RGB [ 0 ] = random_num ( 0, 255 );
		RGB [ 1 ] = random_num ( 0, 255 );
		RGB [ 2 ] = random_num ( 0, 255 );
		
		set_hudmessage ( RGB[0], RGB[1], RGB[2], -1.0, 0.11, 2, 6.0, 12.0 );
		show_hudmessage ( 0, "El jugador %s agarro una DEAGLE con %d bala%s", iName, str_to_num ( iPropiedad ), str_to_num ( iPropiedad ) >= 2 ? "s" : "" );
		
		new iExperiencia = str_to_num ( iPropiedad3 );
		
		if ( !strlen ( iPropiedad3 ) || cs_get_user_team ( iIndex ) != CS_TEAM_T || g_iBlockExperiencia [ iIndex ] [ DEAGLE ] )
			return PLUGIN_HANDLED;
		
		
		g_iBlockExperiencia [ iIndex ] [ DEAGLE ] = true;
		
		Henk_SayPrint ( iIndex, "%s El bloque !g%s !yte dio !g%s EXP", szPrefix, szBloques [ DEAGLE ], AddComas ( iExperiencia ) );
		
		
		
	}
	
	return PLUGIN_HANDLED;
	
}

public Bloque_Scout ( iIndex, iEnt ) {
	
	if ( !g_iScout [ iIndex ] && cs_get_user_team ( iIndex ) == CS_TEAM_T ) {
		
		
		new iName [ 33 ]; get_user_name ( iIndex, iName, 32 );
		
		new iPropiedad [ 33 ];
		ObtenerPropiedad ( iEnt, 1, iPropiedad );
		
		new iPropiedad2 [ 33 ];
		ObtenerPropiedad ( iEnt, 4, iPropiedad2 );
		
		new iPropiedad3 [ 33 ];
		ObtenerPropiedad ( iEnt, 2, iPropiedad3 );
		
		cs_set_weapon_ammo ( give_item ( iIndex, "weapon_scout" ), str_to_num ( iPropiedad ) );
		cs_set_user_bpammo ( iIndex, CSW_SCOUT, str_to_num ( iPropiedad2 ) );
		
		g_iScout [ iIndex ] = true;
		
		new RGB [ 3 ];
		RGB [ 0 ] = random_num ( 0, 255 );
		RGB [ 1 ] = random_num ( 0, 255 );
		RGB [ 2 ] = random_num ( 0, 255 );
		
		set_hudmessage ( RGB[0], RGB[1], RGB[2], -1.0, 0.11, 2, 6.0, 12.0 );
		show_hudmessage ( 0, "El jugador %s agarro una SCOUT con %d bala%s", iName, str_to_num ( iPropiedad ), str_to_num ( iPropiedad ) >= 2 ? "s" : "" );
		
		new iExperiencia = str_to_num ( iPropiedad3 );
		
		if ( !strlen ( iPropiedad3 ) || cs_get_user_team ( iIndex ) != CS_TEAM_T || g_iBlockExperiencia [ iIndex ] [ SCOUT ] )
			return PLUGIN_HANDLED;
		
		
		g_iBlockExperiencia [ iIndex ] [ SCOUT ] = true;
		
		Henk_SayPrint ( iIndex, "%s El bloque !g%s !yte dio !g%s EXP", szPrefix, szBloques [ SCOUT ], AddComas ( iExperiencia ) );
		
		
		
	}
	
	return PLUGIN_HANDLED;
	
}

public Bloque_Usp ( iIndex, iEnt ) {
	
	if ( !g_iUsp [ iIndex ] && cs_get_user_team ( iIndex ) == CS_TEAM_T ) {
		
		
		new iName [ 33 ]; get_user_name ( iIndex, iName, 32 );
		
		new iPropiedad [ 33 ];
		ObtenerPropiedad ( iEnt, 1, iPropiedad );
		
		new iPropiedad2 [ 33 ];
		ObtenerPropiedad ( iEnt, 4, iPropiedad2 );
		
		new iPropiedad3 [ 33 ];
		ObtenerPropiedad ( iEnt, 2, iPropiedad3 );
		
		cs_set_weapon_ammo ( give_item ( iIndex, "weapon_usp" ), str_to_num ( iPropiedad ) );
		cs_set_user_bpammo ( iIndex, CSW_USP, str_to_num ( iPropiedad2 ) );
		
		g_iUsp  [ iIndex ] = true;
		
		new RGB [ 3 ];
		RGB [ 0 ] = random_num ( 0, 255 );
		RGB [ 1 ] = random_num ( 0, 255 );
		RGB [ 2 ] = random_num ( 0, 255 );
		
		set_hudmessage ( RGB[0], RGB[1], RGB[2], -1.0, 0.11, 2, 6.0, 12.0 );
		show_hudmessage ( 0, "El jugador %s agarro una USP con %d bala%s", iName, str_to_num ( iPropiedad ), str_to_num ( iPropiedad ) >= 2 ? "s" : "" );
		
		new iExperiencia = str_to_num ( iPropiedad3 );
		
		if ( !strlen ( iPropiedad3 ) || cs_get_user_team ( iIndex ) != CS_TEAM_T || g_iBlockExperiencia [ iIndex ] [ USP ] )
			return PLUGIN_HANDLED;
		
		
		g_iBlockExperiencia [ iIndex ] [ USP ] = true;
		
		Henk_SayPrint ( iIndex, "%s El bloque !g%s !yte dio !g%s EXP", szPrefix, szBloques [ USP ], AddComas ( iExperiencia ) );
		
		
		
	}
	
	return PLUGIN_HANDLED;
	
}

public Bloque_M3 ( iIndex, iEnt ) {
	
	if ( !g_iM3 [ iIndex ] && cs_get_user_team ( iIndex ) == CS_TEAM_T ) {
		
		
		new iName [ 33 ]; get_user_name ( iIndex, iName, 32 );
		
		new iPropiedad [ 33 ];
		ObtenerPropiedad ( iEnt, 1, iPropiedad );
		
		new iPropiedad2 [ 33 ];
		ObtenerPropiedad ( iEnt, 4, iPropiedad2 );
		
		new iPropiedad3 [ 33 ];
		ObtenerPropiedad ( iEnt, 2, iPropiedad3 );
		
		cs_set_weapon_ammo ( give_item ( iIndex, "weapon_m3" ), str_to_num ( iPropiedad ) );
		cs_set_user_bpammo ( iIndex, CSW_M3, str_to_num ( iPropiedad2 ) );
		
		g_iM3  [ iIndex ] = true;
		
		new RGB [ 3 ];
		RGB [ 0 ] = random_num ( 0, 255 );
		RGB [ 1 ] = random_num ( 0, 255 );
		RGB [ 2 ] = random_num ( 0, 255 );
		
		set_hudmessage ( RGB[0], RGB[1], RGB[2], -1.0, 0.11, 2, 6.0, 12.0 );
		show_hudmessage ( 0, "El jugador %s agarro una M3 con %d bala%s", iName, str_to_num ( iPropiedad ), str_to_num ( iPropiedad ) >= 2 ? "s" : "" );
		
		new iExperiencia = str_to_num ( iPropiedad3 );
		
		if ( !strlen ( iPropiedad3 ) || cs_get_user_team ( iIndex ) != CS_TEAM_T || g_iBlockExperiencia [ iIndex ] [ M3 ] )
			return PLUGIN_HANDLED;
		
		
		g_iBlockExperiencia [ iIndex ] [ M3 ] = true;
		
		Henk_SayPrint ( iIndex, "%s El bloque !g%s !yte dio !g%s EXP", szPrefix, szBloques [ M3 ], AddComas ( iExperiencia ) );
		
		
		
	}
	
	return PLUGIN_HANDLED;
	
	
}


public cmdGrab ( iIndex ) {
	
	if ( ! ( get_user_flags ( iIndex ) & ADMIN_RCON ) ) {
		Henk_SayPrint ( iIndex, "%s No tienes acceso", szPrefix);
		return PLUGIN_HANDLED;
	}	
	
	
	new iEnt, iBody;
	
	g_iGrabLength [ iIndex ] = get_user_aiming ( iIndex, iEnt, iBody );
	
	new bool:bIsBlock = isBlock ( iEnt );
	
	if ( !bIsBlock ) {
		Henk_SayPrint ( iIndex, "%s No estas apuntando a un bloque", szPrefix );
		
	}
	
	new iGrab = entity_get_int ( iEnt, EV_INT_iuser2 );
	
	if ( iGrab == 0 || iGrab == iIndex ) {
		
		if ( bIsBlock ) {
			
			new iPlayer = entity_get_int ( iEnt, EV_INT_iuser1 );
			
			if ( iPlayer == 0 || iPlayer == iIndex ) {
				SetGrab ( iIndex, iEnt );
				
				if ( iPlayer == iIndex && g_iGroupCount [ iIndex ] > 1 ) {
					static Float:vGrabbedOrigin [ 3 ], Float:flOrigin [ 3 ], Float:vOffset [ 3 ];
					new iBlock;
					
					entity_get_vector ( iEnt, EV_VEC_origin, vGrabbedOrigin );
					
					for ( new i = 0; i <= g_iGroupCount [ iIndex ]; i++ ) {
						
						iBlock = g_iGroupedBlocks [ iIndex ] [ i ];
						
						if ( is_valid_ent ( iBlock ) ) {
							
							iPlayer = entity_get_int ( iEnt, EV_INT_iuser1 );
							
							if ( iPlayer == iIndex ) {
								entity_get_vector ( iBlock, EV_VEC_origin, flOrigin );
								
								vOffset [ 0 ] = vGrabbedOrigin [ 0 ] - flOrigin [ 0 ];
								vOffset [ 1 ] = vGrabbedOrigin [ 1 ] - flOrigin [ 1 ];
								vOffset [ 2 ] = vGrabbedOrigin [ 2 ] - flOrigin [ 2 ];
								
								entity_set_vector ( iBlock, EV_VEC_vuser1, vOffset );
								
								entity_set_int ( iBlock, EV_INT_iuser2, iIndex );
							}
						}
					}
				}
			}
		}
	}
	
	
	return PLUGIN_HANDLED;
}


public cmdUnGrab ( iIndex ) {
	
	if ( ! ( get_user_flags ( iIndex ) & ADMIN_RCON ) ) {
		Henk_SayPrint ( iIndex, "%s No tienes acceso", szPrefix);
		return PLUGIN_HANDLED;
	}
	/*
	entity_set_string( iIndex, EV_SZ_viewmodel, g_iViewModel[ iIndex ] );
	
	g_iGrab[ iIndex ] = 0;
	*/
	
	
	if ( g_iGrab [ iIndex ] ) {
		
		if ( isBlock ( g_iGrab [ iIndex ] ) ) {
			if ( isBlockInGroup ( iIndex, g_iGrab [ iIndex ] ) && g_iGroupCount [ iIndex ] > 1 ) {
				
				new iBlock;
				new bool:bStuck = true;
				
				for ( new i = 0; i <= g_iGroupCount [ iIndex ]; i++ ) {
					
					iBlock = g_iGroupedBlocks [ iIndex ] [ i ];
					
					if ( isBlockInGroup ( iIndex, iBlock ) ) {
						entity_set_int ( iBlock, EV_INT_iuser2, 0 );
						
						if ( bStuck ) {
							if ( !isBlockStuck ( iBlock ) ) {
								bStuck = false;
							}
						}
					}
				}
				
				if ( bStuck ) {
					
					for ( new i = 0; i <= g_iGroupCount [ iIndex ]; i++ ) {
						
						iBlock = g_iGroupedBlocks [ iIndex ] [ i ];
						
						if ( isBlockInGroup ( iIndex, iBlock ) )
							BorrarBloque ( iBlock );
						
					}
					
					Henk_SayPrint ( iIndex, "%s Grupo borrado, se encontraba trabado", szPrefix );
				}
			}
			else {
				if ( is_valid_ent ( g_iGrab [ iIndex ] ) ) {
					
					if ( isBlockStuck ( g_iGrab [ iIndex ] ) ) {
						
						new Borrado = BorrarBloque ( g_iGrab [ iIndex ] );
						
						if ( Borrado ) {
							Henk_SayPrint ( iIndex, "%s Bloque borrado, estaba trabado", szPrefix );
						}
					}
					else {
						entity_set_int ( g_iGrab [ iIndex ], EV_INT_iuser2, 0 );
					}
				}
			}
		}
		
		entity_set_string ( iIndex, EV_SZ_viewmodel, g_iViewModel [ iIndex ] );
		
		g_iGrab [ iIndex ] = 0;
	}
	
	
	return PLUGIN_HANDLED;
	
	
}

SetGrab(id, ent)
{
	new Float:fpOrigin[3];
	new Float:fbOrigin[3];
	new Float:fAiming[3];
	new iAiming[3];
	new bOrigin[3];
	
	entity_get_string(id, EV_SZ_viewmodel, g_iViewModel[id], 32);
	entity_set_string(id, EV_SZ_viewmodel, "");
	
	get_user_origin(id, bOrigin, 1);			
	get_user_origin(id, iAiming, 3);			
	entity_get_vector(id, EV_VEC_origin, fpOrigin);		
	entity_get_vector(ent, EV_VEC_origin, fbOrigin);	
	IVecFVec(iAiming, fAiming);
	FVecIVec(fbOrigin, bOrigin);
	
	g_iGrab[id] = ent;
	g_iGrab_Offset[id][0] = fbOrigin[0] - iAiming[0];
	g_iGrab_Offset[id][1] = fbOrigin[1] - iAiming[1];
	g_iGrab_Offset[id][2] = fbOrigin[2] - iAiming[2];
	
	entity_set_int(ent, EV_INT_iuser2, id);

}


public cmdBlockMakerMenu ( iIndex ) {

	if ( ! ( get_user_flags ( iIndex ) & ADMIN_RCON ) ) {
		Henk_SayPrint ( iIndex, "%s No tienes acceso", szPrefix);
		return PLUGIN_HANDLED;
	}
	
	new iMenu [ 256 ];
	
	format ( iMenu, sizeof ( iMenu ), g_iBlockMenu_Principal );
	
	show_menu ( iIndex, g_iKeysMainMenu, iMenu, -1, "MenuPrincipal" );
	
	return PLUGIN_HANDLED;

}

public HandlerMenuPricipal ( iIndex, iKey ) {

	switch ( iKey ) {
		case N1: BloquesMenu ( iIndex );
		case N2: BloquesOpcionesMenu ( iIndex );
		case N3: BloquesMenuPropiedades ( iIndex );
		case N0: return;
			
		
	}	
	return;
}

public BloquesMenu ( iIndex ) {
	
	if ( ! ( get_user_flags ( iIndex ) & ADMIN_RCON ) ) {
		Henk_SayPrint ( iIndex, "%s No tienes acceso", szPrefix);
		return PLUGIN_HANDLED;
	}
	
	new iEnt = -1;
	new iBlockCount = 0;
	new iMenu [ 300 ];
	new szSize [ 17 ];
	
	
	while ( ( iEnt = find_ent_by_class ( iEnt, g_iBlockClassName ) ) ) {
		iBlockCount++;
	}
	
	
	switch ( g_iBloqueSelected_Size [ iIndex ] )
	{
		case SMALL: szSize = "Small";
		case NORMAL: szSize = "Normal";
		case LARGE: szSize = "Large";
	}
	
	
	
	format ( iMenu, sizeof ( iMenu ), g_iBlockMenu_Bloques, iBlockCount, szBloques [ g_iBloqueSelected_Type [ iIndex ] ], szSize, get_user_noclip ( iIndex ) ? "\yActivado" : "\rDesactivado", get_user_godmode ( iIndex ) ? "\yActivado" : "\rDesactivado" );
	
	show_menu ( iIndex, g_iKeysBloquesMenu, iMenu, -1, "MenuBloques" );
	
	return PLUGIN_HANDLED;
	
}

public HandlerBloquesMenu ( iIndex, iKey ) {
	
	switch ( iKey ) {
		
		case N1:{ 
			g_iBlockMenu_Pagina [ iIndex ] = 1;
			BloquesSeleccionMenu ( iIndex );
		}
		case N2: CrearBloqueAim ( iIndex, g_iBloqueSelected_Type [ iIndex ] );
		case N3: BorrarBloque ( iIndex );
		case N4: RotarBloqueAim ( iIndex );
		case N5: changeBlockSize ( iIndex );
		case N6: { set_user_noclip ( iIndex, !get_user_noclip ( iIndex ) ); cmdBlockMakerMenu ( iIndex ); }
		case N7: { set_user_godmode ( iIndex, !get_user_godmode ( iIndex ) ); cmdBlockMakerMenu ( iIndex ); }
		case N8: BloquesMenuPropiedades ( iIndex );
	}
	
	
	if ( iKey != N1 && iKey != N0 )
		BloquesMenu ( iIndex );
	
	
	
}


public BloquesSeleccionMenu ( iIndex ) {
	
	new iBlockMenu [ 256 ];
	new iTitle [ 256 ]; formatex ( iTitle, sizeof ( iTitle ), "\y[BREAKING GAMING] \wSelecciona el Bloque: \r%d^n^n", g_iBlockMenu_Pagina [ iIndex ] ),
	add ( iBlockMenu, sizeof ( iBlockMenu ), iTitle );
	new iLen [ 127 ];
	new iPagina, iNum;
	
	iPagina = ( g_iBlockMenu_Pagina [ iIndex ] - 1 ) * 8;
	
	for ( new i = iPagina; i < iPagina + 8; i++ ) {
		
		if ( i < BLOQUES_TOTALES ) {
			
			iNum = ( i - iPagina ) + 1 ;
			
			format ( iLen, sizeof ( iLen ), "\y%d. \w%s^n", iNum, szBloques [ i ] );
		}
		else {
			format ( iLen, sizeof ( iLen ), "^n" );
		}
		
		add ( iBlockMenu, sizeof ( iBlockMenu ), iLen );
	}
	
	if ( g_iBlockMenu_Pagina [ iIndex ] < g_iBlockMenu_PaginasMax ) {
		add ( iBlockMenu, sizeof ( iBlockMenu ), "^n\y9. \wSiguiente" );
	}
	else
	{
		add ( iBlockMenu, sizeof ( iBlockMenu ), "^n" );
	}
	
	add ( iBlockMenu, sizeof ( iBlockMenu ), "^n\y0 \wAtras" );
	
	show_menu ( iIndex, g_iKeysBloquesSelectionMenu, iBlockMenu, -1, "MenuSeleccionBloques" );
	
	//return PLUGIN_HANDLED;
	
}

public HandlerBloquesSeleccionMenu ( iIndex, iKey ) {
	
	switch ( iKey ) {
		
		case N9: {
			
			g_iBlockMenu_Pagina [ iIndex ]++;
			
			if ( g_iBlockMenu_Pagina [ iIndex ] > g_iBlockMenu_PaginasMax ) 
				g_iBlockMenu_Pagina [ iIndex ] = g_iBlockMenu_PaginasMax;
			
			BloquesSeleccionMenu ( iIndex );
		}
		
		case N0: {
			g_iBlockMenu_Pagina [ iIndex ]--;
			
			if ( g_iBlockMenu_Pagina [ iIndex ] < 1 ) {
				BloquesSeleccionMenu ( iIndex );
				g_iBlockMenu_Pagina [ iIndex ] = 1;
			}
			else {
				BloquesSeleccionMenu ( iIndex );
			}
		}
		
		default: {
			iKey += ( g_iBlockMenu_Pagina [ iIndex ] - 1 ) * 8;
			
			if ( iKey < BLOQUES_TOTALES ) {
				g_iBloqueSelected_Type [ iIndex ] = iKey;
				BloquesMenu ( iIndex );
			}
			else BloquesSeleccionMenu ( iIndex );
		}
	}
	
	//return PLUGIN_HANDLED;
}


public BloquesOpcionesMenu  ( iIndex ) {
	
	if ( ! ( get_user_flags ( iIndex ) & ADMIN_RCON ) ) {
		Henk_SayPrint ( iIndex, "%s No tienes acceso", szPrefix);
		return PLUGIN_HANDLED;
	}
	
	new iMenu [ 256 ];
	new szSnapping [ 17 ];
	
	szSnapping = ( g_iSnapping [ iIndex ] ? "\d[ON]" : "\r[OFF]" );
	
	format ( iMenu, sizeof ( iMenu ), g_iBlockMenu_Opciones, szSnapping, g_iSnapping_gap [ iIndex ] );
	
	show_menu ( iIndex, g_iKeysBloquesOpcionesMenu, iMenu, -1, "MenuOpcionesBloques" );
	
	return PLUGIN_HANDLED;
	
}

public HandlerBloquesOpcionesMenu ( iIndex, iKey ) {
	
	switch ( iKey ) {
		case N1: toggleSnapping ( iIndex );
		case N2: {
			client_cmd ( iIndex, "messagemode BM_INGRESAR_DISTANCIA" );
			Henk_SayPrint ( iIndex, "%s Ingrese la distancia deseada", szPrefix );
		}
		case N3: groupBlockAiming ( iIndex );
		case N4: groupClear ( iIndex );
		case N5: CargarBloques ( iIndex );
		case N6: GuardarBloques ( iIndex );
	}
	
	return PLUGIN_HANDLED;
	
}

public BloquesMenuPropiedades ( iIndex ) {
	
	if ( ! ( get_user_flags ( iIndex ) & ADMIN_RCON ) ) {
		Henk_SayPrint ( iIndex, "%s No tienes acceso", szPrefix);
		return PLUGIN_HANDLED;
	}
	
	//new iEnt = GetAimEntity ( iIndex );
	
	new iEnt = -1;
	new iBody;
	get_user_aiming ( iIndex, iEnt, iBody );
	
	new iClassName [ 64 ];
	pev ( iEnt, pev_classname, iClassName, 63 );
	
	new iBlockType = entity_get_int ( iEnt, EV_INT_body );
	
	
	if ( !iEnt ) {
		Henk_SayPrint ( iIndex, "%s No apuntas a ningún bloque", szPrefix );
	}
	
	new iTitle [ 127 ], iLen [ 256 ];
	formatex ( iTitle, sizeof ( iTitle ), "\y[BREAKING GAMING] \wBlock Maker \d[PROPIEDADES \r^"%s^"\d]", szBloques [ iBlockType ] );
	new iMenu = menu_create ( iTitle, "HandlerBloqueMenuPropiedades" );
	new iPropiedad [ 33 ];
	
	
	if ( strlen ( g_iPropiedad1_Default_Name [ iBlockType ] [ 0 ] ) ) {
		ObtenerPropiedad ( iEnt, 1, iPropiedad );
		format ( iLen, sizeof ( iLen ), "%s: \y%s", g_iPropiedad1_Default_Name [ iBlockType ], iPropiedad );
		menu_additem ( iMenu, iLen, "1" );
	}
	
	if ( strlen ( g_iPropiedad2_Default_Name [ iBlockType ] [ 0 ] ) ) {
		ObtenerPropiedad ( iEnt, 2, iPropiedad );
		format ( iLen, sizeof ( iLen ), "%s: \y%s", g_iPropiedad2_Default_Name [ iBlockType ], iPropiedad );
		menu_additem ( iMenu, iLen, "2" );
	}
	
	if ( strlen ( g_iPropiedad3_Default_Name [ iBlockType ] [ 0 ] ) ) {
		ObtenerPropiedad ( iEnt, 3, iPropiedad );
		format ( iLen, sizeof ( iLen ), "%s: \y%.0f", g_iPropiedad3_Default_Name [ iBlockType ], str_to_float ( iPropiedad ) );
		menu_additem ( iMenu, iLen, "3" );
	}
	
	if ( strlen ( g_iPropiedad4_Default_Name [ iBlockType ] [ 0 ] ) ) {
		ObtenerPropiedad ( iEnt, 4, iPropiedad );
		if ( iBlockType == BUNNYHOP ) format ( iLen, sizeof ( iLen ), "%s: \y%s", g_iPropiedad4_Default_Name [ iBlockType ], iPropiedad );
		else format ( iLen, sizeof ( iLen ), "%s: \y%0.1f", g_iPropiedad4_Default_Name [ iBlockType ], str_to_float ( iPropiedad ) );
		menu_additem ( iMenu, iLen, "4" );
	}
	
	menu_setprop ( iMenu, MPROP_EXITNAME, "Atras" );
	
	g_iBlockSetPropiedad [ iIndex ] [ 1 ] = iEnt;
	
	menu_display ( iIndex, iMenu, 0 );
	
	
	return PLUGIN_HANDLED;
	
}


public HandlerBloqueMenuPropiedades ( iIndex, iMenu, iItem ) {
	
	if ( iItem == MENU_EXIT ) {
		
		menu_destroy ( iMenu );
		cmdBlockMakerMenu ( iIndex );
		return PLUGIN_HANDLED;
	}
	
	new iAccess, iInfo [ 33 ], iName [ 33 ], iCallback;
	
	menu_item_getinfo ( iMenu, iItem, iAccess, iInfo, 32, iName, 32, iCallback );
	
	new iPropiedad = str_to_num ( iInfo );
	
	g_iBlockSetPropiedad [ iIndex ] [ 0 ] = iPropiedad;
	
	Henk_SayPrint ( iIndex, "%s Escribe el valor de la propiedad", szPrefix );
	client_cmd ( iIndex, "messagemode BM_INGRESAR_PROPIEDAD" );
	
	BloquesMenu ( iIndex );
	
	return PLUGIN_HANDLED;
}

public BorrarBloque ( iIndex ) {
	
	new iEnt, iBody;
	get_user_aiming ( iIndex, iEnt, iBody );
	
	if ( is_valid_ent ( iEnt ) ) {
		if ( isBlock ( iEnt ) ) {
			remove_entity ( iEnt );
		}
	}
	return PLUGIN_HANDLED;	
	
}

public RotarBloqueAim ( iIndex ) {
	new iEnt, iBody;
	
	get_user_aiming ( iIndex, iEnt, iBody );
	
	if ( is_valid_ent ( iEnt ) ) {
		
		new iGrab = entity_get_int ( iEnt, EV_INT_iuser2 );
		
		if ( iGrab == 0 || iGrab == iIndex ) {
			
			new iPlayer = entity_get_int ( iEnt, EV_INT_iuser1 );
			
			if ( iPlayer == 0 || iPlayer == iIndex ) {
				
				RotarBloque ( iEnt );
			}
		}
	}
}

public BM_INGRESAR_PROPIEDAD ( iIndex ) {
	
	new iArgv [ 127 ];
	read_argv ( 1, iArgv, sizeof ( iArgv ) );
	
	if ( !strlen ( iArgv ) ) {
		Henk_SayPrint ( iIndex, "%s No puedes poner una propiedad en blanco", szPrefix );
		return PLUGIN_HANDLED;
	}
	
	if ( equali ( iArgv, "si" ) ) {
		iArgv = "Si";
	}
	
	if ( equali ( iArgv, "no" ) ) {
		iArgv = "No";
	}
	
	new iEnt = g_iBlockSetPropiedad [ iIndex ] [ 1 ];
	
	if ( pev_valid ( iEnt ) ) {
		
		new iClassName [ 64 ];
		pev ( iEnt, pev_classname, iClassName, 63 );
		
		new iPropiedad = g_iBlockSetPropiedad [ iIndex ] [ 0 ];
		//Transparencia
		if ( iPropiedad == 3 ) {
			
			SetearPropiedad ( iEnt, iPropiedad, iArgv );
			set_pev ( iEnt, pev_rendermode, kRenderTransTexture );
			set_pev ( iEnt, pev_renderamt, str_to_float ( iArgv ) );
			Henk_SayPrint ( iIndex, "%s Propiedad aceptada", szPrefix );
		}
		
		SetearPropiedad ( iEnt, iPropiedad, iArgv );
		
		//Bloques Normales
		/*
		if ( iPropiedad == 1 && iPropiedad == 2 && iPropiedad == 4 ) {
			SetearPropiedad ( iEnt, iPropiedad, iArgv );
			Henk_SayPrint ( iIndex, "%s Propiedad aceptada", szPrefix );
		}
		*/
	}
	
	return PLUGIN_HANDLED;
}
/*
GetAimOrigin(plr, Float:vOrigin[3])
{
	new Float:vStart[3], Float:vViewOfs[3], Float:vDest[3];
	
	pev(plr, pev_origin, vStart);
	pev(plr, pev_view_ofs, vViewOfs);
	
	vStart[0] += vViewOfs[0];
	vStart[1] += vViewOfs[1];
	vStart[2] += vViewOfs[2];
	
	pev(plr, pev_v_angle, vDest);
	engfunc(EngFunc_MakeVectors, vDest);
	global_get(glb_v_forward, vDest);
	
	vDest[0] *= 9999.0;
	vDest[1] *= 9999.0;
	vDest[2] *= 9999.0;
	
	vDest[0] += vStart[0];
	vDest[1] += vStart[1];
	vDest[2] += vStart[2];
	
	engfunc(EngFunc_TraceLine, vStart, vDest, 0, plr, 0);
	get_tr2(0, TR_vecEndPos, vOrigin);
	
	return 1;
}


GetAimEntity(plr)
{
	new Float:vStart[3], Float:vViewOfs[3], Float:vDest[3];
	
	pev(plr, pev_origin, vStart);
	pev(plr, pev_view_ofs, vViewOfs);
	
	vStart[0] += vViewOfs[0];
	vStart[1] += vViewOfs[1];
	vStart[2] += vViewOfs[2];
	
	pev(plr, pev_v_angle, vDest);
	engfunc(EngFunc_MakeVectors, vDest);
	global_get(glb_v_forward, vDest);
	
	vDest[0] *= 9999.0;
	vDest[1] *= 9999.0;
	vDest[2] *= 9999.0;
	
	vDest[0] += vStart[0];
	vDest[1] += vStart[1];
	vDest[2] += vStart[2];


	engfunc(EngFunc_TraceLine, vStart, vDest, DONT_IGNORE_MONSTERS, plr, 0);
	
	new ent = get_tr2(0, TR_pHit);
	
	if ( !pev_valid(ent) )
	{
		new Float:vOrigin[3];
		GetAimOrigin(plr, vOrigin);
	
		new szClass[6];
		ent = get_maxplayers();
		while ( (ent = engfunc(EngFunc_FindEntityInSphere, ent, vOrigin, 2.0)) )
		{
			pev(ent, pev_classname, szClass, 5);
			if ( equal(szClass, g_iBlockClassName, 0) )
			{	
				return ent;
			}
		}
		
		return 0;
	}

	return ent;
}
*/
ResetPlayers ( iIndex ) {

	if ( is_user_connected ( iIndex ) ) {
		
		g_iAwp [ iIndex ] = false;
		g_iDeagle [ iIndex ] = false;
		g_iM3 [ iIndex ] = false;
		g_iUsp [ iIndex ] = false;
		g_iBichosSnark [ iIndex ] = false;
		g_iScout [ iIndex ] = false;
		
		
		set_user_rendering ( iIndex, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 255 );


		for ( new i = 0; i < BLOQUES_TOTALES; ++i ) {
			g_iBlockExperiencia [ iIndex ] [ i ] = false;
		}

	}

}

public CrearBloqueAim ( iIndex, iBlockType ) {

	static Float:flOrigin [ 3 ];
	
	new iOrigin [ 3 ];
	
	get_user_origin ( iIndex, iOrigin, 3 );
	IVecFVec ( iOrigin, flOrigin );
	flOrigin [ 2 ] += 4.0;
	
	new iName [ 33 ]; get_user_name ( iIndex, iName, 32 );
	
	CrearBloque ( iIndex, iBlockType, flOrigin, Z, g_iBloqueSelected_Size [ iIndex ], g_iPropiedad1_Default_Valor [ iBlockType ], g_iPropiedad2_Default_Valor [ iBlockType ],
	g_iPropiedad3_Default_Valor [ iBlockType ], g_iPropiedad4_Default_Valor [ iBlockType ] );


}

bool:RotarBloque(ent)
{
	if ( !is_valid_ent(ent) ) return false;
	
	static Float:angles[3];
	static Float:size_min[3];
	static Float:size_max[3];
	static Float:temp;
	
	entity_get_vector(ent, EV_VEC_angles, angles);
	entity_get_vector(ent, EV_VEC_mins, size_min);
	entity_get_vector(ent, EV_VEC_maxs, size_max);
	
	if ( angles[0] == 0.0 && angles[2] == 0.0 )
	{
		angles[0] = 90.0;
	}
	else if ( angles[0] == 90.0 && angles[2] == 0.0 )
	{
		angles[0] = 90.0;
		angles[2] = 90.0;
	}
	else
	{
		angles[0] = 0.0;
		angles[1] = 0.0;
		angles[2] = 0.0;
	}
	
	temp = size_min[0];
	size_min[0] = size_min[2];
	size_min[2] = size_min[1];
	size_min[1] = temp;
	
	temp = size_max[0];
	size_max[0] = size_max[2];
	size_max[2] = size_max[1];
	size_max[1] = temp;
	
	entity_set_vector(ent, EV_VEC_angles, angles);
	entity_set_size(ent, size_min, size_max);
	
	return true;
}



CopiarBloque(ent)
{
	if (is_valid_ent(ent))
	{
		new Float:vOrigin[3];
		new Float:vAngles[3];
		new Float:vSizeMin[3];
		new Float:vSizeMax[3];
		new Float:fMax;
		new blockType;
		new size;
		new axis;
		
		blockType = entity_get_int(ent, EV_INT_body);
		entity_get_vector(ent, EV_VEC_origin, vOrigin);
		entity_get_vector(ent, EV_VEC_angles, vAngles);
		entity_get_vector(ent, EV_VEC_mins, vSizeMin);
		entity_get_vector(ent, EV_VEC_maxs, vSizeMax);
		
		size = SMALL;
		fMax = vSizeMax[0] + vSizeMax[1] + vSizeMax[2];
		if (fMax > 64.0) size = NORMAL;
		if (fMax > 128.0) size = LARGE;
		
		for (new i = 0; i < 3; ++i)
		{
			if (vSizeMax[i] == 4.0)
			{
				axis = i;
				break;
			}
		}
		
		static szProp1[32], szProp2[32], szProp3[32], szProp4[32];
		ObtenerPropiedad( ent, 1, szProp1);
		ObtenerPropiedad( ent, 2, szProp2);
		ObtenerPropiedad( ent, 3, szProp3);
		ObtenerPropiedad( ent, 4, szProp4);
		
		
		
		return CrearBloque(0, blockType, vOrigin, axis, size, szProp1, szProp2, szProp3, szProp4 );
	}
	return 0;
}

groupBlockAiming(id)
{
	if (get_user_flags(id) & ADMIN_RCON)
	{
		new ent, body;
		get_user_aiming(id, ent, body);
	
		if (isBlock(ent))
		{
			new player = entity_get_int(ent, EV_INT_iuser1);
	
			if (player == 0)
			{
				g_iGroupCount[id]++;
				
				g_iGroupedBlocks[id][g_iGroupCount[id]] = ent;
				
				groupBlock(id, ent);
					
			}
			else if (player == id)
			{
				BorrarBloqueGrupo(ent);
			}
			else
			{
				new szName[32];
				new player = entity_get_int(ent, EV_INT_iuser1);
				get_user_name(player, szName, 32);
	
				Henk_SayPrint ( id, "%s Este bloque pertenece a %s", szPrefix, szName );


			}
		}
	}
}

groupClear(id)
{
	new blockCount = 0;
	new blocksDeleted = 0;
	new block;
	
	for (new i = 0; i <= g_iGroupCount[id]; ++i)
	{
		block = g_iGroupedBlocks[id][i];
	
		if (isBlockInGroup(id, block))
		{
			if (isBlockStuck(block))
			{
				BorrarBloque(block);
	
				++blocksDeleted;
			}
			else
			{
				BorrarBloqueGrupo(block);
	
				++blockCount;
			}
		}
	}
	
	g_iGroupCount[id] = 0;
	
	if (is_user_connected(id))
	{
		if (blocksDeleted > 0)
		{
			Henk_SayPrint ( id, "%s Quitaste !g%d !ybloques del grupo. Borrados !g%d !ypor bugearse", szPrefix, blockCount, blocksDeleted );
	
		}
		else
		{
			Henk_SayPrint ( id, "%s Quitaste !g%d !ybloques del grupo", szPrefix, blockCount );
	
		}
	}
}


BorrarBloqueGrupo ( iEntity ) {

	if ( !isBlock ( iEntity ) )
		return 0;
	
	entity_set_int ( iEntity, EV_INT_iuser1, 0 );
	
	new iBlockType = entity_get_int ( iEntity, EV_INT_body );
	
	SetBlockRendering ( iEntity, g_iRender [ iBlockType ], g_iRed [ iBlockType ], g_iGreen [ iBlockType ], g_iBlue [ iBlockType ], g_iTransparencia [ iBlockType ] );
	
	return 0;
}


groupBlock ( iIndex, iEnt ) {
		
	if ( !is_valid_ent ( iEnt ) )
		return PLUGIN_HANDLED;
		
		
	if ( 1 <= iIndex <= g_iMaxPlayers ) {
		entity_set_int ( iEnt, EV_INT_iuser1, iIndex );
	}
		
	set_rendering ( iEnt, kRenderFxGlowShell, 255, 0, 0, kRenderNormal, 16 );
		
	return PLUGIN_HANDLED;

}


CrearBloque ( const iIndex, const iBlockType, Float:flOrigin [ 3 ], const iAxis, const iSize, const szProp1 [ ] = "", const szProp2 [ ] = "", const szProp3 [ ] = "", const szProp4 [ ] = "" ) {

	new iEnt = create_entity ( g_iInfoTarget );
	
	
	if ( !is_valid_ent ( iEnt ) )
		return 0;
	
	
	
	
	entity_set_string ( iEnt, EV_SZ_classname, g_iBlockClassName );
	//entity_set_string ( iEnt, EV_SZ_netname, szCreador );
	entity_set_int ( iEnt, EV_INT_solid, SOLID_BBOX );
	entity_set_int ( iEnt, EV_INT_movetype, MOVETYPE_NONE );
	
	new iBlockModelSmall [ 256 ], iBlockModelLarge [ 256 ];
	static Float:vSizeMin [ 3 ], Float:vSizeMax [ 3 ], Float:vAngles [ 3 ], Float:iScale;
	
	
	
	switch ( iAxis ) {
		
		case X: {
		
			vSizeMin [ 0 ] = -4.0;
			vSizeMin [ 1 ] = -32.0;
			vSizeMin [ 2 ] = -32.0;
			
			vSizeMax [ 0 ] = 4.0;
			vSizeMax [ 1 ] = 32.0;
			vSizeMax [ 2 ] = 32.0;
			
			vAngles [ 0 ] = 90.0;
		}
		
		case Y: {
		
			vSizeMin [ 0 ] = -32.0;
			vSizeMin [ 1 ] = -4.0;
			vSizeMin [ 2 ] = -32.0;
		
			vSizeMax [ 0 ] = 32.0;
			vSizeMax [ 1 ] = 4.0;
			vSizeMax [ 2 ] = 32.0;
			
			vAngles [ 0 ] = 90.0; vAngles [ 2 ] = 90.0;
		}
		
		case Z: {
			
			vSizeMin [ 0 ] = -32.0;
			vSizeMin [ 1 ] = -32.0;
			vSizeMin [ 2 ] = -4.0;
			
			vSizeMax [ 0 ] = 32.0;
			vSizeMax [ 1 ] = 32.0;
			vSizeMax [ 2 ] = 4.0;
			
			vAngles [ 0 ] = 0.0; vAngles [ 1 ] = 0.0; vAngles [ 2 ] = 0.0;
		}
	}
	
	
	switch ( iSize ) {
	
		case SMALL: {
	
			formatex ( iBlockModelSmall, sizeof ( iBlockModelSmall ), "%s", szModels [ iBlockType ] );
			replace ( iBlockModelSmall, sizeof ( iBlockModelSmall ), ".mdl", "_small.mdl" );
			iScale = 0.25;
		}
		case LARGE: {
	
			formatex ( iBlockModelLarge, sizeof ( iBlockModelLarge ), "%s", szModels [ iBlockType ] );
			replace ( iBlockModelLarge, sizeof ( iBlockModelLarge ), ".mdl", "_large.mdl" );
			iScale = 2.0;
		}
	
		case NORMAL:{
			iScale = 1.0;
		}
	}
	
	for ( new i = 0; i < 3; i++ ) {
	
		if ( vSizeMin [ i ] != 4.0 && vSizeMin [ i ] != -4.0 )
		vSizeMin [ i ] *= iScale;
	
		if ( vSizeMax [ i ] != 4.0 && vSizeMax [ i ] != -4.0 )
		vSizeMax [ i ] *= iScale;
	}



	if ( iBlockType >= 0 && iBlockType < BLOQUES_TOTALES ) {
	
		switch ( iScale ) {
		/*
		case 0.25: engfunc ( EngFunc_SetModel ,iEnt, iBlockModelSmall );
			case 2.0: engfunc ( EngFunc_SetModel, iEnt, iBlockModelLarge );
				case 1.0: engfunc ( EngFunc_SetModel, iEnt, szModels [ iBlockType ] );
				*/
			
			case 0.25: entity_set_model ( iEnt, iBlockModelSmall );
			case 2.0: entity_set_model ( iEnt, iBlockModelLarge );
			case 1.0: entity_set_model ( iEnt, szModels [ iBlockType ] );
				
		}
	}
	else	return 0;
	
	entity_set_vector ( iEnt, EV_VEC_angles, vAngles );
	entity_set_size ( iEnt, vSizeMin, vSizeMax );
	entity_set_int ( iEnt, EV_INT_body, iBlockType );
	
	SetBlockRendering ( iEnt, g_iRender [ iBlockType ], g_iRed [ iBlockType ], g_iGreen [ iBlockType ], g_iBlue [ iBlockType ], g_iTransparencia [ iBlockType ] );
	set_pev ( iEnt, pev_rendermode, kRenderTransTexture );
	
	
	
	
	if ( equal ( szProp3, "" ) ) {
		SetearPropiedad ( iEnt, 3, g_iPropiedad3_Default_Valor [ iBlockType ] );
		set_pev ( iEnt, pev_renderamt, str_to_float ( g_iPropiedad3_Default_Valor [ iBlockType ] ) );
	}
	else {
		SetearPropiedad ( iEnt, 3, szProp3 );
		set_pev ( iEnt, pev_renderamt, str_to_float ( g_iPropiedad3_Default_Valor [ iBlockType ] ) );
	}
	
	
	
	if ( iIndex > 0 && iIndex <= 32 ) {
		
		doSnapping ( iIndex, iEnt, flOrigin );
	}
	
	
	entity_set_origin ( iEnt, flOrigin );
	
	
	SetearPropiedad ( iEnt, 1, szProp1 );
	SetearPropiedad ( iEnt, 2, szProp2 );
	SetearPropiedad ( iEnt, 3, szProp3 );
	SetearPropiedad ( iEnt, 4, szProp4 );
	
	
	return iEnt;
}


/*
GetCreatorName ( const iEntity, szCreator[ ], iLen = sizeof( szCreator ) ) {
	entity_get_string( iEntity, EV_SZ_netname, szCreator, iLen );
	
	if ( szCreator[ 0 ] == '^0' )
		copy( szCreator, iLen, "Unknown" );
}
*/

changeBlockSize ( iIndex )
{
	switch ( g_iBloqueSelected_Size [ iIndex ] ) {
		case SMALL: g_iBloqueSelected_Size [ iIndex ] = NORMAL;
		case NORMAL: g_iBloqueSelected_Size [iIndex ] = LARGE;
		case LARGE: g_iBloqueSelected_Size [ iIndex ] = SMALL;
	}
}


MoveGrabEntity(id, Float:vMoveTo[3] = {0.0, 0.0, 0.0})
{
	new iOrigin[3], iLook[3];
	new Float:fOrigin[3], Float:fLook[3], Float:fDirection[3], Float:fLength;
	
	get_user_origin(id, iOrigin, 1);
	get_user_origin(id, iLook, 3);	
	IVecFVec(iOrigin, fOrigin);
	IVecFVec(iLook, fLook);

	fDirection[0] = fLook[0] - fOrigin[0];
	fDirection[1] = fLook[1] - fOrigin[1];
	fDirection[2] = fLook[2] - fOrigin[2];
	fLength = get_distance_f(fLook, fOrigin);

	if (fLength == 0.0) fLength = 1.0;	
	
	vMoveTo[0] = (fOrigin[0] + fDirection[0] * g_iGrab_Length[id] / fLength) + g_iGrab_Offset[id][0];
	vMoveTo[1] = (fOrigin[1] + fDirection[1] * g_iGrab_Length[id] / fLength) + g_iGrab_Offset[id][1];
	vMoveTo[2] = (fOrigin[2] + fDirection[2] * g_iGrab_Length[id] / fLength) + g_iGrab_Offset[id][2];
	vMoveTo[2] = float(floatround(vMoveTo[2], floatround_floor));

	MoverEntidad(id, g_iGrab[id], vMoveTo, true);
}

MoverEntidad(id, ent, Float:vMoveTo[3], bool:bDoSnapping)
{
	if (isBlock(ent))
	{
		if (bDoSnapping)
		{
			doSnapping(id, ent, vMoveTo);
		}
	
		entity_set_origin(ent, vMoveTo);
		
		new sprite = entity_get_int(ent, EV_INT_iuser3);
	
		if (sprite)
		{
			new Float:vSizeMax[3];
			entity_get_vector(ent, EV_VEC_maxs, vSizeMax);
		
			vMoveTo[2] += vSizeMax[2] + 0.15;
			entity_set_origin(sprite, vMoveTo);
		}
	}
	else
	{
		entity_set_origin(ent, vMoveTo);
	}
}

public DistanciaSnapping( id )
{
	new szArgs[33], Float:FloatCant[33];
	read_args( szArgs, 32 );
	trim( szArgs ); remove_quotes( szArgs );
	
	if( !strlen( szArgs ) || szArgs[5] )
		g_iSnapping_gap[id] = 0.0;
	else
	{
		FloatCant[id] = str_to_float( szArgs );
		
		if( FloatCant[ id ] > 300.0 )
			g_iSnapping_gap[ id ] = 0.0, Henk_SayPrint ( id, "%s La distancia máxima es de !g259.0", szPrefix );//ColorChat( id, GREEN, "%s^1 La distancia maxima para ingresar es^4 259.0", szPrefix );
			else
			{
				Henk_SayPrint ( id, "%s Distancia aceptada, valor: !g%0.1f", szPrefix, FloatCant [ id ] );
				//ColorChat( id, GREEN, "[%s]^1 Distancia aceptada, valor ingresado:^4 %0.1f", szPrefix, FloatCant[id]  );
				g_iSnapping_gap[id] = FloatCant[id] ;
				BloquesOpcionesMenu(id);
			}
	}
}


toggleSnapping ( iIndex ) {
	if ( get_user_flags ( iIndex ) & ADMIN_RCON )
		g_iSnapping [ iIndex ] = ! g_iSnapping [ iIndex ];
}

doSnapping(id, ent, Float:fMoveTo[3])
{
	if (g_iSnapping[id])
	{
		new Float:fSnapSize = g_snap_distance + g_iSnapping_gap[id];
		new Float:vReturn[3];
		new Float:dist;
		new Float:distOld = 9999.9;
		new Float:vTraceStart[3];
		new Float:vTraceEnd[3];
		new tr;
		new trClosest = 0;
		new blockFace;
		
		new Float:fSizeMin[3];
		new Float:fSizeMax[3];
		entity_get_vector(ent, EV_VEC_mins, fSizeMin);
		entity_get_vector(ent, EV_VEC_maxs, fSizeMax);
	
		for (new i = 0; i < 6; ++i)
		{
			vTraceStart = fMoveTo;
		
			switch (i)
			{
				case 0: vTraceStart[0] += fSizeMin[0];
				case 1: vTraceStart[0] += fSizeMax[0];		
				case 2: vTraceStart[1] += fSizeMin[1];		
				case 3: vTraceStart[1] += fSizeMax[1];
				case 4: vTraceStart[2] += fSizeMin[2];		
				case 5: vTraceStart[2] += fSizeMax[2];		
			}
			
			vTraceEnd = vTraceStart;
			
			switch (i)
			{
				case 0: vTraceEnd[0] -= fSnapSize;
				case 1: vTraceEnd[0] += fSnapSize;
				case 2: vTraceEnd[1] -= fSnapSize;
				case 3: vTraceEnd[1] += fSnapSize;
				case 4: vTraceEnd[2] -= fSnapSize;
				case 5: vTraceEnd[2] += fSnapSize;
			}
			
			tr = trace_line(ent, vTraceStart, vTraceEnd, vReturn);
			
			if (isBlock(tr) && (!isBlockInGroup(id, tr) || !isBlockInGroup(id, ent)))
			{
				dist = get_distance_f(vTraceStart, vReturn);
				
				if (dist < distOld)
				{
					trClosest = tr;
					distOld = dist;
					
					blockFace = i;
				}
			}
		}
		
		if (is_valid_ent(trClosest))
		{
			new Float:vOrigin[3];
			entity_get_vector(trClosest, EV_VEC_origin, vOrigin);
			
			new Float:fTrSizeMin[3];
			new Float:fTrSizeMax[3];
			entity_get_vector(trClosest, EV_VEC_mins, fTrSizeMin);
			entity_get_vector(trClosest, EV_VEC_maxs, fTrSizeMax);
			
			fMoveTo = vOrigin;
			
			if (blockFace == 0) fMoveTo[0] += (fTrSizeMax[0] + fSizeMax[0]) + g_iSnapping_gap[id];
			if (blockFace == 1) fMoveTo[0] += (fTrSizeMin[0] + fSizeMin[0]) - g_iSnapping_gap[id];
			if (blockFace == 2) fMoveTo[1] += (fTrSizeMax[1] + fSizeMax[1]) + g_iSnapping_gap[id];
			if (blockFace == 3) fMoveTo[1] += (fTrSizeMin[1] + fSizeMin[1]) - g_iSnapping_gap[id];
			if (blockFace == 4) fMoveTo[2] += (fTrSizeMax[2] + fSizeMax[2]) + g_iSnapping_gap[id];
			if (blockFace == 5) fMoveTo[2] += (fTrSizeMin[2] + fSizeMin[2]) - g_iSnapping_gap[id];
		}
	}
}

public AddComas( Num )
{
	new szNum[15];
	num_to_str( Num, szNum, 14 );
	
	
	if( strlen(szNum[ 6 ] ) && !strlen(szNum[ 7 ] ) )
	{
		szNum[ 10 ] = szNum[ 9 ];
		szNum[ 9 ] = szNum[ 8 ];
		szNum[ 8 ] = szNum[ 7 ];
		szNum[ 7 ] = szNum[ 6 ];
		szNum[ 6 ] = szNum[ 5 ];		
		szNum[ 5 ] = szNum[ 4 ];
		szNum[ 4 ] = szNum[ 3];
		szNum[ 3 ] = szNum[ 2 ];
		szNum[ 2 ] = szNum[ 1 ];
		szNum[ 5 ] = '.';
		szNum[ 1 ] = '.';
	}
	else if( strlen(szNum[ 5 ] ))
	{
		szNum[ 6 ] = szNum[ 5 ];
		szNum[ 5 ] = szNum[ 4 ];
		szNum[ 4 ] = szNum[ 3 ];
		szNum[ 3 ] = '.';
	}
	else if( strlen(szNum[ 4 ] ))
	{
		szNum[ 5 ] = szNum[ 4 ];
		szNum[ 4 ] = szNum[ 3 ];
		szNum[ 3 ] = szNum[ 2 ];
		szNum[ 2 ] = '.';
	}
	else if( strlen(szNum[ 3 ] ))
	{
		szNum[ 4 ] = szNum[ 3];
		szNum[ 3 ] = szNum[ 2 ];
		szNum[ 2 ] = szNum[ 1 ];
		szNum[ 1 ] = '.';
	}	
	
	return szNum;
}

SetBlockRendering ( iEnt, iType, iRed, iGreen, iBlue, iTransparencia ) {
	
	if ( isBlock ( iEnt ) ) {
		
		switch ( iType ) {
			
			case TRANSCOLOR: set_rendering ( iEnt, kRenderFxGlowShell, iRed, iGreen, iBlue, kRenderTransColor, iTransparencia );
			case TRANSALPHA: set_rendering ( iEnt, kRenderFxNone, iRed, iGreen, iBlue, kRenderTransColor, iTransparencia );
			case TRANSWHITE: set_rendering ( iEnt, kRenderFxNoDissipation, iRed, iGreen, iBlue, kRenderTransAdd, iTransparencia );
			case GLOWSHELL: set_rendering ( iEnt, kRenderFxGlowShell, iRed, iGreen, iBlue, kRenderNormal, iTransparencia );
			default: set_rendering ( iEnt, kRenderFxNone, iRed, iGreen, iBlue, kRenderNormal, iTransparencia );
		}
	}
}


bool:isBlock ( iEntity ) {
	
	if ( is_valid_ent ( iEntity ) ) {
		
		
		new iClassName [ 64 ];
		entity_get_string ( iEntity, EV_SZ_classname, iClassName, 63 );
		
		if ( equal ( iClassName, g_iBlockClassName ) )
			return true;
	}
	
	return false;
}


bool:isBlockInGroup ( iIndex, iEntity ) {
	
	if ( is_valid_ent ( iEntity ) ) {
		
		if ( entity_get_int ( iEntity, EV_INT_iuser1 ) == iIndex )
			return true;
	}
	
	return false;
}

bool:isBlockStuck(ent)
{
	if (is_valid_ent(ent))
	{
		new content;
		new Float:vOrigin[3];
		new Float:vPoint[3];
		new Float:fSizeMin[3];
		new Float:fSizeMax[3];
		
		entity_get_vector(ent, EV_VEC_mins, fSizeMin);
		entity_get_vector(ent, EV_VEC_maxs, fSizeMax);
		
		entity_get_vector(ent, EV_VEC_origin, vOrigin);
		
		fSizeMin[0] += 1.0;
		fSizeMax[0] -= 1.0;
		fSizeMin[1] += 1.0;
		fSizeMax[1] -= 1.0; 
		fSizeMin[2] += 1.0;
		fSizeMax[2] -= 1.0;
	
		for (new i = 0; i < 14; ++i)
		{
			vPoint = vOrigin;
		
			switch (i)
			{
				case 0: { vPoint[0] += fSizeMax[0]; vPoint[1] += fSizeMax[1]; vPoint[2] += fSizeMax[2]; }
				case 1: { vPoint[0] += fSizeMin[0]; vPoint[1] += fSizeMax[1]; vPoint[2] += fSizeMax[2]; }
				case 2: { vPoint[0] += fSizeMax[0]; vPoint[1] += fSizeMin[1]; vPoint[2] += fSizeMax[2]; }
				case 3: { vPoint[0] += fSizeMin[0]; vPoint[1] += fSizeMin[1]; vPoint[2] += fSizeMax[2]; }
				case 4: { vPoint[0] += fSizeMax[0]; vPoint[1] += fSizeMax[1]; vPoint[2] += fSizeMin[2]; }
				case 5: { vPoint[0] += fSizeMin[0]; vPoint[1] += fSizeMax[1]; vPoint[2] += fSizeMin[2]; }
				case 6: { vPoint[0] += fSizeMax[0]; vPoint[1] += fSizeMin[1]; vPoint[2] += fSizeMin[2]; }
				case 7: { vPoint[0] += fSizeMin[0]; vPoint[1] += fSizeMin[1]; vPoint[2] += fSizeMin[2]; }
				
				case 8: { vPoint[0] += fSizeMax[0]; }
				case 9: { vPoint[0] += fSizeMin[0]; }
				case 10: { vPoint[1] += fSizeMax[1]; }
				case 11: { vPoint[1] += fSizeMin[1]; }
				case 12: { vPoint[2] += fSizeMax[2]; }
				case 13: { vPoint[2] += fSizeMin[2]; }
			}
			
			content = point_contents(vPoint);
		
			if (content == CONTENTS_EMPTY || content == 0)
			{
				return false;
			}
		}
	}
	else
	{
		return false;
	}

	return true;
}

SetearPropiedad ( iEnt, iProperty, const szProperty [ ] ) {

	switch ( iProperty ) {
		case 1: set_pev ( iEnt, pev_message, szProperty, 32 );
		case 2: set_pev ( iEnt, pev_netname, szProperty, 32 );
		case 3: set_pev ( iEnt, pev_viewmodel2, szProperty, 32 );
		case 4: set_pev ( iEnt, pev_weaponmodel2, szProperty, 32 );
	}
	
	return 1;
}

ObtenerPropiedad ( iEnt, iProperty, const szProperty [ ] ) {
	
	switch ( iProperty ) {
		case 1: pev ( iEnt, pev_message, szProperty, 32 );
			case 2: pev ( iEnt, pev_netname, szProperty, 32 );
			case 3: pev ( iEnt, pev_viewmodel2, szProperty, 32 );
			case 4: pev ( iEnt, pev_weaponmodel2, szProperty, 32 );
		}
	
	return 1;
}


CargarBloques ( iIndex ) {
	
	if ( get_user_flags ( iIndex ) & ADMIN_RCON ) {
		
		if ( file_exists ( g_iNewFile ) ) {
			
			if ( iIndex > 0 && iIndex <= 32 ) {
				//DeleteTeleport ( );
			}
			
			new iData [ 127 ], iType [ 2 ];
			new Float:vVec1 [ 3 ], Float:vVec2 [ 3 ];
			new iAxis, iSize;
			
			new iFile = fopen ( g_iNewFile, "rt" );
			new sz1[16], sz2[16], sz3[16], sz4[16], sz5[16], sz6[16], sz7[16];
			new szProp1 [ 33 ] ,szProp2 [ 33 ], szProp3 [ 33 ], szProp4 [ 33 ];
			new iBlockCount;
			
			while ( !feof ( iFile ) ) {
				iType = "";
				fgets ( iFile, iData, 127 );
				
				parse ( iData, iType, sizeof ( iType ), sz1, sizeof ( sz1 ), sz2, sizeof ( sz2 ), sz3, sizeof ( sz3 ), sz4, sizeof ( sz4 ), sz5, sizeof ( sz5 ), sz6, sizeof ( sz6 ), sz7, sizeof ( sz7 ),szProp1, sizeof ( szProp1 ), szProp2, sizeof ( szProp2 ), szProp3, sizeof ( szProp3 ), szProp4, sizeof ( szProp4 ) );
				//parse ( iData, iType, 1, sz1, 16, sz2, 16, sz3, 16, sz4, 16, sz5, 16, sz6, 16, sz7, 16, szProp1, 31, szProp2, 31, szProp3, 31, szProp4, 31 );
				
				vVec1 [ 0 ] = str_to_float ( sz1 );
				vVec1 [ 1 ] = str_to_float ( sz2 );
				vVec1 [ 2 ] = str_to_float ( sz3 );
				
				vVec2 [ 0 ] = str_to_float ( sz4 );
				vVec2 [ 1 ] = str_to_float ( sz5 );
				vVec2 [ 2 ] = str_to_float ( sz6 );
				
				iSize = str_to_num ( sz7 );
				
				if ( strlen ( iType ) > 0 ) {
					
					iBlockCount++;
					
					switch ( iType [ 0 ] ) {
						case 'a': CrearBloque ( 0, PLATAFORMA,  	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'b': CrearBloque ( 0, BUNNYHOP,	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'c': CrearBloque ( 0, MUERTE,	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'd': CrearBloque ( 0, DANIO,	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'e': CrearBloque ( 0, NO_DANIO,	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'f': CrearBloque ( 0, VIDA,		vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'g': CrearBloque ( 0, HIELO,	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'h': CrearBloque ( 0, TRAMPOLIN,	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'i': CrearBloque ( 0, VIDRIO,	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'j': CrearBloque ( 0, GRAVEDAD,	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'k': CrearBloque ( 0, AWP,		vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'l': CrearBloque ( 0, DEAGLE,	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'm': CrearBloque ( 0, BICHOS_SNARK,	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'n': CrearBloque ( 0, USP,		vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'o': CrearBloque ( 0, M3,		vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							case 'p': CrearBloque ( 0, SCOUT,	vVec1, iAxis, iSize, szProp1, szProp2, szProp3, szProp4 );
							
					}
				}
				
			}
			fclose ( iFile );
			
			
			if ( iIndex > 0 && iIndex <= 32 ) {
				new iName [ 33 ]; get_user_name ( iIndex, iName, 32 );
				
				for ( new i = 1; i <= 32; i++ ) {
					if ( !is_user_connected ( i ) )
						continue;
					
					
					if ( get_user_flags ( i ) & ADMIN_RCON ) {
						Henk_SayPrint ( i, "%s Se han cargado los bloques !g[%d]", szPrefix, iBlockCount );
					}
				}
			}
		}
		else {
			if ( iIndex > 0 && iIndex <= 32 ) {
				Henk_SayPrint ( iIndex, "%s No se ha encontrado el archivo !g%s", szPrefix, g_iNewFile );
			}
		}
	}
	
	
}

GuardarBloques ( iIndex ) {
	
	if ( ! ( get_user_flags ( iIndex ) & ADMIN_RCON ) ) {
		Henk_SayPrint ( iIndex, "%s No tienes acceso", szPrefix );
		return PLUGIN_HANDLED;
	}
	
	new iFile = fopen ( g_iNewFile, "wt" );
	
	//if ( !iFile ) return PLUGIN_HANDLED;
	
	new iEnt = -1;
	new iBlockCount = 0;
	static Float:vOrigin [ 3 ];
	static Float:vAngles [ 3 ];
	static Float:vStart [ 3 ];
	static Float:vEnd [ 3 ];
	static Float:vSizeMax [ 3 ];
	static Float:flMax;
	
	new szBuffer [ 256 ];
	new iSize;
	new szProp1 [ 33 ], szProp2 [ 33 ], szProp3 [ 33 ], szProp4 [ 33 ];
	
	new iBlockType;
	
	while ( ( iEnt = find_ent_by_class ( iEnt, g_iBlockClassName ) ) ) {
		
		ObtenerPropiedad ( iEnt, 1, szProp1 );
		ObtenerPropiedad ( iEnt, 2, szProp2 );
		ObtenerPropiedad ( iEnt, 3, szProp3 );
		ObtenerPropiedad ( iEnt, 4, szProp4 );
		
		iBlockType = entity_get_int ( iEnt, EV_INT_body );
		entity_get_vector ( iEnt, EV_VEC_origin, vOrigin );
		entity_get_vector ( iEnt, EV_VEC_angles, vAngles );
		entity_get_vector ( iEnt, EV_VEC_maxs, vSizeMax );
		
		iSize = SMALL;
		
		flMax = vSizeMax [ 0 ] + vSizeMax [ 1 ] + vSizeMax [ 2 ];
		
		if ( flMax > 64.0 ) iSize = NORMAL;
		if ( flMax > 128.0 ) iSize = LARGE;
		
		formatex ( szBuffer, sizeof ( szBuffer ), "%c %f %f %f %f %f %f %d ^"%s^" ^"%s^" ^"%s^" ^"%s^"^n",
		g_iBloques_SaveID [ iBlockType ], vOrigin [ 0 ], vOrigin [ 1 ], vOrigin [ 2 ],
		vAngles [ 0 ], vAngles [ 1 ], vAngles [ 2 ],
		iSize,
		szProp1, szProp2, szProp3, szProp4 );
		
		
		fputs ( iFile, szBuffer );
		
		iBlockCount++;
	}
	
	
	
	for ( new i = 1; i <= g_iMaxPlayers; i++ ) {
		
		if ( !is_user_connected ( i ) )
			continue;
		
		Henk_SayPrint ( i, "%s Se han guardado !g%d bloques", szPrefix, iBlockCount );
	}
	
	return PLUGIN_HANDLED;
	
}


