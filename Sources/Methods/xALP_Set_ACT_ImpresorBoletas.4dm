//%attributes = {}
  //xALP_Set_ACT_ImpresorBoletas

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (ALP_Originales;1;1;"atACT_CatBol")
$Error:=AL_SetArraysNam (ALP_Originales;2;1;"atACT_DocBol")
$Error:=AL_SetArraysNam (ALP_Originales;3;1;"alACT_DesdeBol")
$Error:=AL_SetArraysNam (ALP_Originales;4;1;"alACT_HastaBol")
$Error:=AL_SetArraysNam (ALP_Originales;5;1;"alACT_CuantasBol")
$Error:=AL_SetArraysNam (ALP_Originales;6;1;"apACT_PrintBol")
$Error:=AL_SetArraysNam (ALP_Originales;7;1;"abACT_PrintBol")

  //column 1 settings
AL_SetHeaders (ALP_Originales;1;1;__ ("Categoría"))
AL_SetFormat (ALP_Originales;1;"";0;0;0;0)
AL_SetHdrStyle (ALP_Originales;1;"tahoma";9;1)
AL_SetFtrStyle (ALP_Originales;1;"tahoma";9;0)
AL_SetStyle (ALP_Originales;1;"tahoma";9;0)
AL_SetForeColor (ALP_Originales;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_Originales;1;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_Originales;1;1)
AL_SetEntryCtls (ALP_Originales;1;0)

  //column 2 settings
AL_SetHeaders (ALP_Originales;2;1;__ ("Documento"))
AL_SetFormat (ALP_Originales;2;"";0;0;0;0)
AL_SetHdrStyle (ALP_Originales;2;"tahoma";9;1)
AL_SetFtrStyle (ALP_Originales;2;"tahoma";9;0)
AL_SetStyle (ALP_Originales;2;"tahoma";9;0)
AL_SetForeColor (ALP_Originales;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_Originales;2;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_Originales;2;1)
AL_SetEntryCtls (ALP_Originales;2;0)

  //column 3 settings
AL_SetHeaders (ALP_Originales;3;1;__ ("Desde"))
AL_SetFormat (ALP_Originales;3;"#######";0;0;0;0)
AL_SetHdrStyle (ALP_Originales;3;"tahoma";9;1)
AL_SetFtrStyle (ALP_Originales;3;"tahoma";9;0)
AL_SetStyle (ALP_Originales;3;"tahoma";9;0)
AL_SetForeColor (ALP_Originales;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_Originales;3;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_Originales;3;1)
AL_SetEntryCtls (ALP_Originales;3;0)

  //column 4 settings
AL_SetHeaders (ALP_Originales;4;1;__ ("Hasta"))
AL_SetFormat (ALP_Originales;4;"#######";0;0;0;0)
AL_SetHdrStyle (ALP_Originales;4;"tahoma";9;1)
AL_SetFtrStyle (ALP_Originales;4;"tahoma";9;0)
AL_SetStyle (ALP_Originales;4;"tahoma";9;0)
AL_SetForeColor (ALP_Originales;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_Originales;4;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_Originales;4;1)
AL_SetEntryCtls (ALP_Originales;4;0)

  //column 5 settings
AL_SetHeaders (ALP_Originales;5;1;__ ("Cuantas"))
AL_SetFormat (ALP_Originales;5;"#######";0;0;0;0)
AL_SetHdrStyle (ALP_Originales;5;"tahoma";9;1)
AL_SetFtrStyle (ALP_Originales;5;"tahoma";9;0)
AL_SetStyle (ALP_Originales;5;"tahoma";9;0)
AL_SetForeColor (ALP_Originales;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_Originales;5;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_Originales;5;1)
AL_SetEntryCtls (ALP_Originales;5;0)

  //column 6 settings
AL_SetHeaders (ALP_Originales;6;1;__ ("¿Imprimir?"))
AL_SetFormat (ALP_Originales;6;"1";0;0;0;0)
AL_SetHdrStyle (ALP_Originales;6;"tahoma";9;1)
AL_SetFtrStyle (ALP_Originales;6;"tahoma";9;0)
AL_SetStyle (ALP_Originales;6;"tahoma";9;0)
AL_SetForeColor (ALP_Originales;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_Originales;6;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_Originales;6;1)
AL_SetEntryCtls (ALP_Originales;6;0)

  //column 7 settings
AL_SetHeaders (ALP_Originales;7;1;"Column 7")
AL_SetFormat (ALP_Originales;7;"";0;0;0;0)
AL_SetHdrStyle (ALP_Originales;7;"tahoma";9;1)
AL_SetFtrStyle (ALP_Originales;7;"tahoma";9;0)
AL_SetStyle (ALP_Originales;7;"tahoma";9;0)
AL_SetForeColor (ALP_Originales;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_Originales;7;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_Originales;7;0)
AL_SetEntryCtls (ALP_Originales;7;0)

AL_SetWidths (ALP_Originales;1;6;116;116;43;43;50;63)

  //general options
ALP_SetDefaultAppareance (ALP_Originales;9;1;6;1;8)
AL_SetColOpts (ALP_Originales;1;1;1;1;0)
AL_SetRowOpts (ALP_Originales;0;1;0;0;1;1)
AL_SetCellOpts (ALP_Originales;0;1;1)
AL_SetMiscOpts (ALP_Originales;0;0;"\\";0;1)
AL_SetMainCalls (ALP_Originales;"";"")
AL_SetScroll (ALP_Originales;0;-3)
AL_SetEntryOpts (ALP_Originales;1;0;0;0;0;".")
AL_SetDrgOpts (ALP_Originales;0;30;0)

  //dragging options

AL_SetDrgSrc (ALP_Originales;1;"";"";"")
AL_SetDrgSrc (ALP_Originales;2;"";"";"")
AL_SetDrgSrc (ALP_Originales;3;"";"";"")
AL_SetDrgDst (ALP_Originales;1;"";"";"")
AL_SetDrgDst (ALP_Originales;1;"";"";"")
AL_SetDrgDst (ALP_Originales;1;"";"";"")

