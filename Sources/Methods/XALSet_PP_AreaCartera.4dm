//%attributes = {}
  //XALSet_PP_AreaCartera

  //Configuration commands for ALP object 'xALP_DocsenCartera'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

ARRAY LONGINT:C221(aACT_ApdosDCarID;0)
ARRAY LONGINT:C221(aACT_ApdosDCarIDDocPago;0)
ARRAY DATE:C224(aACT_ApdosDCarFechaDoc;0)
ARRAY TEXT:C222(aACT_ApdosDCarNumeroDoc;0)
ARRAY REAL:C219(aACT_ApdosDCarMontoDoc;0)
ARRAY TEXT:C222(aACT_ApdosDCarUbicacionDoc;0)
ARRAY TEXT:C222(aACT_ApdosDCarEstado;0)
ARRAY DATE:C224(aACT_ApdosDCarFechaVenc;0)
ARRAY DATE:C224(aACT_ApdosDCarProtestadoel;0)
ARRAY DATE:C224(aACT_ApdosDCarDepDesde;0)
ARRAY DATE:C224(aACT_ApdosDCarDepHasta;0)

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_DocsenCartera;1;1;"aACT_ApdosDCarFechaDoc")
$Error:=AL_SetArraysNam (xALP_DocsenCartera;2;1;"aACT_ApdosDCarNumeroDoc")
$Error:=AL_SetArraysNam (xALP_DocsenCartera;3;1;"aACT_ApdosDCarMontoDoc")
$Error:=AL_SetArraysNam (xALP_DocsenCartera;4;1;"aACT_ApdosDCarUbicacionDoc")
$Error:=AL_SetArraysNam (xALP_DocsenCartera;5;1;"aACT_ApdosDCarEstado")
$Error:=AL_SetArraysNam (xALP_DocsenCartera;6;1;"aACT_ApdosDCarFechaVenc")
$Error:=AL_SetArraysNam (xALP_DocsenCartera;7;1;"aACT_ApdosDCarProtestadoel")
$Error:=AL_SetArraysNam (xALP_DocsenCartera;8;1;"aACT_ApdosDCarDepDesde")
$Error:=AL_SetArraysNam (xALP_DocsenCartera;9;1;"aACT_ApdosDCarDepHasta")
$Error:=AL_SetArraysNam (xALP_DocsenCartera;10;1;"aACT_ApdosDCarID")
$Error:=AL_SetArraysNam (xALP_DocsenCartera;11;1;"aACT_ApdosDCarIDDocPago")

  //column 1 settings
AL_SetHeaders (xALP_DocsenCartera;1;1;__ ("Fecha"))
AL_SetFormat (xALP_DocsenCartera;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsenCartera;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsenCartera;1;"Tahoma";9;0)
AL_SetStyle (xALP_DocsenCartera;1;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsenCartera;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsenCartera;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsenCartera;1;1)
AL_SetEntryCtls (xALP_DocsenCartera;1;0)

  //column 2 settings
AL_SetHeaders (xALP_DocsenCartera;2;1;__ ("Número"))
AL_SetFormat (xALP_DocsenCartera;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsenCartera;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsenCartera;2;"Tahoma";9;0)
AL_SetStyle (xALP_DocsenCartera;2;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsenCartera;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsenCartera;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsenCartera;2;1)
AL_SetEntryCtls (xALP_DocsenCartera;2;0)

  //column 3 settings
AL_SetHeaders (xALP_DocsenCartera;3;1;__ ("Monto"))
AL_SetFormat (xALP_DocsenCartera;3;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_DocsenCartera;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsenCartera;3;"Tahoma";9;0)
AL_SetStyle (xALP_DocsenCartera;3;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsenCartera;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsenCartera;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsenCartera;3;1)
AL_SetEntryCtls (xALP_DocsenCartera;3;0)

  //column 4 settings
AL_SetHeaders (xALP_DocsenCartera;4;1;__ ("Ubicación"))
AL_SetFormat (xALP_DocsenCartera;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsenCartera;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsenCartera;4;"Tahoma";9;0)
AL_SetStyle (xALP_DocsenCartera;4;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsenCartera;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsenCartera;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsenCartera;4;1)
AL_SetEntryCtls (xALP_DocsenCartera;4;0)

  //column 5 settings
AL_SetHeaders (xALP_DocsenCartera;5;1;__ ("Estado"))
AL_SetFormat (xALP_DocsenCartera;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsenCartera;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsenCartera;5;"Tahoma";9;0)
AL_SetStyle (xALP_DocsenCartera;5;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsenCartera;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsenCartera;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsenCartera;5;1)
AL_SetEntryCtls (xALP_DocsenCartera;5;0)

  //column 6 settings
