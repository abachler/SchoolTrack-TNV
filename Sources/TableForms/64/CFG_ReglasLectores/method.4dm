  // [xxBBL_ReglasParaUsuarios].CFG_ReglasLectores()
  // Por: Alberto Bachler K.: 12-05-15, 13:07:47
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Load:K2:1)
		
		XS_SetConfigInterface 
		
		If (Size of array:C274(<>aPrefUsr)=0)
			CREATE RECORD:C68([xxBBL_ReglasParaUsuarios:64])
			[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1:=__ ("GEN")
			[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2:=__ ("Genérica")
			[xxBBL_ReglasParaUsuarios:64]Default:12:=True:C214
			SAVE RECORD:C53([xxBBL_ReglasParaUsuarios:64])
			APPEND TO ARRAY:C911(<>aPrefUsr;[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
			APPEND TO ARRAY:C911(<>aPrefUsrName;[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2)
		End if 
		
		
		QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Default:12=True:C214)
		If (Records in selection:C76([xxBBL_ReglasParaUsuarios:64])>0)
			$l_posicion:=Find in array:C230(<>aPrefUsr;[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
		Else 
			$l_posicion:=1
			QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1=<>aPrefUsr{$l_posicion})
		End if 
		<>aPrefUsr:=$l_posicion
		<>aPrefUsrName:=$l_posicion
		lb_reglas{$l_posicion}:=True:C214
		
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		SET QUERY LIMIT:C395(1)
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Regla:4=[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
		SET QUERY LIMIT:C395(0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		OBJECT SET ENABLED:C1123(*;"eliminaRegla";($l_registros=0) & Not:C34([xxBBL_ReglasParaUsuarios:64]Default:12))
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		SET QUERY LIMIT:C395(1)
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Regla:4=[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
		SET QUERY LIMIT:C395(0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		OBJECT SET ENABLED:C1123(*;"eliminaRegla";($l_registros=0) & Not:C34([xxBBL_ReglasParaUsuarios:64]Default:12))
		
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
		
	: (Form event:C388=On Unload:K2:2)
		SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
		UNLOAD RECORD:C212([xxBBL_ReglasParaItems:69])
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

