//%attributes = {}
  //xALSet_ACT_ConfigIPC

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_IPC;1;1;"atACT_MesIPC")
$Error:=AL_SetArraysNam (xALP_IPC;2;1;"arACT_VariacionIPC")
$Error:=AL_SetArraysNam (xALP_IPC;3;1;"arACT_UFReferencia")

  //column 1 settings
AL_SetHeaders (xALP_IPC;1;1;__ ("Mes"))
AL_SetWidths (xALP_IPC;1;1;60)
AL_SetFormat (xALP_IPC;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_IPC;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_IPC;1;"Tahoma";9;0)
AL_SetStyle (xALP_IPC;1;"Tahoma";9;0)
AL_SetForeColor (xALP_IPC;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_IPC;1;"White";0;"white";0;"White";0)
AL_SetEnterable (xALP_IPC;1;0)
AL_SetEntryCtls (xALP_IPC;1;0)

  //column 2 settings
AL_SetHeaders (xALP_IPC;2;1;"+/-")
AL_SetWidths (xALP_IPC;2;1;39)
AL_SetFormat (xALP_IPC;2;"|Pct_1Dec";0;2;0;0)
AL_SetHdrStyle (xALP_IPC;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_IPC;2;"Tahoma";9;0)
AL_SetStyle (xALP_IPC;2;"Tahoma";9;0)
AL_SetForeColor (xALP_IPC;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_IPC;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_IPC;2;1)
AL_SetEntryCtls (xALP_IPC;2;0)

  //column 3 settings
AL_SetHeaders (xALP_IPC;3;1;__ ("UF ref"))
AL_SetWidths (xALP_IPC;3;1;59)
AL_SetFormat (xALP_IPC;3;"|Real_2Dec";0;2;0;0)
AL_SetHdrStyle (xALP_IPC;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_IPC;3;"Tahoma";9;0)
AL_SetStyle (xALP_IPC;3;"Tahoma";9;0)
AL_SetForeColor (xALP_IPC;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_IPC;3;"White";0;"white";0;"White";0)
AL_SetEnterable (xALP_IPC;3;0)
AL_SetEntryCtls (xALP_IPC;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_IPC;9;1;6;1;8)
AL_SetColOpts (xALP_IPC;1;1;1;0;0)
AL_SetRowOpts (xALP_IPC;0;0;0;0;1;0)
AL_SetCellOpts (xALP_IPC;0;1;1)
AL_SetMainCalls (xALP_IPC;"";"")
AL_SetCallbacks (xALP_IPC;"";"xALP_CB_ACT_IPC")
AL_SetScroll (xALP_IPC;0;-3)
AL_SetEntryOpts (xALP_IPC;3;0;0;1;2;",")
AL_SetDrgOpts (xALP_IPC;0;30;0)
AL_SetSortOpts (xALP_IPC;0;0;0;"Seleccione las columnas a ordenar:";0;1)

  //dragging options

AL_SetDrgSrc (xALP_IPC;1;"";"";"")
AL_SetDrgSrc (xALP_IPC;2;"";"";"")
AL_SetDrgSrc (xALP_IPC;3;"";"";"")
AL_SetDrgDst (xALP_IPC;1;"";"";"")
AL_SetDrgDst (xALP_IPC;1;"";"";"")
AL_SetDrgDst (xALP_IPC;1;"";"";"")