AL_SetHeaders (xALP_DocsenCartera;6;1;__ ("Fecha Vencimiento"))
AL_SetFormat (xALP_DocsenCartera;6;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsenCartera;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsenCartera;6;"Tahoma";9;0)
AL_SetStyle (xALP_DocsenCartera;6;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsenCartera;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsenCartera;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsenCartera;6;1)
AL_SetEntryCtls (xALP_DocsenCartera;6;0)

  //column 7 settings
AL_SetHeaders (xALP_DocsenCartera;7;1;__ ("Protestado el"))
AL_SetFormat (xALP_DocsenCartera;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsenCartera;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsenCartera;7;"Tahoma";9;0)
AL_SetStyle (xALP_DocsenCartera;7;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsenCartera;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsenCartera;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsenCartera;7;1)
AL_SetEntryCtls (xALP_DocsenCartera;7;0)

  //column 8 settings
AL_SetHeaders (xALP_DocsenCartera;8;1;__ ("Depositar desde"))
AL_SetFormat (xALP_DocsenCartera;8;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsenCartera;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsenCartera;8;"Tahoma";9;0)
AL_SetStyle (xALP_DocsenCartera;8;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsenCartera;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsenCartera;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsenCartera;8;1)
AL_SetEntryCtls (xALP_DocsenCartera;8;0)

  //column 9 settings
AL_SetHeaders (xALP_DocsenCartera;9;1;__ ("Depositar hasta"))
AL_SetFormat (xALP_DocsenCartera;9;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsenCartera;9;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsenCartera;9;"Tahoma";9;0)
AL_SetStyle (xALP_DocsenCartera;9;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsenCartera;9;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsenCartera;9;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsenCartera;9;1)
AL_SetEntryCtls (xALP_DocsenCartera;9;0)

  //column 10 settings
AL_SetHeaders (xALP_DocsenCartera;10;1;__ ("ID"))
AL_SetFormat (xALP_DocsenCartera;10;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsenCartera;10;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsenCartera;10;"Tahoma";9;0)
AL_SetStyle (xALP_DocsenCartera;10;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsenCartera;10;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsenCartera;10;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsenCartera;10;1)
AL_SetEntryCtls (xALP_DocsenCartera;10;0)

  //column 11 settings
AL_SetHeaders (xALP_DocsenCartera;11;1;"ID Doc Pago")
AL_SetFormat (xALP_DocsenCartera;11;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsenCartera;11;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsenCartera;11;"Tahoma";9;0)
AL_SetStyle (xALP_DocsenCartera;11;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsenCartera;11;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsenCartera;11;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsenCartera;11;1)
AL_SetEntryCtls (xALP_DocsenCartera;11;0)

  //general options

AL_SetColOpts (xALP_DocsenCartera;1;1;1;2;0)
AL_SetRowOpts (xALP_DocsenCartera;0;1;0;0;1;0)
AL_SetCellOpts (xALP_DocsenCartera;0;1;1)
AL_SetMiscOpts (xALP_DocsenCartera;0;0;"\\";0;1)
AL_SetMiscColor (xALP_DocsenCartera;0;"White";0)
AL_SetMiscColor (xALP_DocsenCartera;1;"White";0)
AL_SetMiscColor (xALP_DocsenCartera;2;"White";0)
AL_SetMiscColor (xALP_DocsenCartera;3;"White";0)
AL_SetMainCalls (xALP_DocsenCartera;"";"")
AL_SetScroll (xALP_DocsenCartera;0;0)
AL_SetCopyOpts (xALP_DocsenCartera;0;"\t";"\r")
AL_SetSortOpts (xALP_DocsenCartera;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_DocsenCartera;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_DocsenCartera;1;2;1;1;2)
AL_SetDividers (xALP_DocsenCartera;"Gray";"Black";0;"Gray";"Black";0)
AL_SetColLock (xALP_DocsenCartera;3)
AL_SetDrgOpts (xALP_DocsenCartera;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_DocsenCartera;1;"";"";"")
AL_SetDrgSrc (xALP_DocsenCartera;2;"";"";"")
AL_SetDrgSrc (xALP_DocsenCartera;3;"";"";"")
AL_SetDrgDst (xALP_DocsenCartera;1;"";"";"")
AL_SetDrgDst (xALP_DocsenCartera;1;"";"";"")
AL_SetDrgDst (xALP_DocsenCartera;1;"";"";"")

