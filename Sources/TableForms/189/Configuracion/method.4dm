C_LONGINT:C283($hResize;$bWidth;$bHeight)

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		$area:=""
		$el:=Find in array:C230(<>aAsign;[Asignaturas:18]Asignatura:3)
		If ($el>0)
			$area:=<>aAsgAreaMPA{$el}
		End if 
		vtMPA_MatrizDefecto:=""
		vtMPA_MatrizActual:=""
		vtEVLG_InfoConfig:=""
		
		  //Lectura de todas las matrices asociadas al area de la asignatura
		$recNumMateria:=Find in field:C653([xxSTR_Materias:20]Materia:2;[Asignaturas:18]Asignatura:3)
		KRL_GotoRecord (->[xxSTR_Materias:20];$recNumMateria;False:C215)
		
		KRL_FindAndLoadRecordByIndex (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91)
		vtMPA_MatrizActual:=[MPA_AsignaturasMatrices:189]NombreMatriz:2
		vlMPA_IDMatrizActual:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
		vlMPA_RecNumMatrizActual:=Record number:C243([MPA_AsignaturasMatrices:189])
		
		
		READ ONLY:C145([MPA_AsignaturasMatrices:189])
		QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Area:13;=;[xxSTR_Materias:20]AreaMPA:4;*)
		QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4;=;[Asignaturas:18]Numero_del_Nivel:6)
		ORDER BY:C49([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;<)
		vtMPA_MatrizDefecto:=[MPA_AsignaturasMatrices:189]NombreMatriz:2
		vlMPA_RecNumMatrizDefecto:=Record number:C243([MPA_AsignaturasMatrices:189])
		vlMPA_IDMatrizDefecto:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
		
		SELECTION TO ARRAY:C260([MPA_AsignaturasMatrices:189]NombreMatriz:2;atMPA_NombreMatriz;[MPA_AsignaturasMatrices:189];alMPA_RecNumMatriz)
		
		
		ARRAY TEXT:C222(atEVLG_EjesLogros;0)
		ARRAY LONGINT:C221(alEVLG_Ids;0)
		ARRAY LONGINT:C221(alEVLG_TipoObjeto;0)
		ARRAY TEXT:C222(atEVLG_Icons;0)
		MPAmtx_LeeConfiguracion (vlMPA_RecNumMatrizDefecto;1;->alEVLG_TipoObjeto;->alEVLG_Ids;->atEVLG_EjesLogros;->atEVLG_Icons)
		
		
		
		
		  //Configuration commands for ALP object 'xALP_Configs'
		  //You can paste this into an ALP object's method, rather than
		  //use the Advanced Properties dialog to control the configuration.
		  //Commands always have priority over the settings in the dialog.
		
		C_LONGINT:C283($Error)
		
		  //specify arrays to display
		$Error:=AL_SetArraysNam (xALP_Configs;1;1;"atMPA_NombreMatriz")
		$Error:=AL_SetArraysNam (xALP_Configs;2;1;"alMPA_RecNumMatriz")
		
		  //column 1 settings
		AL_SetHeaders (xALP_Configs;1;1;"Column 1")
		AL_SetFormat (xALP_Configs;1;"";0;0;0;0)
		AL_SetHdrStyle (xALP_Configs;1;"tahoma";9;1)
		AL_SetFtrStyle (xALP_Configs;1;"tahoma";9;0)
		AL_SetStyle (xALP_Configs;1;"tahoma";9;0)
		AL_SetForeColor (xALP_Configs;1;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Configs;1;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Configs;1;1)
		AL_SetEntryCtls (xALP_Configs;1;0)
		
		  //column 2 settings
		AL_SetHeaders (xALP_Configs;2;1;"Column 2")
		AL_SetFormat (xALP_Configs;2;"";0;0;0;0)
		AL_SetHdrStyle (xALP_Configs;2;"tahoma";9;1)
		AL_SetFtrStyle (xALP_Configs;2;"tahoma";9;0)
		AL_SetStyle (xALP_Configs;2;"tahoma";9;0)
		AL_SetForeColor (xALP_Configs;2;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Configs;2;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Configs;2;1)
		AL_SetEntryCtls (xALP_Configs;2;0)
		
		  //general options
		
		AL_SetColOpts (xALP_Configs;1;1;1;1;0)
		AL_SetRowOpts (xALP_Configs;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_Configs;0;1;1)
		AL_SetMiscOpts (xALP_Configs;1;0;"\\";0;1)
		AL_SetMiscColor (xALP_Configs;0;"White";0)
		AL_SetMiscColor (xALP_Configs;1;"White";0)
		AL_SetMiscColor (xALP_Configs;2;"White";0)
		AL_SetMiscColor (xALP_Configs;3;"White";0)
		AL_SetMainCalls (xALP_Configs;"";"")
		AL_SetScroll (xALP_Configs;0;-3)
		AL_SetCopyOpts (xALP_Configs;0;"\t";"\r";Char:C90(0))
		AL_SetSortOpts (xALP_Configs;0;1;0;"Select the columns to sort:";0)
		AL_SetEntryOpts (xALP_Configs;0;0;0;0;0;".")
		AL_SetHeight (xALP_Configs;1;2;3;1;2)
		AL_SetDividers (xALP_Configs;"No line";"Light Gray";0;"Black";"Light Gray";0)
		AL_SetDrgOpts (xALP_Configs;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xALP_Configs;1;"";"";"")
		AL_SetDrgSrc (xALP_Configs;2;"";"";"")
		AL_SetDrgSrc (xALP_Configs;3;"";"";"")
		AL_SetDrgDst (xALP_Configs;1;"";"";"")
		AL_SetDrgDst (xALP_Configs;1;"";"";"")
		AL_SetDrgDst (xALP_Configs;1;"";"";"")
		
		ALP_SetDefaultAppareance (xALP_Configs;11;3;8)
		AL_SetMiscOpts (xALP_Configs;1;0;"\\";0;1)
		AL_SetRowStyle (xALP_Configs;1;1)
		
		$el:=Find in array:C230(alMPA_RecNumMatriz;vlMPA_RecNumMatrizActual)
		AL_SetLine (xALP_Configs;$el)
		AL_SetRowColor (xALP_Configs;$el;"Red")
		AL_SetRowStyle (xALP_Configs;$el;1)
		
		
		
		
		
		  //Configuration commands for ALP object 'xALP_Banco'
		  //You can paste this into an ALP object's method, rather than
		  //use the Advanced Properties dialog to control the configuration.
		  //Commands always have priority over the settings in the dialog.
		
		C_LONGINT:C283($Error)
		
		  //specify arrays to display
		  //AL_RemoveArrays (xALP_Banco;1;4)
		$Error:=AL_SetArraysNam (xALP_Banco;1;1;"atEVLG_Icons")
		$Error:=AL_SetArraysNam (xALP_Banco;2;1;"atEVLG_EjesLogros")
		$Error:=AL_SetArraysNam (xALP_Banco;3;1;"alEVLG_Ids")
		$Error:=AL_SetArraysNam (xALP_Banco;4;1;"alEVLG_TipoObjeto")
		
		  //column 1 settings
		AL_SetHeaders (xALP_Banco;1;1;"")
		AL_SetWidths (xALP_Banco;1;1;24)
		AL_SetFormat (xALP_Banco;1;"";0;0;0;0)
		AL_SetHdrStyle (xALP_Banco;1;"tahoma";9;1)
		AL_SetFtrStyle (xALP_Banco;1;"tahoma";9;0)
		AL_SetStyle (xALP_Banco;1;"tahoma";9;0)
		AL_SetForeColor (xALP_Banco;1;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Banco;1;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Banco;1;1)
		AL_SetEntryCtls (xALP_Banco;1;0)
		
		  //column 2 settings
		AL_SetHeaders (xALP_Banco;2;1;__ ("Competencias"))
		AL_SetWidths (xALP_Banco;2;1;476)
		AL_SetFormat (xALP_Banco;2;"";0;0;0;0)
		AL_SetHdrStyle (xALP_Banco;2;"tahoma";9;1)
		AL_SetFtrStyle (xALP_Banco;2;"tahoma";9;0)
		AL_SetStyle (xALP_Banco;2;"tahoma";9;0)
		AL_SetForeColor (xALP_Banco;2;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Banco;2;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Banco;2;1)
		AL_SetEntryCtls (xALP_Banco;2;0)
		
		  //column 3 settings
		AL_SetHeaders (xALP_Banco;3;1;"Column 3")
		AL_SetFormat (xALP_Banco;3;"";0;0;0;0)
		AL_SetHdrStyle (xALP_Banco;3;"tahoma";9;1)
		AL_SetFtrStyle (xALP_Banco;3;"tahoma";9;0)
		AL_SetStyle (xALP_Banco;3;"tahoma";9;0)
		AL_SetForeColor (xALP_Banco;3;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Banco;3;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Banco;3;1)
		AL_SetEntryCtls (xALP_Banco;3;0)
		
		  //column 4 settings
		AL_SetHeaders (xALP_Banco;4;1;"Column 4")
		AL_SetFormat (xALP_Banco;4;"";0;0;0;0)
		AL_SetHdrStyle (xALP_Banco;4;"tahoma";9;1)
		AL_SetFtrStyle (xALP_Banco;4;"tahoma";9;0)
		AL_SetStyle (xALP_Banco;4;"tahoma";9;0)
		AL_SetForeColor (xALP_Banco;4;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Banco;4;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Banco;4;1)
		AL_SetEntryCtls (xALP_Banco;4;0)
		
		  //general options
		
		AL_SetColOpts (xALP_Banco;1;1;1;2;0)
		AL_SetRowOpts (xALP_Banco;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_Banco;0;1;1)
		AL_SetMiscOpts (xALP_Banco;1;0;"\\";0;1)
		AL_SetMiscColor (xALP_Banco;0;"White";0)
		AL_SetMiscColor (xALP_Banco;1;"White";0)
		AL_SetMiscColor (xALP_Banco;2;"White";0)
		AL_SetMiscColor (xALP_Banco;3;"White";0)
		AL_SetMainCalls (xALP_Banco;"";"")
		AL_SetScroll (xALP_Banco;0;0)
		AL_SetCopyOpts (xALP_Banco;0;"\t";"\r";Char:C90(0))
		AL_SetSortOpts (xALP_Banco;0;0;0;"Select the columns to sort:";0)
		AL_SetEntryOpts (xALP_Banco;1;0;0;0;0;".")
		AL_SetHeight (xALP_Banco;1;2;1;4;2)
		AL_SetDividers (xALP_Banco;"No line";"No Line";0;"No line";"Black";0)
		AL_SetDrgOpts (xALP_Banco;0;30;0)
		AL_SetDrgSrc (xALP_Banco;1;String:C10(xALP_Banco))
		AL_SetDrgDst (xALP_Banco;1;String:C10(xALP_LogrosAsignaturas))
		
		ALP_SetDefaultAppareance (xALP_Banco;9;1;5)
		AL_SetMiscOpts (xALP_Banco;1;0;"\\";0;1)
		AL_SetDividers (xALP_Banco;"No line";"No Line";0;"Black";"No Line";0)
		
		For ($i;1;Size of array:C274(alEVLG_Ids))
			Case of 
				: (alEVLG_TipoObjeto{$i}=Eje_Aprendizaje)
					AL_SetRowStyle (xALP_Banco;$i;1)
				: (alEVLG_TipoObjeto{$i}=Dimension_Aprendizaje)
					AL_SetRowStyle (xALP_Banco;$i;2)
				Else 
					AL_SetRowStyle (xALP_Banco;$i;0)
			End case 
		End for 
		
		MPAmtx_LeeConfiguracion (vlMPA_RecNumMatrizActual;1;->alEVLG_AdvCFG_TipoObjeto;->alEVLG_AdvCFG_Ids;->atEVLG_AdvCFG_EjesLogros;->atEVLG_AdvCFG_Icons)
		
		
		  //specify arrays to display
		AL_RemoveArrays (xALP_LogrosAsignaturas;1;4)
		$Error:=AL_SetArraysNam (xALP_LogrosAsignaturas;1;1;"atEVLG_AdvCFG_Icons")
		$Error:=AL_SetArraysNam (xALP_LogrosAsignaturas;2;1;"atEVLG_AdvCFG_EjesLogros")
		$Error:=AL_SetArraysNam (xALP_LogrosAsignaturas;3;1;"alEVLG_AdvCFG_Ids")
		$Error:=AL_SetArraysNam (xALP_LogrosAsignaturas;4;1;"alEVLG_AdvCFG_TipoObjeto")
		
		  //column 1 settings
		AL_SetHeaders (xALP_LogrosAsignaturas;1;1;"")
		AL_SetWidths (xALP_LogrosAsignaturas;1;1;24)
		AL_SetFormat (xALP_LogrosAsignaturas;1;"";0;0;0;0)
		AL_SetHdrStyle (xALP_LogrosAsignaturas;1;"tahoma";9;1)
		AL_SetFtrStyle (xALP_LogrosAsignaturas;1;"tahoma";9;0)
		AL_SetStyle (xALP_LogrosAsignaturas;1;"tahoma";9;0)
		AL_SetForeColor (xALP_LogrosAsignaturas;1;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_LogrosAsignaturas;1;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_LogrosAsignaturas;1;1)
		AL_SetEntryCtls (xALP_LogrosAsignaturas;1;0)
		
		  //column 2 settings
		AL_SetHeaders (xALP_LogrosAsignaturas;2;1;__ ("Enunciados Logros"))
		AL_SetWidths (xALP_LogrosAsignaturas;2;1;476)
		AL_SetFormat (xALP_LogrosAsignaturas;2;"";0;0;0;0)
		AL_SetHdrStyle (xALP_LogrosAsignaturas;2;"tahoma";9;1)
		AL_SetFtrStyle (xALP_LogrosAsignaturas;2;"tahoma";9;0)
		AL_SetStyle (xALP_LogrosAsignaturas;2;"tahoma";9;0)
		AL_SetForeColor (xALP_LogrosAsignaturas;2;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_LogrosAsignaturas;2;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_LogrosAsignaturas;2;1)
		AL_SetEntryCtls (xALP_LogrosAsignaturas;2;0)
		
		  //column 3 settings
		AL_SetHeaders (xALP_LogrosAsignaturas;3;1;"Column 3")
		AL_SetFormat (xALP_LogrosAsignaturas;3;"";0;0;0;0)
		AL_SetHdrStyle (xALP_LogrosAsignaturas;3;"tahoma";9;1)
		AL_SetFtrStyle (xALP_LogrosAsignaturas;3;"tahoma";9;0)
		AL_SetStyle (xALP_LogrosAsignaturas;3;"tahoma";9;0)
		AL_SetForeColor (xALP_LogrosAsignaturas;3;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_LogrosAsignaturas;3;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_LogrosAsignaturas;3;1)
		AL_SetEntryCtls (xALP_LogrosAsignaturas;3;0)
		
		  //column 4 settings
		AL_SetHeaders (xALP_LogrosAsignaturas;4;1;"Column 4")
		AL_SetFormat (xALP_LogrosAsignaturas;4;"";0;0;0;0)
		AL_SetHdrStyle (xALP_LogrosAsignaturas;4;"tahoma";9;1)
		AL_SetFtrStyle (xALP_LogrosAsignaturas;4;"tahoma";9;0)
		AL_SetStyle (xALP_LogrosAsignaturas;4;"tahoma";9;0)
		AL_SetForeColor (xALP_LogrosAsignaturas;4;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_LogrosAsignaturas;4;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_LogrosAsignaturas;4;1)
		AL_SetEntryCtls (xALP_LogrosAsignaturas;4;0)
		
		  //general options
		
		AL_SetColOpts (xALP_LogrosAsignaturas;1;1;1;2;0)
		AL_SetRowOpts (xALP_LogrosAsignaturas;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_LogrosAsignaturas;0;1;1)
		AL_SetMiscOpts (xALP_LogrosAsignaturas;1;0;"\\";0;1)
		AL_SetMiscColor (xALP_LogrosAsignaturas;0;"White";0)
		AL_SetMiscColor (xALP_LogrosAsignaturas;1;"White";0)
		AL_SetMiscColor (xALP_LogrosAsignaturas;2;"White";0)
		AL_SetMiscColor (xALP_LogrosAsignaturas;3;"White";0)
		AL_SetMainCalls (xALP_LogrosAsignaturas;"";"")
		AL_SetScroll (xALP_LogrosAsignaturas;0;0)
		AL_SetCopyOpts (xALP_LogrosAsignaturas;0;"\t";"\r";Char:C90(0))
		AL_SetSortOpts (xALP_LogrosAsignaturas;0;0;0;"Select the columns to sort:";0)
		AL_SetEntryOpts (xALP_LogrosAsignaturas;1;0;0;0;0;".")
		AL_SetHeight (xALP_LogrosAsignaturas;1;2;1;4;2)
		AL_SetDividers (xALP_LogrosAsignaturas;"No line";"No Line";0;"No line";"Black";0)
		AL_SetDrgOpts (xALP_LogrosAsignaturas;0;30;0)
		AL_SetDrgDst (xALP_LogrosAsignaturas;1;String:C10(xALP_Banco))
		AL_SetDrgSrc (xALP_LogrosAsignaturas;1;String:C10(xALP_LogrosAsignaturas))
		
		ALP_SetDefaultAppareance (xALP_LogrosAsignaturas;9;1;5)
		AL_SetMiscOpts (xALP_LogrosAsignaturas;1;0;"\\";0;1)
		AL_SetDividers (xALP_LogrosAsignaturas;"No line";"No Line";0;"Black";"No Line";0)
		
		
		For ($i;1;Size of array:C274(alEVLG_AdvCFG_Ids))
			Case of 
				: (alEVLG_AdvCFG_TipoObjeto{$i}=Eje_Aprendizaje)
					AL_SetRowStyle (xALP_LogrosAsignaturas;$i;1)
				: (alEVLG_AdvCFG_TipoObjeto{$i}=Dimension_Aprendizaje)
					AL_SetRowStyle (xALP_LogrosAsignaturas;$i;2)
				Else 
					AL_SetRowStyle (xALP_LogrosAsignaturas;$i;0)
			End case 
		End for 
		
		
		GOTO RECORD:C242([MPA_AsignaturasMatrices:189];vlMPA_RecNumMatrizActual)
		If ([MPA_AsignaturasMatrices:189]CreadaPor:15#"")
			$createdBy:="Creada por: \r"+[MPA_AsignaturasMatrices:189]CreadaPor:15+" el "
		Else 
			$createdBy:="Creada el: "
		End if 
		If ([MPA_AsignaturasMatrices:189]CreadaPor:15#"")
			$modifiedBy:="\rModificada por: \r"+[MPA_AsignaturasMatrices:189]ModificadaPor:17+" el "
		Else 
			$modifiedBy:="\rModificada el: "
		End if 
		vtEVLG_InfoConfig:=$createdBy+String:C10(DTS_GetDate ([MPA_AsignaturasMatrices:189]DTS_Creacion:16))+", "+String:C10(DTS_GetTime ([MPA_AsignaturasMatrices:189]DTS_Creacion:16);2)
		vtEVLG_InfoConfig:=vtEVLG_InfoConfig+"\r"+$modifiedBy+String:C10(DTS_GetDate ([MPA_AsignaturasMatrices:189]DTS_Modificacion:18))+", "+String:C10(DTS_GetTime ([MPA_AsignaturasMatrices:189]DTS_Modificacion:18);2)
		
		GET LIST ITEM:C378(hl_Periodos;Selected list items:C379(hl_Periodos);$refPeriodo;$itemText)
		
		If ([MPA_AsignaturasMatrices:189]ID_Matriz:1=[Asignaturas:18]EVAPR_IdMatriz:91)
			_O_DISABLE BUTTON:C193(bSetConfig)
			_O_ENABLE BUTTON:C192(hl_Periodos)
			OBJECT SET COLOR:C271(vtEVLG_SpecificConfig;-3)
		Else 
			_O_ENABLE BUTTON:C192(bSetConfig)
			_O_ENABLE BUTTON:C192(hl_Periodos)
		End if 
		OBJECT SET VISIBLE:C603(*;"popupconfig_arrow";True:C214)
		
		If (vlMPA_RecNumMatrizActual>=0)
			_O_ENABLE BUTTON:C192(hl_Periodos)
		Else 
			_O_DISABLE BUTTON:C193(hl_Periodos)
		End if 
		
		_O_DISABLE BUTTON:C193(bSetConfig)
		If (vlMPA_IDMatrizDefecto#[Asignaturas:18]EVAPR_IdMatriz:91)
			_O_ENABLE BUTTON:C192(bSetDefaultConfig)
		Else 
			_O_DISABLE BUTTON:C193(bSetDefaultConfig)
		End if 
		If ([MPA_AsignaturasMatrices:189]ID_Matriz:1#vlMPA_IDMatrizActual)
			_O_ENABLE BUTTON:C192(bSetConfig)
		Else 
			_O_DISABLE BUTTON:C193(bSetConfig)
		End if 
		
		POST KEY:C465(Character code:C91("=");256)
		
	: (Form event:C388=On Clicked:K2:4)
		
		
		If (vlMPA_RecNumMatrizActual>=0)
			_O_ENABLE BUTTON:C192(hl_Periodos)
		Else 
			_O_DISABLE BUTTON:C193(hl_Periodos)
		End if 
		
		If (vlMPA_IDMatrizDefecto#[Asignaturas:18]EVAPR_IdMatriz:91)
			_O_ENABLE BUTTON:C192(bSetDefaultConfig)
		Else 
			_O_DISABLE BUTTON:C193(bSetDefaultConfig)
		End if 
		If ([MPA_AsignaturasMatrices:189]ID_Matriz:1#vlMPA_IDMatrizActual)
			_O_ENABLE BUTTON:C192(bSetConfig)
		Else 
			_O_DISABLE BUTTON:C193(bSetConfig)
		End if 
		
		For ($i;1;Size of array:C274(alMPA_RecNumMatriz))
			AL_SetRowStyle (xALP_Configs;$i;0)
			AL_SetRowColor (xALP_Configs;$i;"Black")
		End for 
		
		AL_SetRowStyle (xALP_Configs;1;1)
		$el:=Find in array:C230(alMPA_RecNumMatriz;vlMPA_RecNumMatrizActual)
		AL_SetRowColor (xALP_Configs;$el;"Red")
		AL_SetRowStyle (xALP_Configs;$el;1)
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		AL_RemoveArrays (xALP_Banco;1;30)
		
End case 
