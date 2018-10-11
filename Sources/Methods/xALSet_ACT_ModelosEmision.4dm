//%attributes = {}
  //xALSet_ACT_ModelosEmision

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_SelModeloAviso;1;1;"apACT_ModeloSel")
$Error:=AL_SetArraysNam (xALP_SelModeloAviso;2;1;"atACT_ModelosAviso")
$Error:=AL_SetArraysNam (xALP_SelModeloAviso;3;1;"abACT_ModeloSel")
$Error:=AL_SetArraysNam (xALP_SelModeloAviso;4;1;"abACT_ModeloID")

  //column 1 settings
AL_SetHeaders (xALP_SelModeloAviso;1;1;"")
AL_SetFormat (xALP_SelModeloAviso;1;"1";0;0;0;0)
AL_SetWidths (xALP_SelModeloAviso;1;1;15)
AL_SetHdrStyle (xALP_SelModeloAviso;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelModeloAviso;1;"Tahoma";9;0)
AL_SetStyle (xALP_SelModeloAviso;1;"Tahoma";9;0)
AL_SetForeColor (xALP_SelModeloAviso;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelModeloAviso;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelModeloAviso;1;0)
AL_SetEntryCtls (xALP_SelModeloAviso;1;0)

  //column 2 settings
AL_SetHeaders (xALP_SelModeloAviso;2;1;__ ("Modelo"))
AL_SetFormat (xALP_SelModeloAviso;2;"";0;0;0;0)
AL_SetWidths (xALP_SelModeloAviso;2;1;400)
AL_SetHdrStyle (xALP_SelModeloAviso;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelModeloAviso;2;"Tahoma";9;0)
AL_SetStyle (xALP_SelModeloAviso;2;"Tahoma";9;0)
AL_SetForeColor (xALP_SelModeloAviso;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelModeloAviso;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelModeloAviso;2;0)
AL_SetEntryCtls (xALP_SelModeloAviso;2;0)

  //column 3 settings
AL_SetHeaders (xALP_SelModeloAviso;3;1;"")
AL_SetFormat (xALP_SelModeloAviso;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_SelModeloAviso;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelModeloAviso;3;"Tahoma";9;0)
AL_SetStyle (xALP_SelModeloAviso;3;"Tahoma";9;0)
AL_SetForeColor (xALP_SelModeloAviso;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelModeloAviso;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelModeloAviso;3;1)
AL_SetEntryCtls (xALP_SelModeloAviso;3;0)

  //column4 settings
AL_SetHeaders (xALP_SelModeloAviso;4;1;"")
AL_SetFormat (xALP_SelModeloAviso;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_SelModeloAviso;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelModeloAviso;4;"Tahoma";9;0)
AL_SetStyle (xALP_SelModeloAviso;4;"Tahoma";9;0)
AL_SetForeColor (xALP_SelModeloAviso;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelModeloAviso;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelModeloAviso;4;1)
AL_SetEntryCtls (xALP_SelModeloAviso;4;0)

  //general options
ALP_SetDefaultAppareance (xALP_SelModeloAviso;9;1;6;1;8)
AL_SetColOpts (xALP_SelModeloAviso;0;1;1;2;0)
AL_SetRowOpts (xALP_SelModeloAviso;0;0;0;0;1;1)
AL_SetCellOpts (xALP_SelModeloAviso;0;1;1)
AL_SetMiscOpts (xALP_SelModeloAviso;0;0;"\\";0;1)
AL_SetMainCalls (xALP_SelModeloAviso;"";"")
AL_SetScroll (xALP_SelModeloAviso;0;-3)
AL_SetEntryOpts (xALP_SelModeloAviso;0;0;0;0;0;".")
AL_SetDrgOpts (xALP_SelModeloAviso;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_SelModeloAviso;1;"";"";"")
AL_SetDrgSrc (xALP_SelModeloAviso;2;"";"";"")
AL_SetDrgSrc (xALP_SelModeloAviso;3;"";"";"")
AL_SetDrgDst (xALP_SelModeloAviso;1;"";"";"")
AL_SetDrgDst (xALP_SelModeloAviso;1;"";"";"")
AL_SetDrgDst (xALP_SelModeloAviso;1;"";"";"")