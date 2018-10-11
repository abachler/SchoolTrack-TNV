//%attributes = {}
  //ACT_xALSet_DetalleDocApod

  //Configuration commands for ALP object 'xALP_DetalleDocumento'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify fields to display
$Error:=AL_SetFile (xALP_DetalleDocumento;Table:C252(->[ACT_Cargos:173]))  //[ACT_Cargos]
$Error:=AL_SetFields (xALP_DetalleDocumento;173;1;1;22)  //[ACT_Cargos]FechaEmision
$Error:=AL_SetFields (xALP_DetalleDocumento;173;2;1;12)  //[ACT_Cargos]Glosa
$Error:=AL_SetFields (xALP_DetalleDocumento;2;3;1;40)  //[Alumnos]Apellidos_y_Nombres
$Error:=AL_SetFields (xALP_DetalleDocumento;173;4;1;5)  //[ACT_Cargos]Monto_Neto
$Error:=AL_SetFields (xALP_DetalleDocumento;173;5;1;8)  //[ACT_Cargos]MontosPagados

  //column 1 settings
AL_SetHeaders (xALP_DetalleDocumento;1;1;__ ("Fecha de emisión"))
AL_SetWidths (xALP_DetalleDocumento;1;1;80)
AL_SetFormat (xALP_DetalleDocumento;1;"7";0;0;0;0)
AL_SetHdrStyle (xALP_DetalleDocumento;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DetalleDocumento;1;"Tahoma";9;0)
AL_SetStyle (xALP_DetalleDocumento;1;"Tahoma";9;0)
AL_SetForeColor (xALP_DetalleDocumento;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DetalleDocumento;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_DetalleDocumento;1;1)
AL_SetEntryCtls (xALP_DetalleDocumento;1;0)

  //column 2 settings
AL_SetHeaders (xALP_DetalleDocumento;2;1;__ ("Glosa"))
AL_SetWidths (xALP_DetalleDocumento;2;1;300)
AL_SetFormat (xALP_DetalleDocumento;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_DetalleDocumento;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DetalleDocumento;2;"Tahoma";9;0)
AL_SetStyle (xALP_DetalleDocumento;2;"Tahoma";9;0)
AL_SetForeColor (xALP_DetalleDocumento;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DetalleDocumento;2;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_DetalleDocumento;2;1)
AL_SetEntryCtls (xALP_DetalleDocumento;2;0)

  //column 3 settings
AL_SetHeaders (xALP_DetalleDocumento;3;1;__ ("Alumno"))
AL_SetWidths (xALP_DetalleDocumento;3;1;160)
AL_SetFormat (xALP_DetalleDocumento;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_DetalleDocumento;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DetalleDocumento;3;"Tahoma";9;0)
AL_SetStyle (xALP_DetalleDocumento;3;"Tahoma";9;0)
AL_SetForeColor (xALP_DetalleDocumento;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DetalleDocumento;3;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_DetalleDocumento;3;1)
AL_SetEntryCtls (xALP_DetalleDocumento;3;0)

  //column 4 settings
AL_SetCalcCall (xALP_DetalleDocumento;4;"xALP_CalcColumnACT_Trans")
AL_SetHeaders (xALP_DetalleDocumento;4;1;__ ("Monto"))
AL_SetWidths (xALP_DetalleDocumento;4;1;100)
AL_SetFormat (xALP_DetalleDocumento;4;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_DetalleDocumento;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DetalleDocumento;4;"Tahoma";9;0)
AL_SetStyle (xALP_DetalleDocumento;4;"Tahoma";9;0)
AL_SetForeColor (xALP_DetalleDocumento;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DetalleDocumento;4;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_DetalleDocumento;4;1)
AL_SetEntryCtls (xALP_DetalleDocumento;4;0)

  //column 5 settings
AL_SetHeaders (xALP_DetalleDocumento;5;1;__ ("Pagos"))
AL_SetWidths (xALP_DetalleDocumento;5;1;100)
AL_SetFormat (xALP_DetalleDocumento;5;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_DetalleDocumento;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DetalleDocumento;5;"Tahoma";9;0)
AL_SetStyle (xALP_DetalleDocumento;5;"Tahoma";9;0)
AL_SetForeColor (xALP_DetalleDocumento;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DetalleDocumento;5;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_DetalleDocumento;5;1)
AL_SetEntryCtls (xALP_DetalleDocumento;5;0)

  //general options

AL_SetColOpts (xALP_DetalleDocumento;1;1;1;0;0)
AL_SetRowOpts (xALP_DetalleDocumento;0;0;0;0;1;0)
AL_SetCellOpts (xALP_DetalleDocumento;0;1;1)
AL_SetMiscOpts (xALP_DetalleDocumento;0;0;"\\";0;1)
AL_SetMiscColor (xALP_DetalleDocumento;0;"White";0)
AL_SetMiscColor (xALP_DetalleDocumento;1;"White";0)
AL_SetMiscColor (xALP_DetalleDocumento;2;"White";0)
AL_SetMiscColor (xALP_DetalleDocumento;3;"White";0)
AL_SetMainCalls (xALP_DetalleDocumento;"";"")
AL_SetScroll (xALP_DetalleDocumento;0;-3)
AL_SetCopyOpts (xALP_DetalleDocumento;0;"\t";"\r")
AL_SetSortOpts (xALP_DetalleDocumento;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_DetalleDocumento;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_DetalleDocumento;1;2;1;1;2)
AL_SetDividers (xALP_DetalleDocumento;"Black";"White";0;"Black";"White";0)
AL_SetDrgOpts (xALP_DetalleDocumento;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_DetalleDocumento;1;"";"";"")
AL_SetDrgSrc (xALP_DetalleDocumento;2;"";"";"")
AL_SetDrgSrc (xALP_DetalleDocumento;3;"";"";"")
AL_SetDrgDst (xALP_DetalleDocumento;1;"";"";"")
AL_SetDrgDst (xALP_DetalleDocumento;1;"";"";"")
AL_SetDrgDst (xALP_DetalleDocumento;1;"";"";"")

