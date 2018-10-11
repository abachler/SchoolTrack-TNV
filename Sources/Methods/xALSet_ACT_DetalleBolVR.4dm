//%attributes = {}
  //xALSet_ACT_DetalleBolVR

AL_RemoveArrays (ALP_CargosXPagar;1;14)

  //specify arrays to display
  //20130626 RCH NF CANTIDAD
$Error:=AL_SetArraysNam (alp_cargosxpagar;1;1;"arACT_CantidadVVR")
$Error:=AL_SetArraysNam (alp_cargosxpagar;2;1;"atACT_GlosaVVR")
$Error:=AL_SetArraysNam (alp_cargosxpagar;3;1;"arACT_TotalVVR")

  //column 1 settings
AL_SetHeaders (alp_cargosxpagar;1;1;__ ("Cantidad"))
AL_SetWidths (alp_cargosxpagar;1;1;60)
AL_SetFormat (alp_cargosxpagar;1;"#####";0;2;0;0)
AL_SetHdrStyle (alp_cargosxpagar;1;"Tahoma";9;1)
AL_SetFtrStyle (alp_cargosxpagar;1;"Tahoma";9;0)
AL_SetStyle (alp_cargosxpagar;1;"Tahoma";9;0)
AL_SetForeColor (alp_cargosxpagar;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (alp_cargosxpagar;1;"White";0;"White";0;"White";0)
AL_SetEnterable (alp_cargosxpagar;1;0)
AL_SetEntryCtls (alp_cargosxpagar;1;0)

  //column 2 settings
AL_SetHeaders (alp_cargosxpagar;2;1;__ ("Glosa"))
AL_SetWidths (alp_cargosxpagar;2;1;600)
AL_SetFormat (alp_cargosxpagar;2;"";0;2;0;0)
AL_SetHdrStyle (alp_cargosxpagar;2;"Tahoma";9;1)
AL_SetFtrStyle (alp_cargosxpagar;2;"Tahoma";9;0)
AL_SetStyle (alp_cargosxpagar;2;"Tahoma";9;0)
AL_SetForeColor (alp_cargosxpagar;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (alp_cargosxpagar;2;"White";0;"White";0;"White";0)
AL_SetEnterable (alp_cargosxpagar;2;0)
AL_SetEntryCtls (alp_cargosxpagar;2;0)

  //column 3 settings
AL_SetHeaders (alp_cargosxpagar;3;1;__ ("Total"))
AL_SetWidths (alp_cargosxpagar;3;1;71)
AL_SetFormat (alp_cargosxpagar;3;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (alp_cargosxpagar;3;"Tahoma";9;1)
AL_SetFtrStyle (alp_cargosxpagar;3;"Tahoma";9;0)
AL_SetStyle (alp_cargosxpagar;3;"Tahoma";9;0)
AL_SetForeColor (alp_cargosxpagar;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (alp_cargosxpagar;3;"White";0;"White";0;"White";0)
AL_SetEnterable (alp_cargosxpagar;3;0)
AL_SetEntryCtls (alp_cargosxpagar;3;0)

  //general options
ALP_SetDefaultAppareance (alp_cargosxpagar;9;1;6;1;8)
AL_SetColOpts (alp_cargosxpagar;1;1;1;0;0)
AL_SetRowOpts (alp_cargosxpagar;0;1;0;0;1;0)
AL_SetCellOpts (alp_cargosxpagar;0;1;1)
AL_SetMainCalls (alp_cargosxpagar;"";"")
AL_SetScroll (alp_cargosxpagar;0;0)
AL_SetEntryOpts (alp_cargosxpagar;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (alp_cargosxpagar;0;30;0)

  //dragging options

AL_SetDrgSrc (alp_cargosxpagar;1;"";"";"")
AL_SetDrgSrc (alp_cargosxpagar;2;"";"";"")
AL_SetDrgSrc (alp_cargosxpagar;3;"";"";"")
AL_SetDrgDst (alp_cargosxpagar;1;"";"";"")
AL_SetDrgDst (alp_cargosxpagar;1;"";"";"")
AL_SetDrgDst (alp_cargosxpagar;1;"";"";"")

