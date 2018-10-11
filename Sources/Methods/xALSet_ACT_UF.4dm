//%attributes = {}
  //xALSet_ACT_UF

C_LONGINT:C283($Error)

  //specify arrays to display
  //$Error:=AL_SetArraysNam (xALP_UF;1;1;"aiACT_DiaUF")
  //$Error:=AL_SetArraysNam (xALP_UF;2;1;"arACT_ValorUF")

$Error:=AL_SetArraysNam (xALP_UF;1;1;"alACT_MonedaDia")
$Error:=AL_SetArraysNam (xALP_UF;2;1;"arACT_ValorMonedaDia")

  //column 1 settings
AL_SetHeaders (xALP_UF;1;1;__ ("Dia"))
AL_SetWidths (xALP_UF;1;1;36)
AL_SetFormat (xALP_UF;1;"00";0;2;0;0)
AL_SetHdrStyle (xALP_UF;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_UF;1;"Tahoma";9;0)
AL_SetStyle (xALP_UF;1;"Tahoma";9;0)
AL_SetForeColor (xALP_UF;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_UF;1;"White";0;"white";0;"White";0)
AL_SetEnterable (xALP_UF;1;0)
AL_SetEntryCtls (xALP_UF;1;0)

  //column 2 settings
AL_SetHeaders (xALP_UF;2;1;__ ("Valor"))
AL_SetWidths (xALP_UF;2;1;100)
AL_SetFormat (xALP_UF;2;"|Real_2Dec";0;2;0;0)
AL_SetHdrStyle (xALP_UF;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_UF;2;"Tahoma";9;0)
AL_SetStyle (xALP_UF;2;"Tahoma";9;0)
AL_SetForeColor (xALP_UF;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_UF;2;"White";0;"white";0;"White";0)
AL_SetEnterable (xALP_UF;2;0)
AL_SetEntryCtls (xALP_UF;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_UF;9;1;6;1;8)
AL_SetColOpts (xALP_UF;1;1;1;0;0)
AL_SetRowOpts (xALP_UF;0;0;0;0;1;0)
AL_SetCellOpts (xALP_UF;0;1;1)
AL_SetMainCalls (xALP_UF;"";"")
AL_SetCallbacks (xALP_UF;"";"xALP_ACT_CB_MYTValXDia")
AL_SetScroll (xALP_UF;0;-3)
AL_SetEntryOpts (xALP_UF;3;0;0;1;2;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_UF;0;30;0)
AL_SetSortOpts (xALP_UF;0;0;0;"Seleccione las columnas a ordenar:";0;1)
  //dragging options

AL_SetDrgSrc (xALP_UF;1;"";"";"")
AL_SetDrgSrc (xALP_UF;2;"";"";"")
AL_SetDrgSrc (xALP_UF;3;"";"";"")
AL_SetDrgDst (xALP_UF;1;"";"";"")
AL_SetDrgDst (xALP_UF;1;"";"";"")
AL_SetDrgDst (xALP_UF;1;"";"";"")

