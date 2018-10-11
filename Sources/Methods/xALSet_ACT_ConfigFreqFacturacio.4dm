//%attributes = {}
  //xALSet_ACT_ConfigFreqFacturacio

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_FreqFacturacion;1;1;"◊atACT_FreqFacturacion")
$Error:=AL_SetArraysNam (xALP_FreqFacturacion;2;1;"◊arACT_FreqDescuento")

  //column 1 settings
AL_SetHeaders (xALP_FreqFacturacion;1;1;"Frec. de facturacion")
AL_SetWidths (xALP_FreqFacturacion;1;1;132)
AL_SetFormat (xALP_FreqFacturacion;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_FreqFacturacion;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FreqFacturacion;1;"Tahoma";9;0)
AL_SetStyle (xALP_FreqFacturacion;1;"Tahoma";9;0)
AL_SetForeColor (xALP_FreqFacturacion;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FreqFacturacion;1;"White";0;"white";0;"White";0)
AL_SetEnterable (xALP_FreqFacturacion;1;0)
AL_SetEntryCtls (xALP_FreqFacturacion;1;0)

  //column 2 settings
AL_SetHeaders (xALP_FreqFacturacion;2;1;"% descuento")
AL_SetWidths (xALP_FreqFacturacion;2;1;80)
AL_SetFormat (xALP_FreqFacturacion;2;"#0,00%";0;2;0;0)
AL_SetHdrStyle (xALP_FreqFacturacion;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_FreqFacturacion;2;"Tahoma";9;0)
AL_SetStyle (xALP_FreqFacturacion;2;"Tahoma";9;0)
AL_SetForeColor (xALP_FreqFacturacion;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_FreqFacturacion;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_FreqFacturacion;2;1)
AL_SetEntryCtls (xALP_FreqFacturacion;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_FreqFacturacion;9;1;6;1;8)
AL_SetColOpts (xALP_FreqFacturacion;1;1;1;0;0)
AL_SetRowOpts (xALP_FreqFacturacion;0;0;0;0;1;0)
AL_SetCellOpts (xALP_FreqFacturacion;0;1;1)
AL_SetMainCalls (xALP_FreqFacturacion;"";"")
AL_SetScroll (xALP_FreqFacturacion;-3;-3)
AL_SetEntryOpts (xALP_FreqFacturacion;3;0;0;1;2;",")
AL_SetDrgOpts (xALP_FreqFacturacion;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_FreqFacturacion;1;"";"";"")
AL_SetDrgSrc (xALP_FreqFacturacion;2;"";"";"")
AL_SetDrgSrc (xALP_FreqFacturacion;3;"";"";"")
AL_SetDrgDst (xALP_FreqFacturacion;1;"";"";"")
AL_SetDrgDst (xALP_FreqFacturacion;1;"";"";"")
AL_SetDrgDst (xALP_FreqFacturacion;1;"";"";"")

