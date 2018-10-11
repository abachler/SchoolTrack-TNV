//%attributes = {}
  //xALPSet_ACT_CargosAviso

AL_RemoveArrays (ALP_CargosXPagar;1;14)

  //specify arrays to display
$Error:=AL_SetArraysNam (ALP_CargosXPagar;1;1;"adACT_CFechaEmision")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;2;1;"adACT_CFechaVencimiento")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;3;1;"atACT_CAlumno")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;4;1;"atACT_CGlosa")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;5;1;"atACT_MonedaSimbolo")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;6;1;"arACT_CMontoNeto")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;7;1;"arACT_CIntereses")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;8;1;"arACT_CSaldo")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;9;1;"alACT_RecNumsCargos")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;10;1;"alACT_CRefs")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;11;1;"alACT_CIDCtaCte")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;12;1;"asACT_Marcas")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;13;1;"atACT_MonedaCargo")
$Error:=AL_SetArraysNam (ALP_CargosXPagar;14;1;"arACT_MontoMoneda")

  //column 1 settings
AL_SetHeaders (ALP_CargosXPagar;1;1;"Emisión")
AL_SetFormat (ALP_CargosXPagar;1;"";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;1;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;1;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;1;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;1;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;1;0)
AL_SetEntryCtls (ALP_CargosXPagar;1;0)

  //column 2 settings
AL_SetHeaders (ALP_CargosXPagar;2;1;"Vencimiento")
AL_SetFormat (ALP_CargosXPagar;2;"";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;2;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;2;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;2;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;2;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;2;0)
AL_SetEntryCtls (ALP_CargosXPagar;2;0)

  //column 3 settings
AL_SetHeaders (ALP_CargosXPagar;3;1;"Alumno")
AL_SetFormat (ALP_CargosXPagar;3;"";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;3;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;3;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;3;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;3;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;3;0)
AL_SetEntryCtls (ALP_CargosXPagar;3;0)

  //column 4 settings
AL_SetHeaders (ALP_CargosXPagar;4;1;"Glosa")
AL_SetFormat (ALP_CargosXPagar;4;"";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;4;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;4;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;4;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;4;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;4;0)
AL_SetEntryCtls (ALP_CargosXPagar;4;0)

  //column 5 settings
AL_SetHeaders (ALP_CargosXPagar;5;1;"Monto Moneda")
AL_SetFormat (ALP_CargosXPagar;5;"|Despliegue_ACT";3;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;5;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;5;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;5;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;5;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;5;0)
AL_SetEntryCtls (ALP_CargosXPagar;5;0)

  //column 6 settings
AL_SetHeaders (ALP_CargosXPagar;6;1;"Monto Neto")
AL_SetFormat (ALP_CargosXPagar;6;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;6;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;6;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;6;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;6;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;6;0)
AL_SetEntryCtls (ALP_CargosXPagar;6;0)

  //column 7 settings
AL_SetHeaders (ALP_CargosXPagar;7;1;"Intereses")
AL_SetFormat (ALP_CargosXPagar;7;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;7;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;7;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;7;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;7;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;7;0)
AL_SetEntryCtls (ALP_CargosXPagar;7;0)

  //column 8 settings
AL_SetHeaders (ALP_CargosXPagar;8;1;"Saldo")
AL_SetFormat (ALP_CargosXPagar;8;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;8;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;8;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;8;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;8;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;8;0)
AL_SetEntryCtls (ALP_CargosXPagar;8;0)

  //column 9 settings
AL_SetHeaders (ALP_CargosXPagar;9;1;"RecNums")
AL_SetFormat (ALP_CargosXPagar;9;"###.###.###";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;9;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;9;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;9;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;9;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;9;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;9;0)
AL_SetEntryCtls (ALP_CargosXPagar;9;0)

  //column 10 settings
AL_SetHeaders (ALP_CargosXPagar;10;1;"RefItem")
AL_SetFormat (ALP_CargosXPagar;10;"###.###.###";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;10;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;10;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;10;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;10;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;10;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;10;0)
AL_SetEntryCtls (ALP_CargosXPagar;10;0)

  //column 11 settings
AL_SetHeaders (ALP_CargosXPagar;11;1;"ID Cta Cte")
AL_SetFormat (ALP_CargosXPagar;11;"###.###.###";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;11;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;11;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;11;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;11;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;11;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;11;0)
AL_SetEntryCtls (ALP_CargosXPagar;11;0)

  //column 12 settings
AL_SetHeaders (ALP_CargosXPagar;12;1;"Marcas")
AL_SetFormat (ALP_CargosXPagar;12;"###.###.###";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;12;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;12;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;12;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;12;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;12;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;12;0)
AL_SetEntryCtls (ALP_CargosXPagar;12;0)

  //column 13 settings
AL_SetHeaders (ALP_CargosXPagar;13;1;"Moneda")
AL_SetFormat (ALP_CargosXPagar;13;"###.###.###";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;13;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;13;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;13;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;13;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;13;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;13;0)
AL_SetEntryCtls (ALP_CargosXPagar;13;0)

  //column 14 settings
AL_SetHeaders (ALP_CargosXPagar;14;1;"Monto Moneda")
AL_SetFormat (ALP_CargosXPagar;14;"###.###.###";0;2;0;0)
AL_SetHdrStyle (ALP_CargosXPagar;14;"Tahoma";9;1)
AL_SetFtrStyle (ALP_CargosXPagar;14;"Tahoma";9;0)
AL_SetStyle (ALP_CargosXPagar;14;"Tahoma";9;0)
AL_SetForeColor (ALP_CargosXPagar;14;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_CargosXPagar;14;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_CargosXPagar;14;0)
AL_SetEntryCtls (ALP_CargosXPagar;14;0)

AL_SetWidths (ALP_CargosXPagar;1;8;70;80;153;153;80;70;60;60)

  //general options
ALP_SetDefaultAppareance (ALP_CargosXPagar;9;1;6;1;8)
AL_SetColOpts (ALP_CargosXPagar;1;1;1;6;0)
AL_SetRowOpts (ALP_CargosXPagar;0;1;0;0;1;0)
AL_SetCellOpts (ALP_CargosXPagar;0;1;1)
AL_SetMainCalls (ALP_CargosXPagar;"";"")
AL_SetScroll (ALP_CargosXPagar;0;0)
AL_SetEntryOpts (ALP_CargosXPagar;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (ALP_CargosXPagar;0;30;0)

  //dragging options

AL_SetDrgSrc (ALP_CargosXPagar;1;"";"";"")
AL_SetDrgSrc (ALP_CargosXPagar;2;"";"";"")
AL_SetDrgSrc (ALP_CargosXPagar;3;"";"";"")
AL_SetDrgDst (ALP_CargosXPagar;1;"";"";"")
AL_SetDrgDst (ALP_CargosXPagar;1;"";"";"")
AL_SetDrgDst (ALP_CargosXPagar;1;"";"";"")