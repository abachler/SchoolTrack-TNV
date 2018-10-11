
Case of 
	: (Form event:C388=On Load:K2:1)
		
		C_LONGINT:C283($i;$fia)
		ARRAY TEXT:C222(at_aTxtPriv;0)
		
		ARRAY TEXT:C222(at_modulos;0)
		ARRAY TEXT:C222(at_metodos;0)
		ARRAY LONGINT:C221(al_metodosM;0)
		ARRAY LONGINT:C221(al_metodosT;0)
		ARRAY LONGINT:C221(al_metodosTM;0)
		
		ARRAY PICTURE:C279(ap_modulosPer;0)
		ARRAY PICTURE:C279(ap_metodosPer;0)
		ARRAY PICTURE:C279(ap_aPictPriv;0)
		
		COPY ARRAY:C226(<>aPictPriv;ap_aPictPriv)
		COPY ARRAY:C226(<>aTxtPriv;at_aTxtPriv)
		
		For ($i;1;Count list items:C380(hl_AuthModules))
			GET LIST ITEM:C378(hl_AuthModules;$i;$ref;$text)
			APPEND TO ARRAY:C911(at_modulos;$text)
		End for 
		
		C_PICTURE:C286($pict1;$pict2)
		
		GET PICTURE FROM LIBRARY:C565(2077;$pict1)
		GET PICTURE FROM LIBRARY:C565(2078;$pict2)
		
		For ($i;1;Size of array:C274(at_modulos))
			$fia:=Find in array:C230(<>atusr_authModules;at_modulos{$i})
			If ($fia=-1)
				APPEND TO ARRAY:C911(ap_modulosPer;$pict1)
			Else 
				APPEND TO ARRAY:C911(ap_modulosPer;$pict2)
			End if 
		End for 
		
		  // MOD Ticket N° 216261 Patricio Aliaga 20180920
		CREATE EMPTY SET:C140([xShell_ExecutableCommands:19];"$commands")
		For ($i;1;Size of array:C274(<>atusr_authModules))
			QUERY:C277([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Method_ID:8#0;*)
			QUERY:C277([xShell_ExecutableCommands:19]; & ;[xShell_ExecutableCommands:19]PermissionRequired:6;=;True:C214;*)
			QUERY:C277([xShell_ExecutableCommands:19]; & ;[xShell_ExecutableCommands:19]Module:3;=;<>atusr_authModules{$i})
			CREATE SET:C116([xShell_ExecutableCommands:19];"$temp")
			UNION:C120("$commands";"$temp";"$commands")
			CLEAR SET:C117("$temp")
		End for 
		
		QUERY:C277([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Method_ID:8#0;*)
		QUERY:C277([xShell_ExecutableCommands:19]; & ;[xShell_ExecutableCommands:19]PermissionRequired:6;=;True:C214;*)
		QUERY:C277([xShell_ExecutableCommands:19]; & ;[xShell_ExecutableCommands:19]Module:3;=;"Todos los Módulos")
		CREATE SET:C116([xShell_ExecutableCommands:19];"$temp")
		UNION:C120("$commands";"$temp";"$commands")
		CLEAR SET:C117("$temp")
		
		QUERY:C277([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Method_ID:8#0;*)
		QUERY:C277([xShell_ExecutableCommands:19]; & ;[xShell_ExecutableCommands:19]PermissionRequired:6;=;True:C214;*)
		QUERY:C277([xShell_ExecutableCommands:19]; & ;[xShell_ExecutableCommands:19]Module:3;=;"All Modules")
		CREATE SET:C116([xShell_ExecutableCommands:19];"$temp")
		UNION:C120("$commands";"$temp";"$commands")
		CLEAR SET:C117("$temp")
		
		USE SET:C118("$commands")
		CLEAR SET:C117("$commands")
		ORDER BY FORMULA:C300([xShell_ExecutableCommands:19];ST_GetWord (XS_GetCommandAliasDescription (Record number:C243([xShell_ExecutableCommands:19]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t");>)
		SELECTION TO ARRAY:C260([xShell_ExecutableCommands:19];al_metodosTM)
		
		  //QUERY([xShell_ExecutableCommands];[xShell_ExecutableCommands]Method_ID#0;*)
		  //QUERY([xShell_ExecutableCommands]; & ;[xShell_ExecutableCommands]PermissionRequired;=;True;*)
		  //QUERY([xShell_ExecutableCommands];[xShell_ExecutableCommands]Module;=;"";*)
		  //QUERY([xShell_ExecutableCommands]; | ;[xShell_ExecutableCommands]Module;=;"Todos los Módulos";*)
		  //QUERY([xShell_ExecutableCommands]; | ;[xShell_ExecutableCommands]Module="All Modules")
		  //ORDER BY FORMULA([xShell_ExecutableCommands];ST_GetWord (XS_GetCommandAliasDescription (Record number([xShell_ExecutableCommands]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t");>)
		  //LONGINT ARRAY FROM SELECTION([xShell_ExecutableCommands];al_metodosT;"")
		  //QUERY([xShell_ExecutableCommands];[xShell_ExecutableCommands]Method_ID#0;*)
		  //QUERY([xShell_ExecutableCommands]; & ;[xShell_ExecutableCommands]PermissionRequired;=;True;*)
		  //QUERY([xShell_ExecutableCommands]; & ;[xShell_ExecutableCommands]Module#"";*)
		  //QUERY([xShell_ExecutableCommands]; & ;[xShell_ExecutableCommands]CommandAlias#"")
		  //ORDER BY FORMULA([xShell_ExecutableCommands];ST_GetWord (XS_GetCommandAliasDescription (Record number([xShell_ExecutableCommands]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t");>)
		  //LONGINT ARRAY FROM SELECTION([xShell_ExecutableCommands];al_metodosM;"")
		  //AT_Union (->al_metodosT;->al_metodosM;->al_metodosTM)
		
		For ($i;1;Size of array:C274(al_metodosTM))
			GOTO RECORD:C242([xShell_ExecutableCommands:19];al_metodosTM{$i})
			APPEND TO ARRAY:C911(at_metodos;ST_GetWord (XS_GetCommandAliasDescription (Record number:C243([xShell_ExecutableCommands:19]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t"))
		End for 
		
		For ($i;1;Size of array:C274(at_metodos))
			$fia:=Find in array:C230(<>aAuthMethodsAlias;at_metodos{$i})
			If ($fia=-1)
				APPEND TO ARRAY:C911(ap_metodosPer;$pict1)
			Else 
				APPEND TO ARRAY:C911(ap_metodosPer;$pict2)
			End if 
		End for 
		
		
		If ((Size of array:C274(ap_aPictPriv))>(Size of array:C274(at_metodos)))
			AT_RedimArrays ((Size of array:C274(ap_aPictPriv));->at_modulos;->ap_modulosPer;->ap_metodosPer;->at_metodos)
		Else 
			AT_RedimArrays ((Size of array:C274(at_metodos));->at_modulos;->ap_modulosPer;->ap_aPictPriv;->at_aTxtPriv)
		End if 
		
		
		$err:=PL_SetArraysNam (xPL1;1;1;"<>amembers")
		
		PL_SetHeaders (xPL1;1;1;"Miembros del Grupo")
		PL_SetWidths (xPL1;1;100)
		PL_SetHdrOpts (xPL1;1)
		
		PL_SetHeight (xPL1;1;1;0;0)
		PL_SetHdrStyle (xPL1;0;"Tahoma";8;1)
		PL_SetStyle (xPL1;0;"Tahoma";8;0)
		PL_SetDividers (xPL1;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetFrame (xPL1;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetBrkRowDiv (xPL1;0.25;"Black";"Black";0)
		PL_SetBrkHeight (xPL1;0;1;2)
		PL_SetBrkColOpt (xPL1;0;0;0;1;"Black";"Black";0)
		PL_SetBrkStyle (xPL1;0;0;"Tahoma";8;1)
		
		
		$err:=PL_SetArraysNam (xPL;1;6;"ap_aPictPriv";"at_aTxtPriv";"ap_modulosper";"at_modulos";"ap_metodosPer";"at_metodos")
		
		PL_SetHeaders (xPL;1;6;"Acceso de Datos";" ";" ";"Módulos";" ";"Permisos")
		PL_SetWidths (xPL;1;6;75;170;20;90;20;100)
		PL_SetHdrOpts (xPL;6)
		
		PL_SetHeight (xPL;1;1;0;0)
		PL_SetHdrStyle (xPL;0;"Tahoma";8;1)
		PL_SetStyle (xPL;0;"Tahoma";8;0)
		PL_SetDividers (xPL;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetFrame (xPL;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetBrkRowDiv (xPL;0.25;"Black";"Black";0)
		PL_SetBrkHeight (xPL;0;1;2)
		PL_SetBrkColOpt (xPL;0;0;0;1;"Black";"Black";0)
		PL_SetBrkStyle (xPL;0;0;"Tahoma";8;1)
		
End case 


