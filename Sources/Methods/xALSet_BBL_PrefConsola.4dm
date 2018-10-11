//%attributes = {}
  //xALSet_BBL_PrefConsola

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_CommandsConsola_BBL;1;1;"<>atBBL_CommandCode")
$Error:=AL_SetArraysNam (xALP_CommandsConsola_BBL;2;1;"<>atBBL_Command")

  //column 1 settings
AL_SetHeaders (xALP_CommandsConsola_BBL;1;1;__ ("Código"))
AL_SetWidths (xALP_CommandsConsola_BBL;1;1;60)
AL_SetFormat (xALP_CommandsConsola_BBL;1;"";2;0;0;0)
AL_SetHdrStyle (xALP_CommandsConsola_BBL;1;"Arial";9;1)
AL_SetFtrStyle (xALP_CommandsConsola_BBL;1;"Arial";9;0)
AL_SetStyle (xALP_CommandsConsola_BBL;1;"ASI_System";9;1)
AL_SetForeColor (xALP_CommandsConsola_BBL;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CommandsConsola_BBL;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CommandsConsola_BBL;1;1)
AL_SetEntryCtls (xALP_CommandsConsola_BBL;1;0)

  //column 2 settings
AL_SetHeaders (xALP_CommandsConsola_BBL;2;1;__ ("Comando"))
AL_SetWidths (xALP_CommandsConsola_BBL;2;1;380)
AL_SetFormat (xALP_CommandsConsola_BBL;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_CommandsConsola_BBL;2;"Arial";9;1)
AL_SetFtrStyle (xALP_CommandsConsola_BBL;2;"Arial";9;0)
AL_SetStyle (xALP_CommandsConsola_BBL;2;"ASI_System";9;0)
AL_SetForeColor (xALP_CommandsConsola_BBL;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CommandsConsola_BBL;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CommandsConsola_BBL;2;1)
AL_SetEntryCtls (xALP_CommandsConsola_BBL;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_CommandsConsola_BBL;9;1;2;1;1)
AL_SetColOpts (xALP_CommandsConsola_BBL;1;1;1;0;0)
AL_SetRowOpts (xALP_CommandsConsola_BBL;0;1;0;0;1;0)
AL_SetCellOpts (xALP_CommandsConsola_BBL;0;1;1)
AL_SetMiscOpts (xALP_CommandsConsola_BBL;0;0;"\\";0;1)
AL_SetMainCalls (xALP_CommandsConsola_BBL;"";"")
AL_SetScroll (xALP_CommandsConsola_BBL;0;-3)
AL_SetEntryOpts (xALP_CommandsConsola_BBL;3;0;0;1;1;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_CommandsConsola_BBL;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_CommandsConsola_BBL;1;"";"";"")
AL_SetDrgSrc (xALP_CommandsConsola_BBL;2;"";"";"")
AL_SetDrgSrc (xALP_CommandsConsola_BBL;3;"";"";"")
AL_SetDrgDst (xALP_CommandsConsola_BBL;1;"";"";"")
AL_SetDrgDst (xALP_CommandsConsola_BBL;1;"";"";"")
AL_SetDrgDst (xALP_CommandsConsola_BBL;1;"";"";"")

