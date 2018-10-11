//%attributes = {}
  //xALP_Set_ACT_Docs2Print

AL_RemoveArrays (xALP_Docs2Print;9)

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Docs2Print;1;1;"atCategorias")
$Error:=AL_SetArraysNam (xALP_Docs2Print;2;1;"atDocumentos2Print")
$Error:=AL_SetArraysNam (xALP_Docs2Print;3;1;"aDesdeDT")
$Error:=AL_SetArraysNam (xALP_Docs2Print;4;1;"aHastaDT")
$Error:=AL_SetArraysNam (xALP_Docs2Print;5;1;"alHowMany")
$Error:=AL_SetArraysNam (xALP_Docs2Print;6;1;"apDoPrint")
$Error:=AL_SetArraysNam (xALP_Docs2Print;7;1;"abDoPrint")
$error:=AL_SetArraysNam (xALP_Docs2Print;8;1;"aSetsDT")
$error:=AL_SetArraysNam (xALP_Docs2Print;9;1;"alIDDT")

  //column 1 settings
AL_SetHeaders (xALP_Docs2Print;1;1;__ ("Categoría"))
AL_SetFormat (xALP_Docs2Print;1;"";0;0;0;0)
AL_SetWidths (xALP_Docs2Print;1;1;80)
AL_SetHdrStyle (xALP_Docs2Print;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Docs2Print;1;"Tahoma";9;0)
AL_SetStyle (xALP_Docs2Print;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Docs2Print;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Docs2Print;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Docs2Print;1;0)
AL_SetEntryCtls (xALP_Docs2Print;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Docs2Print;2;1;__ ("Documento"))
AL_SetFormat (xALP_Docs2Print;2;"";0;0;0;0)
AL_SetWidths (xALP_Docs2Print;2;1;140)
AL_SetHdrStyle (xALP_Docs2Print;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Docs2Print;2;"Tahoma";9;0)
AL_SetStyle (xALP_Docs2Print;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Docs2Print;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Docs2Print;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Docs2Print;2;0)
AL_SetEntryCtls (xALP_Docs2Print;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Docs2Print;3;1;__ ("Desde"))
AL_SetFormat (xALP_Docs2Print;3;"#######";0;0;0;0)
AL_SetWidths (xALP_Docs2Print;3;1;50)
AL_SetHdrStyle (xALP_Docs2Print;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Docs2Print;3;"Tahoma";9;0)
AL_SetStyle (xALP_Docs2Print;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Docs2Print;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Docs2Print;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Docs2Print;3;0)
AL_SetEntryCtls (xALP_Docs2Print;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Docs2Print;4;1;__ ("Hasta"))
AL_SetFormat (xALP_Docs2Print;4;"#######";0;0;0;0)
AL_SetWidths (xALP_Docs2Print;4;1;50)
AL_SetHdrStyle (xALP_Docs2Print;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Docs2Print;4;"Tahoma";9;0)
AL_SetStyle (xALP_Docs2Print;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Docs2Print;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Docs2Print;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Docs2Print;4;0)
AL_SetEntryCtls (xALP_Docs2Print;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Docs2Print;5;1;__ ("Cuantos"))
AL_SetFormat (xALP_Docs2Print;5;"#######";0;0;0;0)
AL_SetWidths (xALP_Docs2Print;5;1;50)
AL_SetHdrStyle (xALP_Docs2Print;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Docs2Print;5;"Tahoma";9;0)
AL_SetStyle (xALP_Docs2Print;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Docs2Print;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Docs2Print;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Docs2Print;5;0)
AL_SetEntryCtls (xALP_Docs2Print;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Docs2Print;6;1;__ ("¿Imprimir?"))
AL_SetFormat (xALP_Docs2Print;6;"1";0;0;0;0)
AL_SetWidths (xALP_Docs2Print;6;1;59)
AL_SetHdrStyle (xALP_Docs2Print;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Docs2Print;6;"Tahoma";9;0)
AL_SetStyle (xALP_Docs2Print;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Docs2Print;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Docs2Print;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Docs2Print;6;0)
AL_SetEntryCtls (xALP_Docs2Print;6;0)

  //column 7 settings
AL_SetHeaders (xALP_Docs2Print;7;1;"")
AL_SetFormat (xALP_Docs2Print;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_Docs2Print;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Docs2Print;7;"Tahoma";9;0)
AL_SetStyle (xALP_Docs2Print;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Docs2Print;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Docs2Print;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Docs2Print;7;0)
AL_SetEntryCtls (xALP_Docs2Print;7;0)

  //column 8 settings
AL_SetHeaders (xALP_Docs2Print;8;1;"")
AL_SetFormat (xALP_Docs2Print;8;"";0;0;0;0)
AL_SetHdrStyle (xALP_Docs2Print;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Docs2Print;8;"Tahoma";9;0)
AL_SetStyle (xALP_Docs2Print;8;"Tahoma";9;0)
AL_SetForeColor (xALP_Docs2Print;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Docs2Print;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Docs2Print;8;0)
AL_SetEntryCtls (xALP_Docs2Print;8;0)

  //column 9 settings
AL_SetHeaders (xALP_Docs2Print;9;1;"")
AL_SetFormat (xALP_Docs2Print;9;"";0;0;0;0)
AL_SetHdrStyle (xALP_Docs2Print;9;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Docs2Print;9;"Tahoma";9;0)
AL_SetStyle (xALP_Docs2Print;9;"Tahoma";9;0)
AL_SetForeColor (xALP_Docs2Print;9;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Docs2Print;9;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Docs2Print;9;0)
AL_SetEntryCtls (xALP_Docs2Print;9;0)

  //general options
ALP_SetDefaultAppareance (xALP_Docs2Print;9;1;6;1;8)
AL_SetColOpts (xALP_Docs2Print;1;1;1;3;0)
AL_SetRowOpts (xALP_Docs2Print;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Docs2Print;0;1;1)
AL_SetMiscOpts (xALP_Docs2Print;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Docs2Print;"";"")
AL_SetScroll (xALP_Docs2Print;0;-3)
AL_SetEntryOpts (xALP_Docs2Print;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Docs2Print;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Docs2Print;1;"";"";"")
AL_SetDrgSrc (xALP_Docs2Print;2;"";"";"")
AL_SetDrgSrc (xALP_Docs2Print;3;"";"";"")
AL_SetDrgDst (xALP_Docs2Print;1;"";"";"")
AL_SetDrgDst (xALP_Docs2Print;1;"";"";"")
AL_SetDrgDst (xALP_Docs2Print;1;"";"";"")

