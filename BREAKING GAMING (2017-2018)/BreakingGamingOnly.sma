#include < amxmodx >
#include < amxmisc >
#include < cstrike >
#include < HenkStocks >


const iDinero = 9999999;

new g_MaxPlayers;


#pragma compress 1
new const no_amxx_uncompress [ ] = "no_amxx_uncompress";

public plugin_init ( ) {
	
	Henk_RegisterPlugin ( "Only Largo", "1.0", "heNK'", "BG" );
	
	register_event ( "Money", "EventMoney", "ab" );
	register_message ( get_user_msgid ( "Money" ), "MessageMoney" );
	
	g_MaxPlayers = get_maxplayers ( );
}

public plugin_cfg ( ) {
	Henk_PausePlugin ( "[BG] - Only Largo" );
	
}


public client_putinserver ( iIndex ) {
	
	set_task ( 7.0, "Bienvenida", iIndex );
	
}

public Bienvenida ( iIndex ) {
	
	if ( !is_user_connected ( iIndex ) )
		return;
		
		
	
	new name [ 33 ]; get_user_name ( iIndex, name, 32 );
	set_hudmessage ( 195, 195, 195, -1.0, -1.0, 0, 6.0, 8.0 );
	show_hudmessage ( iIndex, "Bienvenido %s^nEstas jugando en BREAKING GAMING", name );
	
	
	
}

public EventMoney ( ) {
	
	for ( new iIndex = 1; iIndex <= g_MaxPlayers; iIndex++ ) {
		
		if ( !is_user_bot ( iIndex ) ) {
			
			cs_set_user_money ( iIndex, iDinero, 0 );
			return PLUGIN_HANDLED;
			
		}
		
	}
	return PLUGIN_HANDLED;
}

public MessageMoney ( iMsgID, iMsgDest, iIndex ) {
	
	if ( !is_user_bot ( iIndex ) ) {
		cs_set_user_money ( iIndex, iDinero, 0 );
	}
	
	
}
