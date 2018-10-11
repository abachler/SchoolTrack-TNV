//%attributes = {}
  //xALP_CFG_STR_TablaFaltas

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_TablaFaltasMin;1;1;"ATSTRAL_FALTATIPO")
$Error:=AL_SetArraysNam (xALP_TablaFaltasMin;2;1;"ATSTRAL_FALTAMINUTOSDESDE")
$Error:=AL_SetArraysNam (xALP_TablaFaltasMin;3;1;"ATSTRAL_FALTAMINUTOSHASTA")
$Error:=AL_SetArraysNam (xALP_TablaFaltasMin;4;1;"ATSTRAL_FALTACONV")

  //column 1 settings
AL_SetHeaders (xALP_TablaFaltasMin;1;1;__ ("Fracción de Falta"))
AL_SetWidths (xALP_TablaFaltasMin;1;1;90)
AL_SetFormat (xALP_TablaFaltasMin;1;"";2;0;0;0)
AL_SetHdrStyle (xALP_TablaFaltasMin;1;"Arial";9;1)
AL_SetFtrStyle (xALP_TablaFaltasMin;1;"Arial";9;0)
AL_SetStyle (xALP_TablaFaltasMin;1;"Arial";9;0)
AL_SetForeColor (xALP_TablaFaltasMin;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_TablaFaltasMin;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_TablaFaltasMin;1;1)
AL_SetEntryCtls (xALP_TablaFaltasMin;1;0)

  //column 2 settings
AL_SetHeaders (xALP_TablaFaltasMin;2;1;__ ("Desde"))
AL_SetWidths (xALP_TablaFaltasMin;2;1;45)
AL_SetFormat (xALP_TablaFaltasMin;2;"##0";2;0;0;0)
AL_SetHdrStyle (xALP_TablaFaltasMin;2;"Arial";9;1)
AL_SetFtrStyle (xALP_TablaFaltasMin;2;"Arial";9;0)
AL_SetStyle (xALP_TablaFaltasMin;2;"Arial";9;0)
AL_SetForeColor (xALP_TablaFaltasMin;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_TablaFaltasMin;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_TablaFaltasMin;2;1)
AL_SetEntryCtls (xALP_TablaFaltasMin;2;0)

  //column 3 settings
AL_SetHeaders (xALP_TablaFaltasMin;3;1;__ ("Hasta"))
AL_SetWidths (xALP_TablaFaltasMin;3;1;45)
AL_SetFormat (xALP_TablaFaltasMin;3;"##0";2;0;0;0)
AL_SetHdrStyle (xALP_TablaFaltasMin;3;"Arial";9;1)
AL_SetFtrStyle (xALP_TablaFaltasMin;3;"Arial";9;0)
AL_SetStyle (xALP_TablaFaltasMin;3;"Arial";9;0)
AL_SetForeColor (xALP_TablaFaltasMin;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_TablaFaltasMin;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_TablaFaltasMin;3;1)
AL_SetEntryCtls (xALP_TablaFaltasMin;3;0)

  //column 3 settings
AL_SetHeaders (xALP_TablaFaltasMin;4;1;__ ("Conversión"))
AL_SetWidths (xALP_TablaFaltasMin;4;1;60)
AL_SetFormat (xALP_TablaFaltasMin;4;"##0";2;0;0;0)
AL_SetHdrStyle (xALP_TablaFaltasMin;4;"Arial";9;1)
AL_SetFtrStyle (xALP_TablaFaltasMin;4;"Arial";9;0)
AL_SetStyle (xALP_TablaFaltasMin;4;"Arial";9;0)
AL_SetForeColor (xALP_TablaFaltasMin;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_TablaFaltasMin;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_TablaFaltasMin;4;1)
AL_SetEntryCtls (xALP_TablaFaltasMin;4;0)

  //general options

AL_SetFilter (xALP_TablaFaltasMin;2;"&9")
AL_SetFilter (xALP_TablaFaltasMin;3;"&9")
AL_SetFilter (xALP_TablaFaltasMin;4;"&9")
AL_SetEnterable (xALP_TablaFaltasMin;1;0)
AL_SetEnterable (xALP_TablaFaltasMin;2;1)
AL_SetEnterable (xALP_TablaFaltasMin;3;1)
AL_SetEnterable (xALP_TablaFaltasMin;4;0)

AL_SetColOpts (xALP_TablaFaltasMin;1;1;1;0;0)
AL_SetRowOpts (xALP_TablaFaltasMin;0;1;0;0;1;0)
AL_SetCellOpts (xALP_TablaFaltasMin;0;1;1)
AL_SetMiscOpts (xALP_TablaFaltasMin;0;0;"\\";0;1)
AL_SetMainCalls (xALP_TablaFaltasMin;"";"")
AL_SetCallbacks (xALP_TablaFaltasMin;"";"xALCB_EX_TablaAtrasos")
AL_SetScroll (xALP_TablaFaltasMin;0;0)
AL_SetCopyOpts (xALP_TablaFaltasMin;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_TablaFaltasMin;0;0)
AL_SetEntryOpts (xALP_TablaFaltasMin;3;0;0;0;0;".")
AL_SetDrgOpts (xALP_TablaFaltasMin;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_TablaFaltasMin;1;"";"";"")
AL_SetDrgSrc (xALP_TablaFaltasMin;2;"";"";"")
AL_SetDrgSrc (xALP_TablaFaltasMin;3;"";"";"")
AL_SetDrgDst (xALP_TablaFaltasMin;1;"";"";"")
AL_SetDrgDst (xALP_TablaFaltasMin;1;"";"";"")
AL_SetDrgDst (xALP_TablaFaltasMin;1;"";"";"")

ALP_SetDefaultAppareance (xALP_TablaFaltasMin;9;1;6;1;8)