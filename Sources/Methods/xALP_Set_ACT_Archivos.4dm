//%attributes = {}
  //xALP_Set_ACT_Archivos

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Archivos;1;1;"alACT_ABArchivoID")
$Error:=AL_SetArraysNam (xALP_Archivos;2;1;"atACT_ABArchivoNombre")
$Error:=AL_SetArraysNam (xALP_Archivos;3;1;"abACT_ABArchivoImpExp")
$Error:=AL_SetArraysNam (xALP_Archivos;4;1;"atACT_ABArchivoTipo")
$Error:=AL_SetArraysNam (xALP_Archivos;5;1;"atACT_ABArchivoBanco")

  //column 1 settings
AL_SetHeaders (xALP_Archivos;1;1;__ ("ID"))
AL_SetFormat (xALP_Archivos;1;"######")
AL_SetWidths (xALP_Archivos;1;1;30)
AL_SetHdrStyle (xALP_Archivos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Archivos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Archivos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Archivos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Archivos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Archivos;1;0)
AL_SetEntryCtls (xALP_Archivos;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Archivos;2;1;__ ("Nombre"))
AL_SetWidths (xALP_Archivos;2;1;200)
AL_SetHdrStyle (xALP_Archivos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Archivos;2;"Tahoma";9;0)
AL_SetStyle (xALP_Archivos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Archivos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Archivos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Archivos;2;0)
AL_SetEntryCtls (xALP_Archivos;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Archivos;3;1;__ ("Función"))
AL_SetWidths (xALP_Archivos;3;1;60)
AL_SetFormat (xALP_Archivos;3;__ ("Importación;Exportación");0;0;0;0)
AL_SetHdrStyle (xALP_Archivos;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Archivos;3;"Tahoma";9;0)
AL_SetStyle (xALP_Archivos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Archivos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Archivos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Archivos;3;0)
AL_SetEntryCtls (xALP_Archivos;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Archivos;4;1;__ ("Tipo"))
AL_SetWidths (xALP_Archivos;4;1;60)
AL_SetHdrStyle (xALP_Archivos;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Archivos;4;"Tahoma";9;0)
AL_SetStyle (xALP_Archivos;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Archivos;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Archivos;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Archivos;4;0)
AL_SetEntryCtls (xALP_Archivos;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Archivos;5;1;__ ("Banco"))
AL_SetWidths (xALP_Archivos;5;1;125)
AL_SetHdrStyle (xALP_Archivos;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Archivos;5;"Tahoma";9;0)
AL_SetStyle (xALP_Archivos;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Archivos;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Archivos;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Archivos;5;0)
AL_SetEntryCtls (xALP_Archivos;5;0)
  //AL_SetEnterable (xALP_Archivos;5;2;atACT_BankName)

  //general options
ALP_SetDefaultAppareance (xALP_Archivos;9;1;6;1;8)
AL_SetColOpts (xALP_Archivos;0;0;0;0;0)
AL_SetRowOpts (xALP_Archivos;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Archivos;0;1;1)
AL_SetMiscOpts (xALP_Archivos;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Archivos;"";"")
AL_SetScroll (xALP_Archivos;0;-3)
AL_SetEntryOpts (xALP_Archivos;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Archivos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Archivos;1;"";"";"")
AL_SetDrgSrc (xALP_Archivos;2;"";"";"")
AL_SetDrgSrc (xALP_Archivos;3;"";"";"")
AL_SetDrgDst (xALP_Archivos;1;"";"";"")
AL_SetDrgDst (xALP_Archivos;1;"";"";"")
AL_SetDrgDst (xALP_Archivos;1;"";"";"")