Case of 
	: (Form event:C388=On Load:K2:1)
		
		  //Matrices
		ARRAY TEXT:C222(atACT_NombreMatriz;0)
		ARRAY LONGINT:C221(alACT_IdMatriz;0)
		
		ACTcfg_LoadMatrix 
		AT_Insert (1;1;->atACT_NombreMatriz;->alACT_IdMatriz)
		atACT_NombreMatriz{1}:="Ninguna"
		alACT_IdMatriz{1}:=-1
		
		  //Consultas
		ARRAY TEXT:C222(atACT_aQueryArray;0)
		ARRAY LONGINT:C221(alACT_aQueryArray;0)
		C_TEXT:C284($searchF)
		C_POINTER:C301($y_filePointer)
		$y_filePointer:=->[ACT_CuentasCorrientes:175]
		$searchF:=String:C10(Table:C252($y_filePointer);"000")+"/"+<>tUSR_CurrentUser
		QUERY:C277([xShell_Queries:53];[xShell_Queries:53]InMenu:7=$searchF;*)
		QUERY:C277([xShell_Queries:53]; | [xShell_Queries:53]InMenu:7=String:C10(Table:C252($y_filePointer);"000"))
		SELECTION TO ARRAY:C260([xShell_Queries:53]No:1;alACT_aQueryArray;[xShell_Queries:53]Name:2;atACT_aQueryArray)
		
		If (Is new record:C668([ACT_MatricesAsignacionAut:289]))
			C_TEXT:C284($t_nombreRegla)
			C_LONGINT:C283($l_nombreRegla)
			$l_nombreRegla:=1
			$t_nombreRegla:="Regla "+String:C10($l_nombreRegla)
			While (Find in field:C653([ACT_MatricesAsignacionAut:289]nombre:3;$t_nombreRegla)>=0)
				$l_nombreRegla:=$l_nombreRegla+1
				$t_nombreRegla:="Regla "+String:C10($l_nombreRegla)
			End while 
			[ACT_MatricesAsignacionAut:289]nombre:3:=$t_nombreRegla
			
		Else 
			  //Selecciona matriz
			If ([ACT_MatricesAsignacionAut:289]id_matriz:4#0)
				If ([ACT_MatricesAsignacionAut:289]id_matriz:4=-1)
					atACT_NombreMatriz:=1
				Else 
					$l_pos:=Find in array:C230(alACT_IdMatriz;[ACT_MatricesAsignacionAut:289]id_matriz:4)
					If ($l_pos>0)
						atACT_NombreMatriz:=$l_pos
					Else 
						atACT_NombreMatriz:=0
						[ACT_MatricesAsignacionAut:289]id_matriz:4:=0
					End if 
				End if 
			End if 
			
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
		
End case 