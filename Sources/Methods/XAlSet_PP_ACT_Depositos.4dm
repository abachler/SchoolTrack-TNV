//%attributes = {}
  //XAlSet_PP_ACT_Depositos

ARRAY LONGINT:C221(aACT_ApdosDDID;0)
ARRAY DATE:C224(aACT_ApdosDDFechaDoc;0)
ARRAY TEXT:C222(aACT_ApdosDDNumeroDoc;0)
ARRAY TEXT:C222(aACT_ApdosDDBancoDoc;0)
ARRAY TEXT:C222(aACT_ApdosDDTipoDcto;0)
ARRAY REAL:C219(aACT_ApdosDDMontoDoc;0)
C_LONGINT:C283($Error)
AL_RemoveArrays (xALP_DocsDepositados;1;5)
  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_DocsDepositados;1;1;"aACT_ApdosDDTipoDcto")
$Error:=AL_SetArraysNam (xALP_DocsDepositados;2;1;"aACT_ApdosDDFechaDoc")
$Error:=AL_SetArraysNam (xALP_DocsDepositados;3;1;"aACT_ApdosDDNumeroDoc")
$Error:=AL_SetArraysNam (xALP_DocsDepositados;4;1;"aACT_ApdosDDBancoDoc")
$Error:=AL_SetArraysNam (xALP_DocsDepositados;5;1;"aACT_ApdosDDMontoDoc")
$Error:=AL_SetArraysNam (xALP_DocsDepositados;6;1;"aACT_ApdosDDID")

  //column 1 settings
AL_SetHeaders (xALP_DocsDepositados;1;1;__ ("Tipo documento"))
AL_SetFormat (xALP_DocsDepositados;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_DocsDepositados;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsDepositados;1;"Tahoma";9;0)
AL_SetStyle (xALP_DocsDepositados;1;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsDepositados;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsDepositados;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsDepositados;1;1)
AL_SetEntryCtls (xALP_DocsDepositados;1;0)

  //column 2 settings
AL_SetHeaders (xALP_DocsDepositados;2;1;__ ("Fecha"))
AL_SetFormat (xALP_DocsDepositados;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_DocsDepositados;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsDepositados;2;"Tahoma";9;0)
AL_SetStyle (xALP_DocsDepositados;2;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsDepositados;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsDepositados;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsDepositados;2;1)
AL_SetEntryCtls (xALP_DocsDepositados;2;0)

  //column 3 settings
AL_SetHeaders (xALP_DocsDepositados;3;1;__ ("Nº de Serie"))
AL_SetFormat (xALP_DocsDepositados;3;"";0;2;0;0)
AL_SetHdrStyle (xALP_DocsDepositados;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsDepositados;3;"Tahoma";9;0)
AL_SetStyle (xALP_DocsDepositados;3;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsDepositados;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsDepositados;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsDepositados;3;1)
AL_SetEntryCtls (xALP_DocsDepositados;3;0)

  //column 4 settings
AL_SetHeaders (xALP_DocsDepositados;4;1;__ ("Banco"))
AL_SetFormat (xALP_DocsDepositados;4;"";0;2;0;0)
AL_SetHdrStyle (xALP_DocsDepositados;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsDepositados;4;"Tahoma";9;0)
AL_SetStyle (xALP_DocsDepositados;4;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsDepositados;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsDepositados;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsDepositados;4;1)
AL_SetEntryCtls (xALP_DocsDepositados;4;0)

  //column 5 settings
AL_SetHeaders (xALP_DocsDepositados;5;1;__ ("Monto"))
AL_SetFormat (xALP_DocsDepositados;5;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_DocsDepositados;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsDepositados;5;"Tahoma";9;0)
AL_SetStyle (xALP_DocsDepositados;5;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsDepositados;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsDepositados;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsDepositados;5;1)
AL_SetEntryCtls (xALP_DocsDepositados;5;0)

  //column 6 settings
AL_SetHeaders (xALP_DocsDepositados;6;1;"ID")
AL_SetFormat (xALP_DocsDepositados;6;"";0;2;0;0)
AL_SetHdrStyle (xALP_DocsDepositados;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsDepositados;6;"Tahoma";9;0)
AL_SetStyle (xALP_DocsDepositados;6;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsDepositados;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsDepositados;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsDepositados;6;1)
AL_SetEntryCtls (xALP_DocsDepositados;6;0)

AL_SetWidths (xALP_DocsDepositados;1;5;100;80;80;409;80)

  //general options
ALP_SetDefaultAppareance (xALP_DocsDepositados;9;1;6;1;8)
AL_SetColOpts (xALP_DocsDepositados;1;1;1;1;0)
AL_SetRowOpts (xALP_DocsDepositados;0;1;0;0;1;0)
AL_SetCellOpts (xALP_DocsDepositados;0;1;1)
AL_SetMiscOpts (xALP_DocsDepositados;0;0;"\\";0;1)
AL_SetMainCalls (xALP_DocsDepositados;"";"")
AL_SetScroll (xALP_DocsDepositados;0;0)
AL_SetEntryOpts (xALP_DocsDepositados;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_DocsDepositados;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_DocsDepositados;1;"";"";"")
AL_SetDrgSrc (xALP_DocsDepositados;2;"";"";"")
AL_SetDrgSrc (xALP_DocsDepositados;3;"";"";"")
AL_SetDrgDst (xALP_DocsDepositados;1;"";"";"")
AL_SetDrgDst (xALP_DocsDepositados;1;"";"";"")
AL_SetDrgDst (xALP_DocsDepositados;1;"";"";"")

