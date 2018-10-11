//%attributes = {}
  //xALP_ACT_Set_DesctoTramos

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xalp_desctostramos;1;1;"atACT_Tramo")
$Error:=AL_SetArraysNam (xalp_desctostramos;2;1;"arACT_DesctoTramo")

  //column 1 settings
AL_SetHeaders (xalp_desctostramos;1;1;"")
AL_SetWidths (xalp_desctostramos;1;1;75)
AL_SetFormat (xalp_desctostramos;1;"";0;0;0;0)
AL_SetHdrStyle (xalp_desctostramos;1;"Tahoma";9;1)
AL_SetFtrStyle (xalp_desctostramos;1;"Tahoma";9;0)
AL_SetStyle (xalp_desctostramos;1;"Tahoma";9;0)
AL_SetForeColor (xalp_desctostramos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xalp_desctostramos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xalp_desctostramos;1;0)
AL_SetEntryCtls (xalp_desctostramos;1;0)

  //column 2 settings
AL_SetHeaders (xalp_desctostramos;2;1;"")
AL_SetWidths (xalp_desctostramos;2;1;75)
AL_SetFormat (xalp_desctostramos;2;"|Pct_4DecIfNec";0;0;0;0)
AL_SetHdrStyle (xalp_desctostramos;2;"Tahoma";9;1)
AL_SetFtrStyle (xalp_desctostramos;2;"Tahoma";9;0)
AL_SetStyle (xalp_desctostramos;2;"Tahoma";9;0)
AL_SetForeColor (xalp_desctostramos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xalp_desctostramos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xalp_desctostramos;2;1)
AL_SetEntryCtls (xalp_desctostramos;2;0)

  //general options
ALP_SetDefaultAppareance (xalp_desctostramos;9;1;6;1;8)
AL_SetColOpts (xalp_desctostramos;1;1;1;0;0)
AL_SetRowOpts (xalp_desctostramos;0;1;0;0;1;1)
AL_SetCellOpts (xalp_desctostramos;0;1;1)
AL_SetMiscOpts (xalp_desctostramos;1;0;"\\";0;1)
AL_SetMainCalls (xalp_desctostramos;"";"")
AL_SetCallbacks (xalp_desctostramos;"";"xALCB_EX_cfgModBlobItemsTramos")
AL_SetScroll (xalp_desctostramos;0;0)
  //AL_SetEntryOpts (xalp_desctostramos;2;0;0;0;0;◊tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xalp_desctostramos;0;30;0)

  //dragging options

AL_SetDrgSrc (xalp_desctostramos;1;"";"";"")
AL_SetDrgSrc (xalp_desctostramos;2;"";"";"")
AL_SetDrgSrc (xalp_desctostramos;3;"";"";"")
AL_SetDrgDst (xalp_desctostramos;1;"";"";"")
AL_SetDrgDst (xalp_desctostramos;1;"";"";"")
AL_SetDrgDst (xalp_desctostramos;1;"";"";"")

