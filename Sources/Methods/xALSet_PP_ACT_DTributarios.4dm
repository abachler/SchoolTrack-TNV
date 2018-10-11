//%attributes = {}
  //xALSet_PP_ACT_DTributarios

ARRAY LONGINT:C221(alACT_ApdosDTNumero;0)
ARRAY TEXT:C222(atACT_ApdosDTTipo;0)
ARRAY TEXT:C222(atACT_ApdosDTEstado;0)
ARRAY DATE:C224(adACT_ApdosDTFecha;0)
ARRAY REAL:C219(arACT_ApdosDTMontoAfecto;0)
ARRAY REAL:C219(arACT_ApdosDTMontoIVA;0)
ARRAY REAL:C219(arACT_ApdosDTMontoTotal;0)
ARRAY LONGINT:C221(alACT_ApdosDTID;0)

AL_RemoveArrays (xALP_DocsTributarios;1;8)
  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_DocsTributarios;1;1;"alACT_ApdosDTNumero")
$Error:=AL_SetArraysNam (xALP_DocsTributarios;2;1;"atACT_ApdosDTTipo")
$Error:=AL_SetArraysNam (xALP_DocsTributarios;3;1;"atACT_ApdosDTEstado")
$Error:=AL_SetArraysNam (xALP_DocsTributarios;4;1;"adACT_ApdosDTFecha")
$Error:=AL_SetArraysNam (xALP_DocsTributarios;5;1;"arACT_ApdosDTMontoAfecto")
$Error:=AL_SetArraysNam (xALP_DocsTributarios;6;1;"arACT_ApdosDTMontoIVA")
$Error:=AL_SetArraysNam (xALP_DocsTributarios;7;1;"arACT_ApdosDTMontoTotal")
$Error:=AL_SetArraysNam (xALP_DocsTributarios;8;1;"alACT_ApdosDTID")

  //column 1 settings
AL_SetHeaders (xALP_DocsTributarios;1;1;__ ("Número"))
AL_SetFormat (xALP_DocsTributarios;1;"### ### ### ###";0;2;0;0)
AL_SetHdrStyle (xALP_DocsTributarios;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsTributarios;1;"Tahoma";9;0)
AL_SetStyle (xALP_DocsTributarios;1;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsTributarios;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsTributarios;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsTributarios;1;1)
AL_SetEntryCtls (xALP_DocsTributarios;1;0)

  //column 2 settings
AL_SetHeaders (xALP_DocsTributarios;2;1;__ ("Tipo"))
AL_SetHdrStyle (xALP_DocsTributarios;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsTributarios;2;"Tahoma";9;0)
AL_SetStyle (xALP_DocsTributarios;2;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsTributarios;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsTributarios;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsTributarios;2;1)
AL_SetEntryCtls (xALP_DocsTributarios;2;0)

  //column 3 settings
AL_SetHeaders (xALP_DocsTributarios;3;1;__ ("Estado"))
AL_SetHdrStyle (xALP_DocsTributarios;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsTributarios;3;"Tahoma";9;0)
AL_SetStyle (xALP_DocsTributarios;3;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsTributarios;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsTributarios;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsTributarios;3;1)
AL_SetEntryCtls (xALP_DocsTributarios;3;0)

  //column 4 settings
AL_SetHeaders (xALP_DocsTributarios;4;1;__ ("Fecha"))
AL_SetHdrStyle (xALP_DocsTributarios;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsTributarios;4;"Tahoma";9;0)
AL_SetStyle (xALP_DocsTributarios;4;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsTributarios;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsTributarios;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsTributarios;4;1)
AL_SetEntryCtls (xALP_DocsTributarios;4;0)

  //column 5 settings
AL_SetHeaders (xALP_DocsTributarios;5;1;__ ("Monto Afecto"))
AL_SetFormat (xALP_DocsTributarios;5;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_DocsTributarios;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsTributarios;5;"Tahoma";9;0)
AL_SetStyle (xALP_DocsTributarios;5;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsTributarios;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsTributarios;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsTributarios;5;1)
AL_SetEntryCtls (xALP_DocsTributarios;5;0)

  //column 6 settings
AL_SetHeaders (xALP_DocsTributarios;6;1;__ ("Monto IVA"))
AL_SetFormat (xALP_DocsTributarios;6;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_DocsTributarios;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsTributarios;6;"Tahoma";9;0)
AL_SetStyle (xALP_DocsTributarios;6;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsTributarios;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsTributarios;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsTributarios;6;1)
AL_SetEntryCtls (xALP_DocsTributarios;6;0)

  //column 7 settings
AL_SetHeaders (xALP_DocsTributarios;7;1;__ ("Monto Total"))
AL_SetFormat (xALP_DocsTributarios;7;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_DocsTributarios;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsTributarios;7;"Tahoma";9;0)
AL_SetStyle (xALP_DocsTributarios;7;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsTributarios;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsTributarios;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsTributarios;7;1)
AL_SetEntryCtls (xALP_DocsTributarios;7;0)

  //column 8 settings
AL_SetHeaders (xALP_DocsTributarios;8;1;__ ("ID"))
AL_SetFormat (xALP_DocsTributarios;8;"";0;2;0;0)
AL_SetHdrStyle (xALP_DocsTributarios;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsTributarios;8;"Tahoma";9;0)
AL_SetStyle (xALP_DocsTributarios;8;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsTributarios;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsTributarios;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsTributarios;8;1)
AL_SetEntryCtls (xALP_DocsTributarios;8;0)

AL_SetWidths (xALP_DocsTributarios;1;7;60;160;209;80;80;80;80)

  //general options
ALP_SetDefaultAppareance (xALP_DocsTributarios;9;1;6;1;8)
AL_SetColOpts (xALP_DocsTributarios;1;1;1;1;0)
AL_SetRowOpts (xALP_DocsTributarios;0;1;0;0;1;0)
AL_SetCellOpts (xALP_DocsTributarios;0;1;1)
AL_SetMiscOpts (xALP_DocsTributarios;0;0;"\\";0;1)
AL_SetMainCalls (xALP_DocsTributarios;"";"")
AL_SetScroll (xALP_DocsTributarios;0;0)
AL_SetEntryOpts (xALP_DocsTributarios;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_DocsTributarios;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_DocsTributarios;1;"";"";"")
AL_SetDrgSrc (xALP_DocsTributarios;2;"";"";"")
AL_SetDrgSrc (xALP_DocsTributarios;3;"";"";"")
AL_SetDrgDst (xALP_DocsTributarios;1;"";"";"")
AL_SetDrgDst (xALP_DocsTributarios;1;"";"";"")
AL_SetDrgDst (xALP_DocsTributarios;1;"";"";"")

