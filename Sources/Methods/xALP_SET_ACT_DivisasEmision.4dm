//%attributes = {}
  //xALP_SET_ACT_DivisasEmision

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Divisas;1;1;"atACT_NombreMoneda")
$Error:=AL_SetArraysNam (xALP_Divisas;2;1;"arACT_ValorMoneda")

  //column 1 settings
AL_SetHeaders (xALP_Divisas;1;1;__ ("Moneda"))
AL_SetWidths (xALP_Divisas;1;1;110)
AL_SetFormat (xALP_Divisas;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_Divisas;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Divisas;1;"Tahoma";9;0)
AL_SetStyle (xALP_Divisas;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Divisas;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Divisas;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Divisas;1;0)
AL_SetEntryCtls (xALP_Divisas;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Divisas;2;1;__ ("Valor en ")+<>vsACT_MonedaColegio)
AL_SetWidths (xALP_Divisas;2;1;92)
AL_SetFormat (xALP_Divisas;2;"|Despliegue_UF";0;2;0;0)
AL_SetHdrStyle (xALP_Divisas;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Divisas;2;"Tahoma";9;0)
AL_SetStyle (xALP_Divisas;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Divisas;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Divisas;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Divisas;2;1)
AL_SetEntryCtls (xALP_Divisas;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_Divisas;9;1;6;2;8)
AL_SetColOpts (xALP_Divisas;1;1;1;0;0)
AL_SetRowOpts (xALP_Divisas;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Divisas;0;1;1)
AL_SetMainCalls (xALP_Divisas;"";"")
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

