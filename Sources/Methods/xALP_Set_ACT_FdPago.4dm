//%attributes = {}
  //xALP_Set_ACT_FdPago

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_FormasdePago;1;1;"atACT_FormasdePagoNew")
$Error:=AL_SetArraysNam (xALP_FormasdePago;2;1;"atACT_FdPCodes")
$Error:=AL_SetArraysNam (xALP_FormasdePago;3;1;"atACT_FdPCtaContable")
$Error:=AL_SetArraysNam (xALP_FormasdePago;4;1;"atACT_FdPCtaCodAux")
$Error:=AL_SetArraysNam (xALP_FormasdePago;5;1;"atACT_FdPCentroCostos")
$Error:=AL_SetArraysNam (xALP_FormasdePago;6;1;"atACT_FdPCCtaContable")
$Error:=AL_SetArraysNam (xALP_FormasdePago;7;1;"atACT_FdPCCtaCodAux")
$Error:=AL_SetArraysNam (xALP_FormasdePago;8;1;"atACT_FdPCCentroCostos")
$Error:=AL_SetArraysNam (xALP_FormasdePago;9;1;"atACT_FdPCodInterno")
$Error:=AL_SetArraysNam (xALP_FormasdePago;10;1;"alACT_FormasdePagoID")
$Error:=AL_SetArraysNam (xALP_FormasdePago;11;1;"atACT_FormasdePago")

$error:=ALP_DefaultColSettings (xALP_FormasdePago;12;"alACT_idCtaFDP";"";1)
$error:=ALP_DefaultColSettings (xALP_FormasdePago;13;"alACT_idCentroFDP";"";1)
$error:=ALP_DefaultColSettings (xALP_FormasdePago;14;"alACT_idCCtaFDP";"";1)
$error:=ALP_DefaultColSettings (xALP_FormasdePago;15;"alACT_idCCentroFDP";"";1)


  //column 1 settings
AL_SetHeaders (xALP_FormasdePago;1;1;__ ("Forma de Pago"))
AL_SetFormat (xALP_FormasdePago;1;"";0;0;0;0)
AL_SetWidths (xALP_FormasdePago;1;1;124)
AL_SetHdrStyle (xALP_FormasdePago;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FormasdePago;1;"Tahoma";9;0)
AL_SetStyle (xALP_FormasdePago;1;"Tahoma";9;0)
AL_SetForeColor (xALP_FormasdePago;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FormasdePago;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FormasdePago;1;1)
AL_SetEntryCtls (xALP_FormasdePago;1;0)

  //column 2 settings
AL_SetHeaders (xALP_FormasdePago;2;1;__ ("Código de Ingreso"))
AL_SetFormat (xALP_FormasdePago;2;"";0;0;0;0)
AL_SetWidths (xALP_FormasdePago;2;1;55)
AL_SetHdrStyle (xALP_FormasdePago;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FormasdePago;2;"Tahoma";9;0)
AL_SetStyle (xALP_FormasdePago;2;"Tahoma";9;0)
AL_SetForeColor (xALP_FormasdePago;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FormasdePago;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FormasdePago;2;1)
AL_SetEntryCtls (xALP_FormasdePago;2;0)

  //column 3 settings
AL_SetHeaders (xALP_FormasdePago;3;1;__ ("Plan de Cuentas"))
AL_SetFormat (xALP_FormasdePago;3;"";0;0;0;0)
AL_SetWidths (xALP_FormasdePago;3;1;80)
AL_SetHdrStyle (xALP_FormasdePago;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FormasdePago;3;"Tahoma";9;0)
AL_SetStyle (xALP_FormasdePago;3;"Tahoma";9;0)
AL_SetForeColor (xALP_FormasdePago;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FormasdePago;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FormasdePago;3;0)
AL_SetEntryCtls (xALP_FormasdePago;3;0)

  //column 4 settings
AL_SetHeaders (xALP_FormasdePago;4;1;__ ("Código Auxiliar Cuenta"))
AL_SetWidths (xALP_FormasdePago;4;1;80)
AL_SetFormat (xALP_FormasdePago;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_FormasdePago;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FormasdePago;4;"Tahoma";9;0)
AL_SetStyle (xALP_FormasdePago;4;"Tahoma";9;0)
AL_SetForeColor (xALP_FormasdePago;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FormasdePago;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FormasdePago;4;0)
AL_SetEntryCtls (xALP_FormasdePago;4;0)

  //column 5 settings
