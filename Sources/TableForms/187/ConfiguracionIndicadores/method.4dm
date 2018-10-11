Case of 
	: (Form event:C388=On Load:K2:1)
		  //carga de los indicadores definidos para el logro
		ARRAY TEXT:C222(atEVLG_Indicadores_Descripcion;0)
		ARRAY INTEGER:C220(aiEVLG_Indicadores_Valor;0)
		_O_ARRAY STRING:C218(5;atEVLG_Indicadores_Concepto;0)
		BLOB_Blob2Vars (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->atEVLG_Indicadores_Descripcion;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Concepto)
		
		  //Configuration commands for ALP object 'xALP_Indicadores'
		  //You can paste this into an ALP object's method, rather than
		  //use the Advanced Properties dialog to control the configuration.
		  //Commands always have priority over the settings in the dialog.
		
		C_LONGINT:C283($Error)
		
		  //specify arrays to display
		AL_RemoveArrays (xALP_Indicadores;1;3)
		$Error:=AL_SetArraysNam (xALP_Indicadores;1;1;"atEVLG_Indicadores_Descripcion")
		$Error:=AL_SetArraysNam (xALP_Indicadores;2;1;"aiEVLG_Indicadores_Valor")
		$Error:=AL_SetArraysNam (xALP_Indicadores;3;1;"atEVLG_Indicadores_Concepto")
		
		  //column 1 settings
		AL_SetHeaders (xALP_Indicadores;1;1;__ ("Descripción"))
		AL_SetWidths (xALP_Indicadores;1;1;310)
		AL_SetFormat (xALP_Indicadores;1;"";0;0;0;0)
		AL_SetHdrStyle (xALP_Indicadores;1;"Arial";9;1)
		AL_SetFtrStyle (xALP_Indicadores;1;"Arial";9;0)
		AL_SetStyle (xALP_Indicadores;1;"Arial";9;0)
		AL_SetForeColor (xALP_Indicadores;1;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Indicadores;1;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Indicadores;1;1)
		AL_SetEntryCtls (xALP_Indicadores;1;0)
		
		  //column 1 settings
		AL_SetHeaders (xALP_Indicadores;2;1;__ ("Valor"))
		AL_SetWidths (xALP_Indicadores;2;1;40)
		AL_SetFormat (xALP_Indicadores;2;"###0";0;0;0;0)
		AL_SetHdrStyle (xALP_Indicadores;2;"Arial";9;1)
		AL_SetFtrStyle (xALP_Indicadores;2;"Arial";9;0)
		AL_SetStyle (xALP_Indicadores;2;"Arial";9;0)
		AL_SetForeColor (xALP_Indicadores;2;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Indicadores;2;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Indicadores;2;1)
		AL_SetEntryCtls (xALP_Indicadores;2;0)
		
		  //column 2 settings
		AL_SetHeaders (xALP_Indicadores;3;1;__ ("Símbolo"))
		AL_SetWidths (xALP_Indicadores;3;1;80)
		AL_SetFormat (xALP_Indicadores;3;"";0;0;0;0)
		AL_SetHdrStyle (xALP_Indicadores;3;"Arial";9;1)
		AL_SetFtrStyle (xALP_Indicadores;3;"Arial";9;0)
		AL_SetStyle (xALP_Indicadores;3;"Arial";9;0)
		AL_SetForeColor (xALP_Indicadores;3;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Indicadores;3;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Indicadores;3;1)
		AL_SetEntryCtls (xALP_Indicadores;3;0)
		
		  //general options
		AL_SetColOpts (xALP_Indicadores;1;1;1;0;0)
		AL_SetRowOpts (xALP_Indicadores;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_Indicadores;0;1;1)
		AL_SetMiscOpts (xALP_Indicadores;0;0;"\\";0;1)
		AL_SetMiscColor (xALP_Indicadores;0;"White";0)
		AL_SetMiscColor (xALP_Indicadores;1;"White";0)
		AL_SetMiscColor (xALP_Indicadores;2;"White";0)
		AL_SetMiscColor (xALP_Indicadores;3;"White";0)
		AL_SetMainCalls (xALP_Indicadores;"";"")
		AL_SetCallbacks (xALP_Indicadores;"";"xALCB_EX_IndicadoresLogros")
		AL_SetScroll (xALP_Indicadores;0;-3)
		AL_SetCopyOpts (xALP_Indicadores;0;"\t";"\r";Char:C90(0))
		AL_SetSortOpts (xALP_Indicadores;0;1;0;"Select the columns to sort:";0)
		AL_SetEntryOpts (xALP_Indicadores;3;0;0;0;1;",")
		AL_SetHeight (xALP_Indicadores;1;2;1;1;2)
		AL_SetDividers (xALP_Indicadores;"No line";"Black";0;"No line";"Black";0)
		AL_SetDrgOpts (xALP_Indicadores;0;30;0)
		
		  //dragging options
		AL_SetDrgSrc (xALP_Indicadores;1;"";"";"")
		AL_SetDrgSrc (xALP_Indicadores;2;"";"";"")
		AL_SetDrgSrc (xALP_Indicadores;3;"";"";"")
		AL_SetDrgDst (xALP_Indicadores;1;"";"";"")
		AL_SetDrgDst (xALP_Indicadores;1;"";"";"")
		AL_SetDrgDst (xALP_Indicadores;1;"";"";"")
		
		ALP_SetDefaultAppareance (xALP_Indicadores;9;2)
		AL_SetMiscOpts (xALP_Indicadores;0;0;"\\";0;1)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4) | (Form event:C388=On Plug in Area:K2:16))
		$line:=AL_GetLine (xALP_Indicadores)
		IT_SetButtonState (AL_GetLine (xALP_Indicadores)>0;->bDelIndicador)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 