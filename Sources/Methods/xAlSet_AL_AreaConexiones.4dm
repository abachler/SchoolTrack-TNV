//%attributes = {}
  //xAlSet_AL_AreaConexiones

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Connexions;1;1;"at_Connexions")

  //column 1 settings
AL_SetHeaders (xALP_Connexions;1;1;__ ("Relaciones"))
AL_SetWidths (xALP_Connexions;1;1;230)
AL_SetFormat (xALP_Connexions;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Connexions;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Connexions;1;"Tahoma";9;0)
AL_SetStyle (xALP_Connexions;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Connexions;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Connexions;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Connexions;1;3;<>at_ConnectionsType)
AL_SetEntryCtls (xALP_Connexions;1;0)

  //general options
ALP_SetDefaultAppareance (xALP_Connexions;9;1;6;2;4)
AL_SetColOpts (xALP_Connexions;1;1;1;0;0)
AL_SetRowOpts (xALP_Connexions;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Connexions;0;1;1)
AL_SetMiscOpts (xALP_Connexions;1;0;"\\";0;1)
AL_SetMainCalls (xALP_Connexions;"";"")
AL_SetScroll (xALP_Connexions;0;0)
AL_SetEntryOpts (xALP_Connexions;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Connexions;0;30;0)
AL_SetCallbacks (xALP_Connexions;"";"xALCB_EX_Conexiones")

  //dragging options

AL_SetDrgSrc (xALP_Connexions;1;"";"";"")
AL_SetDrgSrc (xALP_Connexions;2;"";"";"")
AL_SetDrgSrc (xALP_Connexions;3;"";"";"")
AL_SetDrgDst (xALP_Connexions;1;"";"";"")
AL_SetDrgDst (xALP_Connexions;1;"";"";"")
AL_SetDrgDst (xALP_Connexions;1;"";"";"")


AL_SetLine (xALP_Connexions;0)