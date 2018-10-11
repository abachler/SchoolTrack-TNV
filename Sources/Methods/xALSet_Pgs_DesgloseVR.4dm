//%attributes = {}
  //xALSet_Pgs_DesgloseVR

C_LONGINT:C283($Error)

  //specify arrays to display
  //20130626 RCH NF CANTIDAD
$Error:=AL_SetArraysNam (xALP_DesglosePago;1;1;"arACT_CantidadVVR")
$Error:=AL_SetArraysNam (xALP_DesglosePago;2;1;"atACT_GlosaVVR")
$Error:=AL_SetArraysNam (xALP_DesglosePago;3;1;"arACT_TotalVVR")
$Error:=AL_SetArraysNam (xALP_DesglosePago;4;1;"apACT_AfectoIVAVVR")
$Error:=AL_SetArraysNam (xALP_DesglosePago;5;1;"abACT_AfectoIVAVVR")

  //column 1 settings
AL_SetHeaders (xALP_DesglosePago;1;1;__ ("Cantidad"))
AL_SetWidths (xALP_DesglosePago;1;1;90)
AL_SetFormat (xALP_DesglosePago;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_DesglosePago;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DesglosePago;1;"Tahoma";9;0)
AL_SetStyle (xALP_DesglosePago;1;"Tahoma";9;0)
AL_SetForeColor (xALP_DesglosePago;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DesglosePago;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DesglosePago;1;1)
AL_SetEntryCtls (xALP_DesglosePago;1;0)

  //column 2 settings
AL_SetHeaders (xALP_DesglosePago;2;1;__ ("Glosa"))
AL_SetWidths (xALP_DesglosePago;2;1;461)
AL_SetFormat (xALP_DesglosePago;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_DesglosePago;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DesglosePago;2;"Tahoma";9;0)
AL_SetStyle (xALP_DesglosePago;2;"Tahoma";9;0)
AL_SetForeColor (xALP_DesglosePago;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DesglosePago;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DesglosePago;2;1)
AL_SetEntryCtls (xALP_DesglosePago;2;0)

  //column 3 settings
AL_SetHeaders (xALP_DesglosePago;3;1;__ ("Total"))
AL_SetWidths (xALP_DesglosePago;3;1;90)
AL_SetFormat (xALP_DesglosePago;3;"|Long";0;2;0;0)
AL_SetHdrStyle (xALP_DesglosePago;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DesglosePago;3;"Tahoma";9;0)
AL_SetStyle (xALP_DesglosePago;3;"Tahoma";9;0)
AL_SetForeColor (xALP_DesglosePago;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DesglosePago;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DesglosePago;3;1)
AL_SetEntryCtls (xALP_DesglosePago;3;0)

  //column 4 settings
AL_SetHeaders (xALP_DesglosePago;4;1;__ ("Afecto a IVA"))
AL_SetWidths (xALP_DesglosePago;4;1;90)
AL_SetFormat (xALP_DesglosePago;4;"1";0;2;0;0)
AL_SetHdrStyle (xALP_DesglosePago;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DesglosePago;4;"Tahoma";9;0)
AL_SetStyle (xALP_DesglosePago;4;"Tahoma";9;0)
AL_SetForeColor (xALP_DesglosePago;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DesglosePago;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DesglosePago;4;1)
AL_SetEntryCtls (xALP_DesglosePago;4;0)

  //column 5 settings
AL_SetHeaders (xALP_DesglosePago;5;1;__ ("Afecto"))
AL_SetWidths (xALP_DesglosePago;5;1;90)
AL_SetFormat (xALP_DesglosePago;5;"|Long";0;2;0;0)
AL_SetHdrStyle (xALP_DesglosePago;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DesglosePago;5;"Tahoma";9;0)
AL_SetStyle (xALP_DesglosePago;5;"Tahoma";9;0)
AL_SetForeColor (xALP_DesglosePago;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DesglosePago;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DesglosePago;5;1)
AL_SetEntryCtls (xALP_DesglosePago;5;0)

  //general options
ALP_SetDefaultAppareance (xALP_DesglosePago;9;1;6;1;8)
AL_SetColOpts (xALP_DesglosePago;1;1;1;1;0)
AL_SetRowOpts (xALP_DesglosePago;0;1;0;0;1;1)
AL_SetCellOpts (xALP_DesglosePago;0;1;1)
AL_SetMiscOpts (xALP_DesglosePago;0;0;"\\";0;1)
AL_SetMainCalls (xALP_DesglosePago;"";"")
AL_SetScroll (xALP_DesglosePago;0;-3)
AL_SetEntryOpts (xALP_DesglosePago;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_DesglosePago;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_DesglosePago;1;"";"";"")
AL_SetDrgSrc (xALP_DesglosePago;2;"";"";"")
AL_SetDrgSrc (xALP_DesglosePago;3;"";"";"")
AL_SetDrgDst (xALP_DesglosePago;1;"";"";"")
AL_SetDrgDst (xALP_DesglosePago;1;"";"";"")
AL_SetDrgDst (xALP_DesglosePago;1;"";"";"")