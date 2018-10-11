//%attributes = {}
  //xALSet_ACT_ConfigItemsMatriz

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_ItemsMatriz;1;1;"alACT_IDItemMatriz")
$Error:=AL_SetArraysNam (xALP_ItemsMatriz;2;1;"atACT_GlosaItemMatriz")
$Error:=AL_SetArraysNam (xALP_ItemsMatriz;3;1;"apACT_AfectoItemMatriz")
$Error:=AL_SetArraysNam (xALP_ItemsMatriz;4;1;"arACT_AmountItemMatriz")
$Error:=AL_SetArraysNam (xALP_ItemsMatriz;5;1;"atACT_MonedaItemMatriz")
$Error:=AL_SetArraysNam (xALP_ItemsMatriz;6;1;"abACT_IsDiscountItemMatriz")
$Error:=AL_SetArraysNam (xALP_ItemsMatriz;7;1;"abACT_IsPercentItemMatriz")
$Error:=AL_SetArraysNam (xALP_ItemsMatriz;8;1;"abACT_esDescontable")
$Error:=AL_SetArraysNam (xALP_ItemsMatriz;9;1;"alACT_RecNumItems")
$Error:=AL_SetArraysNam (xALP_ItemsMatriz;10;1;"abACT_AfectoItemMatriz")

  //column 1 settings
AL_SetHeaders (xALP_ItemsMatriz;1;1;__ ("ID"))
AL_SetWidths (xALP_ItemsMatriz;1;1;30)
AL_SetFormat (xALP_ItemsMatriz;1;"#####0";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsMatriz;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsMatriz;1;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsMatriz;1;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsMatriz;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsMatriz;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsMatriz;1;1)
AL_SetEntryCtls (xALP_ItemsMatriz;1;0)

  //column 2 settings
AL_SetHeaders (xALP_ItemsMatriz;2;1;__ ("Glosa"))
AL_SetWidths (xALP_ItemsMatriz;2;1;180)
AL_SetFormat (xALP_ItemsMatriz;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsMatriz;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsMatriz;2;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsMatriz;2;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsMatriz;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsMatriz;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsMatriz;2;1)
AL_SetEntryCtls (xALP_ItemsMatriz;2;0)

  //column 3 settings
AL_SetHeaders (xALP_ItemsMatriz;3;1;__ ("Afecto a IVA"))
AL_SetWidths (xALP_ItemsMatriz;3;1;75)
AL_SetFormat (xALP_ItemsMatriz;3;"1";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsMatriz;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsMatriz;3;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsMatriz;3;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsMatriz;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsMatriz;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsMatriz;3;1)
AL_SetEntryCtls (xALP_ItemsMatriz;3;0)

  //column 4 settings
AL_SetHeaders (xALP_ItemsMatriz;4;1;__ ("Monto o %"))
AL_SetWidths (xALP_ItemsMatriz;4;1;70)
AL_SetFormat (xALP_ItemsMatriz;4;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsMatriz;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsMatriz;4;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsMatriz;4;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsMatriz;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsMatriz;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsMatriz;4;1)
AL_SetEntryCtls (xALP_ItemsMatriz;4;0)

  //column 5 settings
AL_SetHeaders (xALP_ItemsMatriz;5;1;__ ("Moneda"))
AL_SetWidths (xALP_ItemsMatriz;5;1;80)
AL_SetFormat (xALP_ItemsMatriz;5;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsMatriz;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsMatriz;5;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsMatriz;5;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsMatriz;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsMatriz;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsMatriz;5;1)
AL_SetEntryCtls (xALP_ItemsMatriz;5;0)

  //column 6 settings
AL_SetHeaders (xALP_ItemsMatriz;6;1;"Es descuento (hidden)")
AL_SetFormat (xALP_ItemsMatriz;6;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsMatriz;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsMatriz;6;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsMatriz;6;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsMatriz;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsMatriz;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsMatriz;6;1)
AL_SetEntryCtls (xALP_ItemsMatriz;6;0)

  //column 7 settings
AL_SetHeaders (xALP_ItemsMatriz;7;1;"Is Percent (hidden)")
AL_SetWidths (xALP_ItemsMatriz;7;1;30)
AL_SetFormat (xALP_ItemsMatriz;7;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsMatriz;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsMatriz;7;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsMatriz;7;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsMatriz;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsMatriz;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsMatriz;7;1)
AL_SetEntryCtls (xALP_ItemsMatriz;7;0)

  //column 8 settings
AL_SetHeaders (xALP_ItemsMatriz;8;1;"Descontable (hidden)")
AL_SetFormat (xALP_ItemsMatriz;8;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsMatriz;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsMatriz;8;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsMatriz;8;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsMatriz;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsMatriz;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsMatriz;8;1)
AL_SetEntryCtls (xALP_ItemsMatriz;8;0)

  //column 9 settings
AL_SetHeaders (xALP_ItemsMatriz;9;1;"RecNums (hidden)")
AL_SetFormat (xALP_ItemsMatriz;9;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsMatriz;9;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsMatriz;9;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsMatriz;9;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsMatriz;9;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsMatriz;9;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsMatriz;9;1)
AL_SetEntryCtls (xALP_ItemsMatriz;9;0)

  //column 10 settings
AL_SetHeaders (xALP_ItemsMatriz;10;1;"afecta")
AL_SetFormat (xALP_ItemsMatriz;10;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsMatriz;10;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsMatriz;10;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsMatriz;9;"Tahoma";10;0)
AL_SetForeColor (xALP_ItemsMatriz;10;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsMatriz;10;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsMatriz;10;1)
AL_SetEntryCtls (xALP_ItemsMatriz;10;0)

  //general options
ALP_SetDefaultAppareance (xALP_ItemsMatriz;9;1;6;1;8)
AL_SetColOpts (xALP_ItemsMatriz;1;1;1;5;0)
AL_SetRowOpts (xALP_ItemsMatriz;0;0;0;0;1;0)
AL_SetCellOpts (xALP_ItemsMatriz;0;1;1)
AL_SetMainCalls (xALP_ItemsMatriz;"";"")
AL_SetScroll (xALP_ItemsMatriz;0;-3)
AL_SetEntryOpts (xALP_ItemsMatriz;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_ItemsMatriz;0;30;0)
AL_SetSortOpts (xALP_ItemsMatriz;0;0;0;"Seleccione las columnas a ordenar:";0;1)

  //dragging options
AL_SetDrgSrc (xALP_ItemsMatriz;1;String:C10(xALP_ItemsMatriz))
AL_SetDrgDst (xALP_ItemsMatriz;1;String:C10(xALP_Items2);String:C10(xALP_ItemsMatriz))