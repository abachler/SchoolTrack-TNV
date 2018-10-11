//%attributes = {}
  //xALP_CFG_STR_CatAn

$Error:=AL_SetArraysNam (xALP_categoria;1;1;"at_STR_CategoriasAnot_Nombres")
$Error:=AL_SetArraysNam (xALP_categoria;2;1;"ap_TipoAnotacion")
$Error:=AL_SetArraysNam (xALP_categoria;3;1;"ai_STR_CategoriasAnot_Puntaje")
$Error:=AL_SetArraysNam (xALP_categoria;4;1;"aiSTR_IDCategoria")
$Error:=AL_SetArraysNam (xALP_categoria;5;1;"ai_TipoAnotacion")


  //column 1 settings
AL_SetHeaders (xALP_categoria;1;1;__ ("Categoria"))
AL_SetWidths (xALP_categoria;1;1;130)
AL_SetFormat (xALP_categoria;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_categoria;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_categoria;1;"Tahoma";9;0)
AL_SetStyle (xALP_categoria;1;"Tahoma";9;0)
AL_SetForeColor (xALP_categoria;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_categoria;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_categoria;1;1)
AL_SetEntryCtls (xALP_categoria;1;0)

  //column 2 settings
AL_SetHeaders (xALP_categoria;2;1;__ ("Tipo"))
AL_SetWidths (xALP_categoria;2;1;30)
AL_SetFormat (xALP_categoria;2;"1";2;0;0;0)
AL_SetHdrStyle (xALP_categoria;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_categoria;2;"Tahoma";9;0)
AL_SetStyle (xALP_categoria;2;"Tahoma";9;1)
AL_SetForeColor (xALP_categoria;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_categoria;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_categoria;2;0)
AL_SetEntryCtls (xALP_categoria;2;0)

  //column 3 settings
AL_SetHeaders (xALP_categoria;3;1;__ ("Puntaje"))
AL_SetWidths (xALP_categoria;3;1;60)
AL_SetFormat (xALP_categoria;3;"#####0";0;0;0;0)
AL_SetFilter (xALP_categoria;3;"&9")
AL_SetHdrStyle (xALP_categoria;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_categoria;3;"Tahoma";9;0)
AL_SetStyle (xALP_categoria;3;"Tahoma";10;1)
AL_SetForeColor (xALP_categoria;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_categoria;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_categoria;3;0)
AL_SetEntryCtls (xALP_categoria;3;0)

  //column 4 settings
AL_SetHeaders (xALP_categoria;4;1;__ ("ID"))
AL_SetWidths (xALP_categoria;4;1;0)
AL_SetFormat (xALP_categoria;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_categoria;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_categoria;4;"Tahoma";9;0)
AL_SetStyle (xALP_categoria;4;"Tahoma";9;0)
AL_SetForeColor (xALP_categoria;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_categoria;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_categoria;4;0)
AL_SetEntryCtls (xALP_categoria;4;0)

  //column 5 settings
AL_SetHeaders (xALP_categoria;5;1;__ ("Tipo"))
AL_SetWidths (xALP_categoria;5;1;0)
AL_SetFormat (xALP_categoria;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_categoria;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_categoria;5;"Tahoma";9;0)
AL_SetStyle (xALP_categoria;5;"Tahoma";9;0)
AL_SetForeColor (xALP_categoria;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_categoria;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_categoria;5;0)
AL_SetEntryCtls (xALP_categoria;5;0)

  //general options
ALP_SetDefaultAppareance (xALP_categoria;9;2;6;1;8)
AL_SetColOpts (xALP_categoria;1;1;1;2;0)
AL_SetRowOpts (xALP_categoria;0;0;0;0;1;0)
AL_SetSortOpts (xALP_categoria;1;2;0;"";1;1)
AL_SetCellOpts (xALP_categoria;0;1;1)
AL_SetMiscOpts (xALP_categoria;0;0;"\\";0;1)
AL_SetMainCalls (xALP_categoria;"";"")
AL_SetScroll (xALP_categoria;0;-3)
AL_SetEntryOpts (xALP_categoria;3;1;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_categoria;0;30;0;1)
AL_SetMainCalls (xALP_categoria;"";"")
AL_SetCallbacks (xALP_categoria;"xALCB_EN_CategoriaAnot";"xALCB_EX_CategoriaAnot")

AL_SetDrgDst (xALP_categoria;1;String:C10(xALP_Motivos))

ARRAY LONGINT:C221($aInt2;2;0)
For ($i;1;Size of array:C274(ai_TipoAnotacion))
	If (ai_TipoAnotacion{$i}=0)
		AL_SetCellEnter (xALP_categoria;3;$i;0;0;$aInt2;0)
	Else 
		AL_SetCellEnter (xALP_categoria;3;$i;0;0;$aInt2;1)
	End if 
	AL_GetCellEnter (xALP_categoria;3;$i;$enter)
End for 
AL_UpdateArrays (xALP_categoria;-2)