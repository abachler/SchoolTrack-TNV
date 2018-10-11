//%attributes = {}
  //xALP_Set_ADT_Cobros

C_LONGINT:C283($error)

$error:=AL_SetArraysNam (xALP_ItemsADTCdd;1;1;"atADT_Glosa")
$error:=AL_SetArraysNam (xALP_ItemsADTCdd;2;1;"atADT_Moneda")
$error:=AL_SetArraysNam (xALP_ItemsADTCdd;3;1;"arADT_Monto")
$error:=AL_SetArraysNam (xALP_ItemsADTCdd;4;1;"apADT_IVA")
$error:=AL_SetArraysNam (xALP_ItemsADTCdd;5;1;"abADT_IVA")
$error:=AL_SetArraysNam (xALP_ItemsADTCdd;6;1;"alADT_ID")

  //column 1 settings
AL_SetHeaders (xALP_ItemsADTCdd;1;1;__ ("Glosa"))
AL_SetWidths (xALP_ItemsADTCdd;1;1;150)
AL_SetFormat (xALP_ItemsADTCdd;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsADTCdd;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsADTCdd;1;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsADTCdd;1;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsADTCdd;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsADTCdd;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsADTCdd;1;1)
AL_SetEntryCtls (xALP_ItemsADTCdd;1;0)

  //column 2 settings
AL_SetHeaders (xALP_ItemsADTCdd;2;1;__ ("Moneda"))
AL_SetWidths (xALP_ItemsADTCdd;2;1;100)
AL_SetFormat (xALP_ItemsADTCdd;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_ItemsADTCdd;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsADTCdd;2;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsADTCdd;2;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsADTCdd;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsADTCdd;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsADTCdd;2;2;atACT_NombreMoneda)
AL_SetEntryCtls (xALP_ItemsADTCdd;2;0)

  //column 3 settings
AL_SetHeaders (xALP_ItemsADTCdd;3;1;__ ("Monto"))
AL_SetWidths (xALP_ItemsADTCdd;3;1;59)
$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
AL_SetFilter (xALP_ItemsADTCdd;3;$filter)
AL_SetFormat (xALP_ItemsADTCdd;3;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsADTCdd;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsADTCdd;3;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsADTCdd;3;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsADTCdd;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsADTCdd;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsADTCdd;3;1)
AL_SetEntryCtls (xALP_ItemsADTCdd;3;0)

  //column 4 settings
AL_SetHeaders (xALP_ItemsADTCdd;4;1;__ ("Afecto a IVA"))
AL_SetWidths (xALP_ItemsADTCdd;4;1;75)
AL_SetFormat (xALP_ItemsADTCdd;4;"1";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsADTCdd;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsADTCdd;4;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsADTCdd;4;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsADTCdd;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsADTCdd;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsADTCdd;4;0)
AL_SetEntryCtls (xALP_ItemsADTCdd;4;0)

  //general options
ALP_SetDefaultAppareance (xALP_ItemsADTCdd;9;1;6;1;8)
AL_SetColOpts (xALP_ItemsADTCdd;1;1;1;2;0)
AL_SetRowOpts (xALP_ItemsADTCdd;0;1;0;0;1;0)
AL_SetCellOpts (xALP_ItemsADTCdd;0;1;1)
AL_SetMainCalls (xALP_ItemsADTCdd;"";"")
AL_SetCallbacks (xALP_ItemsADTCdd;"";"xALP_ADT_CB_Cobros")
AL_SetScroll (xALP_ItemsADTCdd;0;-3)
AL_SetSortOpts (xALP_ItemsADTCdd;0;0;0;"Seleccione las columnas a ordenar:";0;1)
AL_SetEntryOpts (xALP_ItemsADTCdd;3;0;0;1;2;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_ItemsADTCdd;0;30;0)