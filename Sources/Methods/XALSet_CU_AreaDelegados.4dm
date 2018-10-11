//%attributes = {}
  //XALSet_CU_AreaDelegados

C_LONGINT:C283($Error)
AL_RemoveArrays (xALP_Delegados;1;6)



  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Delegados;1;1;"at_CUDelegacionDelegado")
$Error:=AL_SetArraysNam (xALP_Delegados;2;1;"at_CUNameDelegado")
$Error:=AL_SetArraysNam (xALP_Delegados;3;1;"at_CUWorkPhoneDelegado")
$Error:=AL_SetArraysNam (xALP_Delegados;4;1;"at_CUHomePhoneDelegado")
$Error:=AL_SetArraysNam (xALP_Delegados;5;1;"at_CUeMailDelegado")
$Error:=AL_SetArraysNam (xALP_Delegados;6;1;"al_CUIdDelegado")

  //column 1 settings
AL_SetHeaders (xALP_Delegados;1;1;__ ("Comité"))
AL_SetWidths (xALP_Delegados;1;1;160)
AL_SetFormat (xALP_Delegados;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Delegados;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Delegados;1;"Tahoma";9;0)
AL_SetStyle (xALP_Delegados;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Delegados;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Delegados;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Delegados;1;3;<>at_Delegaciones)
AL_SetEntryCtls (xALP_Delegados;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Delegados;2;1;__ ("Apoderado"))
AL_SetWidths (xALP_Delegados;2;1;200)
AL_SetFormat (xALP_Delegados;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Delegados;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Delegados;2;"Tahoma";9;0)
AL_SetStyle (xALP_Delegados;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Delegados;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Delegados;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Delegados;2;2;at_CUApoderados)
AL_SetEntryCtls (xALP_Delegados;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Delegados;3;1;__ ("Tel. profesional"))
AL_SetWidths (xALP_Delegados;3;1;100)
AL_SetFormat (xALP_Delegados;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Delegados;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Delegados;3;"Tahoma";9;0)
AL_SetStyle (xALP_Delegados;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Delegados;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Delegados;3;"White";0;"";15*16+1;"White";0)
AL_SetEnterable (xALP_Delegados;3;0)
AL_SetEntryCtls (xALP_Delegados;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Delegados;4;1;__ ("Tel. Domicilio"))
AL_SetWidths (xALP_Delegados;4;1;100)
AL_SetFormat (xALP_Delegados;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Delegados;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Delegados;4;"Tahoma";9;0)
AL_SetStyle (xALP_Delegados;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Delegados;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Delegados;4;"White";0;"";15*16+1;"White";0)
AL_SetEnterable (xALP_Delegados;4;0)
AL_SetEntryCtls (xALP_Delegados;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Delegados;5;1;__ ("Correo electrónico"))
AL_SetWidths (xALP_Delegados;5;1;110)
AL_SetFormat (xALP_Delegados;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_Delegados;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Delegados;5;"Tahoma";9;0)
AL_SetStyle (xALP_Delegados;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Delegados;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Delegados;5;"White";0;"";15*16+1;"White";0)
AL_SetEnterable (xALP_Delegados;5;0)
AL_SetEntryCtls (xALP_Delegados;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Delegados;6;1;"ID Apoderado (hidden)")
AL_SetFormat (xALP_Delegados;6;"";0;0;0;0)
AL_SetHdrStyle (xALP_Delegados;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Delegados;6;"Tahoma";9;0)
AL_SetStyle (xALP_Delegados;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Delegados;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Delegados;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Delegados;6;0)
AL_SetEntryCtls (xALP_Delegados;6;0)

  //general options
ALP_SetDefaultAppareance (xALP_Delegados;9;1;4;1;4)
AL_SetColOpts (xALP_Delegados;1;1;1;1;0)
AL_SetRowOpts (xALP_Delegados;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Delegados;0;1;1)
AL_SetMiscOpts (xALP_Delegados;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Delegados;"";"")
AL_SetScroll (xALP_Delegados;0;-3)
AL_SetEntryOpts (xALP_Delegados;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Delegados;0;30;0)
AL_SetCallbacks (xALP_Delegados;"";"xALCB_EX_Delegados")

  //dragging options

AL_SetDrgSrc (xALP_Delegados;1;"";"";"")
AL_SetDrgSrc (xALP_Delegados;2;"";"";"")
AL_SetDrgSrc (xALP_Delegados;3;"";"";"")
AL_SetDrgDst (xALP_Delegados;1;"";"";"")
AL_SetDrgDst (xALP_Delegados;1;"";"";"")
AL_SetDrgDst (xALP_Delegados;1;"";"";"")
