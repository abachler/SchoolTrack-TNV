C_LONGINT:C283($Error)

Case of 
	: (Form event:C388=On Load:K2:1)
		vb_wholeScreen:=False:C215
		GET PICTURE FROM LIBRARY:C565(2778;PrefIcon)
		OBJECT SET FORMAT:C236(bCFG_ShowALL;"1;2;PrefIcon;96;0")
		
		
		  //********************************************************************************************
		  //area XALP_AREASMPA
		  //********************************************************************************************
		$Error:=AL_SetArraysNam (xALP_AreasMPA;1;1;"atEVLG_Marcos_Nombres")
		$Error:=AL_SetArraysNam (xALP_AreasMPA;2;1;"alEVLG_Marcos_RecNums")
		
		  //column 1 settings
		AL_SetHeaders (xALP_AreasMPA;1;1;__ ("Areas de aprendizaje"))
		AL_SetFormat (xALP_AreasMPA;1;"";0;0;0;0)
		
		  //column 2 settings
		AL_SetHeaders (xALP_AreasMPA;2;1;"rec num (hidden)")
		
		  //general options
		AL_SetColOpts (xALP_AreasMPA;1;1;1;1;0)
		AL_SetRowOpts (xALP_AreasMPA;0;0;0;0;1;0)
		AL_SetMainCalls (xALP_AreasMPA;"";"")
		AL_SetScroll (xALP_AreasMPA;0;-3)
		AL_SetSortOpts (xALP_AreasMPA;0;0;0;"Select the columns to sort:";0)
		AL_SetEntryOpts (xALP_AreasMPA;1;0;0;0;0;".")
		AL_SetDrgOpts (xALP_AreasMPA;0;30;0;1)
		ALP_SetDefaultAppareance (xALP_AreasMPA;9;1;4;1)
		AL_SetDividers (xALP_AreasMPA;"Black";"Light Gray";0;"No Line";"Light Gray";0)
		AL_SetHdrStyle (xALP_AreasMPA;0;"Tahoma";11;0)
		AL_SetMiscOpts (xALP_AreasMPA;0;0;"\\";0;1)
		AL_SetDrgDst (xALP_AreasMPA;1;String:C10(xALP_AreasMPA);String:C10(xALP_Ejes);String:C10(xALP_Dimensiones);String:C10(xALP_Competencias))
		AL_SetInterface (xALP_AreasMPA;AL Default Interface;0;1;0;0;1;0;0)
		
		  //********************************************************************************************
		  //area XALP_EJES
		  //********************************************************************************************
		$Error:=AL_SetArraysNam (xALP_Ejes;1;1;"atEVLG_Ejes_Etapas")
		$Error:=AL_SetArraysNam (xALP_Ejes;2;1;"atEVLG_Ejes_Nombres")
		$Error:=AL_SetArraysNam (xALP_Ejes;3;1;"alEVLG_EJES_RecNums")
		$Error:=AL_SetArraysNam (xALP_Ejes;4;1;"alEVLG_Ejes_Ids")
		
		  //column 1 settings
		AL_SetHeaders (xALP_Ejes;1;1;__ ("Etapa"))
		AL_SetWidths (xALP_Ejes;1;1;45)
		AL_SetFormat (xALP_Ejes;1;"";2;0;0;0)
		AL_SetHdrStyle (xALP_Ejes;1;"tahoma";9;1)
		AL_SetFtrStyle (xALP_Ejes;1;"tahoma";9;0)
		AL_SetStyle (xALP_Ejes;1;"tahoma";9;0)
		AL_SetForeColor (xALP_Ejes;1;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Ejes;1;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Ejes;1;1)
		AL_SetEntryCtls (xALP_Ejes;1;0)
		
		  //column 2 settings
		AL_SetHeaders (xALP_Ejes;2;1;__ ("Ejes de aprendizaje"))
		AL_SetWidths (xALP_Ejes;2;1;275)
		AL_SetFormat (xALP_Ejes;2;"";0;0;0;0)
		AL_SetHdrStyle (xALP_Ejes;2;"tahoma";9;1)
		AL_SetFtrStyle (xALP_Ejes;2;"tahoma";9;0)
		AL_SetStyle (xALP_Ejes;2;"tahoma";9;0)
		AL_SetForeColor (xALP_Ejes;2;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Ejes;2;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Ejes;2;1)
		AL_SetEntryCtls (xALP_Ejes;2;0)
		
		  //general options
		AL_SetColOpts (xALP_Ejes;1;1;1;2;0)
		AL_SetRowOpts (xALP_Ejes;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_Ejes;0;1;1)
		AL_SetMiscOpts (xALP_Ejes;0;0;"\\";0;1)
		AL_SetMiscColor (xALP_Ejes;0;"White";0)
		AL_SetMiscColor (xALP_Ejes;1;"White";0)
		AL_SetMiscColor (xALP_Ejes;2;"White";0)
		AL_SetMiscColor (xALP_Ejes;3;"White";0)
		AL_SetMainCalls (xALP_Ejes;"";"")
		AL_SetScroll (xALP_Ejes;0;-3)
		AL_SetCopyOpts (xALP_Ejes;0;"\t";"\r";Char:C90(0))
		AL_SetSortOpts (xALP_Ejes;0;1;0;"Select the columns to sort:";0)
		AL_SetEntryOpts (xALP_Ejes;1;0;0;0;0;".")
		AL_SetDividers (xALP_Ejes;"No line";"Black";0;"No line";"Black";0)
		AL_SetDrgOpts (xALP_Ejes;0;30;0;1)
		
		  //dragging options
		AL_SetDrgSrc (xALP_Ejes;1;String:C10(XALP_AreasMPA);String:C10(xALP_Ejes);String:C10(xALP_Dimensiones);String:C10(xALP_Competencias))
		AL_SetDrgDst (xALP_Ejes;1;String:C10(XALP_AreasMPA);String:C10(xALP_Ejes);String:C10(xALP_Dimensiones);String:C10(xALP_Competencias))
		
		ALP_SetDefaultAppareance (xALP_Ejes;9;1;4;1)
		AL_SetDividers (xALP_Ejes;"Black";"Light Gray";0;"No Line";"Light Gray";0)
		AL_SetHdrStyle (xALP_Ejes;0;"Tahoma";11;0)
		AL_SetMiscOpts (xALP_Ejes;0;0;"\\";0;1)
		AL_SetInterface (xALP_Ejes;AL Default Interface;0;1;0;0;1;0;0)
		
		
		  //********************************************************************************************
		  //area XALP_DIMENSIONES
		  //********************************************************************************************
		$Error:=AL_SetArraysNam (xALP_Dimensiones;1;1;"atEVLG_Dimensiones_Etapas")
		$Error:=AL_SetArraysNam (xALP_Dimensiones;2;1;"atEVLG_Dimensiones_Nombres")
		$Error:=AL_SetArraysNam (xALP_Dimensiones;3;1;"alEVLG_Dimensiones_RecNums")
		AL_SetHeaders (xALP_Dimensiones;1;2;__ ("Etapa");__ ("Dimensiones de aprendizaje"))
		AL_SetWidths (xALP_Dimensiones;1;2;45;275)
		AL_SetFormat (xALP_Dimensiones;1;"";2;0;0;0)
		
		  //general options
		AL_SetColOpts (xALP_Dimensiones;1;1;1;1;0)
		AL_SetRowOpts (xALP_Dimensiones;0;1;0;0;1;0)
		AL_SetMainCalls (xALP_Dimensiones;"";"")
		AL_SetScroll (xALP_Dimensiones;0;-3)
		AL_SetSortOpts (xALP_Dimensiones;0;0;0;"Select the columns to sort:";0)
		AL_SetEntryOpts (xALP_Dimensiones;1;0;0;0;0;".")
		AL_SetDrgOpts (xALP_Dimensiones;0;30;0;1)
		ALP_SetDefaultAppareance (xALP_Dimensiones;9;1;4;1)
		AL_SetDividers (xALP_Dimensiones;"Black";"Light Gray";0;"No Line";"Light Gray";0)
		AL_SetHdrStyle (xALP_Dimensiones;0;"Tahoma";11;0)
		AL_SetMiscOpts (xALP_Dimensiones;0;0;"\\";0;1)
		AL_SetDrgSrc (xALP_Dimensiones;1;String:C10(xALP_AreasMPA);String:C10(xALP_Ejes);String:C10(xALP_Dimensiones);String:C10(xALP_Competencias))
		AL_SetDrgDst (xALP_Dimensiones;1;String:C10(xALP_AreasMPA);String:C10(xALP_Ejes);String:C10(xALP_Dimensiones);String:C10(xALP_Competencias))
		AL_SetInterface (xALP_Dimensiones;AL Default Interface;0;1;0;0;1;0;0)
		
		
		MPAcfg_Area_Lista 
		MPAcfg_ContenidoAreas 
		
		
		cb_AutoActualizaMatricesMPA:=Num:C11(PREF_fGet (0;"AutoActualizaMatricesMPA";"0"))
		vb_wholeScreen:=False:C215
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		
	: (Form event:C388=On Plug in Area:K2:16)
		$l_filaSeleccionada:=AL_GetLine (xALP_Dimensiones)
		If ($l_filaSeleccionada#0)
			AL_SetScroll (xALP_Dimensiones;$l_filaSeleccionada;1)
		End if 
		  //If ($l_filaSeleccionada=0)
		  //$l_filaSeleccionada:=1
		  //End if 
		  //AL_SetScroll (xALP_Dimensiones;$l_filaSeleccionada;1)
		
		$l_filaSeleccionada:=AL_GetLine (xALP_Ejes)
		If ($l_filaSeleccionada#0)
			AL_SetScroll (xALP_Ejes;$l_filaSeleccionada;1)
		End if 
		  //If ($l_filaSeleccionada=0)
		  //$l_filaSeleccionada:=1
		  //End if 
		  //AL_SetScroll (xALP_Ejes;$l_filaSeleccionada;1)
		
		AL_GetScroll (xALP_Competencias;$l_scrollVertical;$l_scrollHorizontal)
		$err:=AL_GetCellSel (xALP_Competencias;$l_columna;$l_fila)
		If (($l_columna=$l_scrollVertical) & ($l_fila=$l_scrollHorizontal))
			If ($l_columna=0)
				$l_columna:=1
			End if 
			If ($l_fila=0)
				$l_fila:=1
			End if 
			AL_SetScroll (xALP_Competencias;$l_fila;$l_columna)
		End if 
		
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 