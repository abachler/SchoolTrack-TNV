//%attributes = {}
  //XAlSet_PP_Depositos

  //Configuration commands for ALP object 'xALP_DocsDepositados'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_DocsDepositados;1;1;"aACT_ApdosDDFechaDoc")
$Error:=AL_SetArraysNam (xALP_DocsDepositados;2;1;"aACT_ApdosDDNumeroDoc")
$Error:=AL_SetArraysNam (xALP_DocsDepositados;3;1;"aACT_ApdosDDMontoDoc")
$Error:=AL_SetArraysNam (xALP_DocsDepositados;4;1;"aACT_ApdosDDID")

  //column 1 settings
AL_SetHeaders (xALP_DocsDepositados;1;1;__ ("Fecha"))
AL_SetFormat (xALP_DocsDepositados;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsDepositados;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsDepositados;1;"Tahoma";9;0)
AL_SetStyle (xALP_DocsDepositados;1;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsDepositados;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsDepositados;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsDepositados;1;1)
AL_SetEntryCtls (xALP_DocsDepositados;1;0)

  //column 2 settings
AL_SetHeaders (xALP_DocsDepositados;2;1;__ ("Número"))
AL_SetFormat (xALP_DocsDepositados;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsDepositados;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsDepositados;2;"Tahoma";9;0)
AL_SetStyle (xALP_DocsDepositados;2;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsDepositados;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsDepositados;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsDepositados;2;1)
AL_SetEntryCtls (xALP_DocsDepositados;2;0)

  //column 3 settings
AL_SetHeaders (xALP_DocsDepositados;3;1;__ ("Monto"))
AL_SetFormat (xALP_DocsDepositados;3;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_DocsDepositados;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsDepositados;3;"Tahoma";9;0)
AL_SetStyle (xALP_DocsDepositados;3;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsDepositados;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsDepositados;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsDepositados;3;1)
AL_SetEntryCtls (xALP_DocsDepositados;3;0)

  //column 4 settings
AL_SetHeaders (xALP_DocsDepositados;4;1;__ ("ID"))
AL_SetFormat (xALP_DocsDepositados;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_DocsDepositados;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsDepositados;4;"Tahoma";9;0)
AL_SetStyle (xALP_DocsDepositados;4;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsDepositados;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsDepositados;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsDepositados;4;1)
AL_SetEntryCtls (xALP_DocsDepositados;4;0)

  //general options

AL_SetColOpts (xALP_DocsDepositados;1;1;1;1;0)
AL_SetRowOpts (xALP_DocsDepositados;0;1;0;0;1;0)
AL_SetCellOpts (xALP_DocsDepositados;0;1;1)
AL_SetMiscOpts (xALP_DocsDepositados;0;0;"\\";0;1)
AL_SetMiscColor (xALP_DocsDepositados;0;"White";0)
AL_SetMiscColor (xALP_DocsDepositados;1;"White";0)
AL_SetMiscColor (xALP_DocsDepositados;2;"White";0)
AL_SetMiscColor (xALP_DocsDepositados;3;"White";0)
AL_SetMainCalls (xALP_DocsDepositados;"";"")
AL_SetScroll (xALP_DocsDepositados;0;0)
AL_SetCopyOpts (xALP_DocsDepositados;0;"\t";"\r")
AL_SetSortOpts (xALP_DocsDepositados;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_DocsDepositados;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_DocsDepositados;1;2;1;1;2)
AL_SetDividers (xALP_DocsDepositados;"Gray";"Black";0;"Gray";"Black";0)
AL_SetDrgOpts (xALP_DocsDepositados;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_DocsDepositados;1;"";"";"")
AL_SetDrgSrc (xALP_DocsDepositados;2;"";"";"")
AL_SetDrgSrc (xALP_DocsDepositados;3;"";"";"")
AL_SetDrgDst (xALP_DocsDepositados;1;"";"";"")
AL_SetDrgDst (xALP_DocsDepositados;1;"";"";"")
AL_SetDrgDst (xALP_DocsDepositados;1;"";"";"")

