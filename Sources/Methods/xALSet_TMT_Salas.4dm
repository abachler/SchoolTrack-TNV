//%attributes = {}
  //xALSet_TMT_Salas

C_LONGINT:C283($Error)

AL_RemoveArrays (xALP_Salas;1;3)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Salas;1;1;"atTMT_Salas_Nombre")
$Error:=AL_SetArraysNam (xALP_Salas;2;1;"aiTMT_Salas_Capacidad")
$Error:=AL_SetArraysNam (xALP_Salas;3;1;"alTMT_Salas_ID")

  //column 1 settings
AL_SetHeaders (xALP_Salas;1;1;__ ("Salas"))
AL_SetWidths (xALP_Salas;1;1;106)
AL_SetFormat (xALP_Salas;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Salas;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Salas;1;"Tahoma";9;0)
AL_SetStyle (xALP_Salas;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Salas;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Salas;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Salas;1;1)
AL_SetEntryCtls (xALP_Salas;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Salas;2;1;"Capacidad (hidden)")
AL_SetFormat (xALP_Salas;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Salas;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Salas;2;"Tahoma";9;0)
AL_SetStyle (xALP_Salas;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Salas;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Salas;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Salas;2;1)
AL_SetEntryCtls (xALP_Salas;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Salas;3;1;"ID_SALA (hidden)")
AL_SetFormat (xALP_Salas;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Salas;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Salas;3;"Tahoma";9;0)
AL_SetStyle (xALP_Salas;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Salas;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Salas;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Salas;3;1)
AL_SetEntryCtls (xALP_Salas;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_Salas;11;1;4;1;4)
AL_SetColOpts (xALP_Salas;1;1;1;2;0)
AL_SetRowOpts (xALP_Salas;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Salas;0;1;1)
AL_SetMiscOpts (xALP_Salas;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Salas;"";"")
AL_SetScroll (xALP_Salas;0;-3)
AL_SetEntryOpts (xALP_Salas;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Salas;0;30;0)
AL_SetInterface (xALP_Salas;AL Force OSX Interface;1;1;0;0;1)

  //dragging options

AL_SetDrgSrc (xALP_Salas;1;"salas";"";"")
AL_SetDrgSrc (xALP_Salas;2;"";"";"")
AL_SetDrgSrc (xALP_Salas;3;"salas";"horario";"")
AL_SetDrgDst (xALP_Salas;1;"";"";"")
AL_SetDrgDst (xALP_Salas;2;"";"";"")
AL_SetDrgDst (xALP_Salas;3;"horario";"salas";"")

AL_SetLine (xALP_Salas;0)