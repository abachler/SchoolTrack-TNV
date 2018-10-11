
If ([xxBBL_ReglasParaUsuarios:64]Default:12)
	If (<>sMT_DefaultUserRule#[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
		
		LOG_RegisterEvt ("Cambio en regla por defecto para lectores. Cambió de "+ST_Qte (<>sMT_DefaultUserRule)+" a "+ST_Qte ([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)+".")
		
		<>sMT_DefaultUserRule:=[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1
		$rec:=Record number:C243([xxBBL_ReglasParaUsuarios:64])
		SAVE RECORD:C53([xxBBL_ReglasParaUsuarios:64])
		READ WRITE:C146([xxBBL_ReglasParaUsuarios:64])
		QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1#<>sMT_DefaultUserRule)
		APPLY TO SELECTION:C70([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Default:12:=False:C215)
		
		  //20120225 RCH para cargar la posible nueva regla en todas partes...
		KRL_ExecuteEverywhere ("BBL_LeeReglasPorDefecto")
		
		READ WRITE:C146([xxBBL_ReglasParaUsuarios:64])
		GOTO RECORD:C242([xxBBL_ReglasParaUsuarios:64];$rec)
		
	End if 
Else 
	LOG_RegisterEvt ("Cambio en regla por defecto para lectores. Cambió de "+ST_Qte (<>sMT_DefaultUserRule)+" a "+ST_Qte ("")+".")
	<>sMT_DefaultUserRule:=""
End if 