AL_SetHeaders (xALP_FormasdePago;5;1;__ ("Centro de Costos"))
AL_SetWidths (xALP_FormasdePago;5;1;80)
AL_SetFormat (xALP_FormasdePago;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_FormasdePago;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FormasdePago;5;"Tahoma";9;0)
AL_SetStyle (xALP_FormasdePago;5;"Tahoma";9;0)
AL_SetForeColor (xALP_FormasdePago;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FormasdePago;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FormasdePago;5;0)
AL_SetEntryCtls (xALP_FormasdePago;5;0)

  //column 6 settings
AL_SetHeaders (xALP_FormasdePago;6;1;__ ("Plan de Cuentas Contra"))
AL_SetWidths (xALP_FormasdePago;6;1;80)
AL_SetFormat (xALP_FormasdePago;6;"";0;0;0;0)
AL_SetHdrStyle (xALP_FormasdePago;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FormasdePago;6;"Tahoma";9;0)
AL_SetStyle (xALP_FormasdePago;6;"Tahoma";9;0)
AL_SetForeColor (xALP_FormasdePago;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FormasdePago;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FormasdePago;6;0)
AL_SetEntryCtls (xALP_FormasdePago;6;0)

  //column 7 settings
AL_SetHeaders (xALP_FormasdePago;7;1;__ ("Código Auxiliar Cuenta Contra"))
AL_SetWidths (xALP_FormasdePago;7;1;80)
AL_SetFormat (xALP_FormasdePago;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_FormasdePago;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FormasdePago;7;"Tahoma";9;0)
AL_SetStyle (xALP_FormasdePago;7;"Tahoma";9;0)
AL_SetForeColor (xALP_FormasdePago;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FormasdePago;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FormasdePago;7;0)
AL_SetEntryCtls (xALP_FormasdePago;7;0)

  //column 8 settings
AL_SetHeaders (xALP_FormasdePago;8;1;__ ("Centro de Costos Contra"))
AL_SetWidths (xALP_FormasdePago;8;1;80)
AL_SetFormat (xALP_FormasdePago;8;"";0;0;0;0)
AL_SetHdrStyle (xALP_FormasdePago;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FormasdePago;8;"Tahoma";9;0)
AL_SetStyle (xALP_FormasdePago;8;"Tahoma";9;0)
AL_SetForeColor (xALP_FormasdePago;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FormasdePago;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FormasdePago;8;0)
AL_SetEntryCtls (xALP_FormasdePago;8;0)

  //column 9 settings
AL_SetHeaders (xALP_FormasdePago;9;1;__ ("Código Interno"))
AL_SetFormat (xALP_FormasdePago;9;"";0;0;0;0)
AL_SetWidths (xALP_FormasdePago;9;1;50)
AL_SetHdrStyle (xALP_FormasdePago;9;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FormasdePago;9;"Tahoma";9;0)
AL_SetStyle (xALP_FormasdePago;9;"Tahoma";9;0)
AL_SetForeColor (xALP_FormasdePago;9;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FormasdePago;9;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FormasdePago;9;1)
AL_SetEntryCtls (xALP_FormasdePago;9;0)

  //general options
ALP_SetDefaultAppareance (xALP_FormasdePago)
AL_SetColOpts (xALP_FormasdePago;1;1;1;6;0)
AL_SetRowOpts (xALP_FormasdePago;0;0;0;0;1;0)
AL_SetCellOpts (xALP_FormasdePago;0;1;1)
AL_SetMiscOpts (xALP_FormasdePago;0;0;"\\";0;1)
AL_SetCallbacks (xALP_FormasdePago;"";"xAL_ACT_CB_FdPago")
AL_SetMainCalls (xALP_FormasdePago;"";"")
AL_SetScroll (xALP_FormasdePago;0;-3)
AL_SetEntryOpts (xALP_FormasdePago;5;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_FormasdePago;0;30;0)
AL_SetSortOpts (xALP_FormasdePago;0;0;0;"Seleccione las columnas a ordenar:";0;1)

  //dragging options

AL_SetDrgSrc (xALP_FormasdePago;1;"";"";"")
AL_SetDrgSrc (xALP_FormasdePago;2;"";"";"")
AL_SetDrgSrc (xALP_FormasdePago;3;"";"";"")
AL_SetDrgDst (xALP_FormasdePago;1;"";"";"")
AL_SetDrgDst (xALP_FormasdePago;1;"";"";"")
AL_SetDrgDst (xALP_FormasdePago;1;"";"";"")

