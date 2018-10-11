//%attributes = {}
  //xALP_Set_ACT_ApdosCta

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_ApdosCta;1;1;"aNombresApdoCta")
$Error:=AL_SetArraysNam (xALP_ApdosCta;2;1;"aAdeudadoApdoCta")
$Error:=AL_SetArraysNam (xALP_ApdosCta;3;1;"aEsApdoCta")
$Error:=AL_SetArraysNam (xALP_ApdosCta;4;1;"aRNApdo")

  //column 1 settings
AL_SetHeaders (xALP_ApdosCta;1;1;__ ("Apoderado"))
AL_SetWidths (xALP_ApdosCta;1;1;250)
AL_SetFormat (xALP_ApdosCta;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_ApdosCta;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ApdosCta;1;"Tahoma";9;0)
AL_SetStyle (xALP_ApdosCta;1;"Tahoma";9;0)
AL_SetForeColor (xALP_ApdosCta;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ApdosCta;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ApdosCta;1;0)
AL_SetEntryCtls (xALP_ApdosCta;1;0)

  //column 2 settings
AL_SetHeaders (xALP_ApdosCta;2;1;__ ("Monto Adeudado"))
AL_SetWidths (xALP_ApdosCta;2;1;137)
AL_SetFormat (xALP_ApdosCta;2;"|Despliegue_ACT";0;0;0;0)
AL_SetHdrStyle (xALP_ApdosCta;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ApdosCta;2;"Tahoma";9;0)
AL_SetStyle (xALP_ApdosCta;2;"Tahoma";9;0)
AL_SetForeColor (xALP_ApdosCta;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ApdosCta;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ApdosCta;2;0)
AL_SetEntryCtls (xALP_ApdosCta;2;0)

  //column 3 settings
AL_SetHeaders (xALP_ApdosCta;3;1;"apdocta")
AL_SetWidths (xALP_ApdosCta;3;1;110)
AL_SetFormat (xALP_ApdosCta;3;"";0;2;0;0)
AL_SetHdrStyle (xALP_ApdosCta;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ApdosCta;3;"Tahoma";9;0)
AL_SetStyle (xALP_ApdosCta;3;"Tahoma";9;0)
AL_SetForeColor (xALP_ApdosCta;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ApdosCta;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ApdosCta;3;0)
AL_SetEntryCtls (xALP_ApdosCta;3;0)

  //column 4 settings
AL_SetHeaders (xALP_ApdosCta;4;1;"recnums")
AL_SetWidths (xALP_ApdosCta;4;1;110)
AL_SetFormat (xALP_ApdosCta;4;"";0;2;0;0)
AL_SetHdrStyle (xALP_ApdosCta;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ApdosCta;4;"Tahoma";9;0)
AL_SetStyle (xALP_ApdosCta;4;"Tahoma";9;0)
AL_SetForeColor (xALP_ApdosCta;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ApdosCta;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ApdosCta;4;0)
AL_SetEntryCtls (xALP_ApdosCta;4;0)

  //general options
ALP_SetDefaultAppareance (xALP_ApdosCta;9;1;6;1;8)
AL_SetColOpts (xALP_ApdosCta;1;1;1;2;0)
AL_SetRowOpts (xALP_ApdosCta;0;1;0;0;1;0)
AL_SetCellOpts (xALP_ApdosCta;0;1;1)
AL_SetMainCalls (xALP_ApdosCta;"";"")
AL_SetScroll (xALP_ApdosCta;0;-3)
AL_SetEntryOpts (xALP_ApdosCta;1;0;0;1;2;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_ApdosCta;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_ApdosCta;1;"";"";"")
AL_SetDrgSrc (xALP_ApdosCta;2;"";"";"")
AL_SetDrgSrc (xALP_ApdosCta;3;"";"";"")
AL_SetDrgDst (xALP_ApdosCta;1;"";"";"")
AL_SetDrgDst (xALP_ApdosCta;1;"";"";"")
AL_SetDrgDst (xALP_ApdosCta;1;"";"";"")
