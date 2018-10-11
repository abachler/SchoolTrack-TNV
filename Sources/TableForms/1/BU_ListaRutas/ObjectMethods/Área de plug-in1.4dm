Case of 
	: (alProEvt=AL Single click event)
		IT_SetButtonState (True:C214;->bDelRuta)
	: (alProEvt=AL Double click event)
		$line:=AL_GetLine (Self:C308->)
		READ ONLY:C145([BU_Rutas:26])
		QUERY:C277([BU_Rutas:26];[BU_Rutas:26]ID:12=alBU_IdRuta{$line})  //Selecciona la Ruta cuyo ID se igual al actual elemento del arreglo
		[BU_Rutas:26]ID:12:=alBU_IdRuta{$line}
		sMatBus:=[BU_Rutas:26]Patente_Bus:11
		vTotRec:=[BU_Rutas:26]Total_Recorridos:13
		READ ONLY:C145([Profesores:4])
		QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[BU_Rutas:26]Numero_Monitor:10)
		varMonitor:=[Profesores:4]Apellidos_y_nombres:28
		READ ONLY:C145([Buses_escolares:57])
		QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1=sMatBus)
		vl_NoBus:=[Buses_escolares:57]Numero:10
		QUERY:C277([BU_Rutas:26];[BU_Rutas:26]ID:12=alBU_IdRuta{$line})
		  //************************************* XALP_RECORRIDOS ***********************************************
		BU_Refresh_Recorridos (0;alBU_IdRuta{$line})
		
		  //*************************************XALP_ALUMNOS *****************************************************
		BU_Refresh_Inscripciones (0)
		
		  //*************************************XALP_LISTACOMUNAS **********************************************
		  //Array para las comunas seleccionadas para la ruta
		ARRAY TEXT:C222(atBU_NomCom;0)
		READ ONLY:C145([BU_Rutas_Comunas:27])
		QUERY:C277([BU_Rutas_Comunas:27];[BU_Rutas_Comunas:27]Numero_Ruta:1=alBU_IdRuta{$line})
		SELECTION TO ARRAY:C260([BU_Rutas_Comunas:27]Nombre_Comuna:2;atBU_NomCom)
		
		  //*************************************XALP_COMUNAS *****************************************************
		ARRAY TEXT:C222(atBU_GenNomCom;0)
		ARRAY TEXT:C222($atBU_TotComNom;0)  //Arreglo local para levantar  los nombres de todas las comunas
		If (<>vtXS_CountryCode="cl")
			COPY ARRAY:C226(<>aComuna;$atBU_TotComNom)
		Else 
			COPY ARRAY:C226(<>aComuna;$atBU_TotComNom)
		End if 
		
		$listado:=Size of array:C274($atBU_TotComNom)-Size of array:C274(atBU_NomCom)  //Cantidad total de Comunas a seleccionar
		
		ARRAY TEXT:C222(atBU_GenNomCom;$listado)  //Contendrá solo las comunas que no esten seleccionadas
		_O_C_INTEGER:C282($vi_ArrayIndex)  //Indice para armar el array de las comunas a seleccionar
		$vi_ArrayIndex:=1
		_O_C_INTEGER:C282($vi_valorBuscado)
		$vi_valorBuscado:=0
		For ($i;1;Size of array:C274($atBU_TotComNom))
			If (Size of array:C274(atBU_NomCom)>0)
				$vi_valorBuscado:=Find in array:C230(atBU_NomCom;$atBU_TotComNom{$i};1)
				If ($vi_valorBuscado<0)
					  //incluir control del largo del array
					atBU_GenNomCom{$vi_ArrayIndex}:=$atBU_TotComNom{$i}
					$vi_ArrayIndex:=$vi_ArrayIndex+1
				End if 
			Else 
				atBU_GenNomCom{$vi_ArrayIndex}:=$atBU_TotComNom{$i}
				$vi_ArrayIndex:=$vi_ArrayIndex+1
			End if 
			
		End for 
		  //Limpiar los array locales:
		$vi_ArrayIndex:=Size of array:C274($atBU_TotComNom)
		DELETE FROM ARRAY:C228($atBU_TotComNom;1;$vi_ArrayIndex)
		
		
		
		  //Array para el listado de Comunas a seleccionar
		
		  //***************************************************************************************************************
		vb_ValidateTransaction:=False:C215
		  //START TRANSACTION
		WDW_OpenFormWindow (->[BU_Rutas:26];"input";-1;4)  //Para abrir la ventana....
		KRL_ModifyRecord (->[BU_Rutas:26];"input")
		CLOSE WINDOW:C154
		If (vb_ValidateTransaction)
			  //VALIDATE TRANSACTION
		Else 
			  //CANCEL TRANSACTION
		End if 
		AL_SetLine (xalp_Rutas;0)
		IT_SetButtonState (False:C215;->bDelRuta)
		
End case 