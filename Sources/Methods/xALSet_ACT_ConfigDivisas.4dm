//%attributes = {}
  //xALSet_ACT_ConfigDivisas

C_LONGINT:C283($Error)

  //specify arrays to display
AT_Inc (0)
$Error:=AL_SetArraysNam (xALP_Divisas;AT_Inc ;1;"atACT_NombreMoneda")
$Error:=AL_SetArraysNam (xALP_Divisas;AT_Inc ;1;"arACT_ValorMoneda")
$Error:=AL_SetArraysNam (xALP_Divisas;AT_Inc ;1;"atACT_SimboloMoneda")
$Error:=ALP_DefaultColSettings (xALP_Divisas;AT_Inc ;"apACT_GeneraTabla";__ ("Tabla de Paridad");55;"1")
$Error:=ALP_DefaultColSettings (xALP_Divisas;AT_Inc ;"apACT_PermitePago";__ ("Permite Pago");55;"1")
$Error:=ALP_DefaultColSettings (xALP_Divisas;AT_Inc ;"abACT_PermitePago";"";70;"0,######";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_Divisas;AT_Inc ;"abACT_GeneraTabla";"";70;"0,######";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_Divisas;AT_Inc ;"abACT_MonedaXDef";"";70;"0,######";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_Divisas;AT_Inc ;"alACT_IdRegistro";"";70;"0,######";0;0;1)


  //column 1 settings
AL_SetHeaders (xALP_Divisas;1;1;__ ("Moneda"))
AL_SetWidths (xALP_Divisas;1;1;90)
AL_SetFormat (xALP_Divisas;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_Divisas;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Divisas;1;"Tahoma";9;0)
AL_SetStyle (xALP_Divisas;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Divisas;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Divisas;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Divisas;1;1)
AL_SetEntryCtls (xALP_Divisas;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Divisas;2;1;__ ("Valor"))
AL_SetWidths (xALP_Divisas;2;1;66)
AL_SetFormat (xALP_Divisas;2;"|Real_4Dec";0;2;0;0)
AL_SetHdrStyle (xALP_Divisas;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Divisas;2;"Tahoma";9;0)
AL_SetStyle (xALP_Divisas;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Divisas;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Divisas;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Divisas;2;1)
AL_SetEntryCtls (xALP_Divisas;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Divisas;3;1;__ ("Símb."))
AL_SetWidths (xALP_Divisas;3;1;32)
AL_SetFormat (xALP_Divisas;3;"";0;2;0;0)
AL_SetHdrStyle (xALP_Divisas;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Divisas;3;"Tahoma";9;0)
AL_SetStyle (xALP_Divisas;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Divisas;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Divisas;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Divisas;3;1)
AL_SetEntryCtls (xALP_Divisas;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_Divisas;9;1;6;2;8)
AL_SetColOpts (xALP_Divisas;1;1;1;4;0)
AL_SetRowOpts (xALP_Divisas;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Divisas;0;1;1)
AL_SetMainCalls (xALP_Divisas;"";"")
AL_SetCallbacks (xALP_Divisas;"";"xALP_ACT_CB_Divisas")
AL_SetScroll (xALP_Divisas;0;-3)
AL_SetEntryOpts (xALP_Divisas;3;0;0;1;2;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Divisas;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Divisas;1;"";"";"")
AL_SetDrgSrc (xALP_Divisas;2;"";"";"")
AL_SetDrgSrc (xALP_Divisas;3;"";"";"")
AL_SetDrgDst (xALP_Divisas;1;"";"";"")
AL_SetDrgDst (xALP_Divisas;1;"";"";"")
AL_SetDrgDst (xALP_Divisas;1;"";"";"")

