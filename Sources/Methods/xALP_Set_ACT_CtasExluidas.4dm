//%attributes = {}
  //xALP_Set_ACT_CtasExluidas

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_CtasExluidas;1;1;"aDeletedNames")
$Error:=AL_SetArraysNam (xALP_CtasExluidas;2;1;"aMotivo")

  //column 1 settings
If (vbACT_formPDFs)
	AL_SetHeaders (xALP_CtasExluidas;1;1;__ ("Apoderado"))
Else 
	AL_SetHeaders (xALP_CtasExluidas;1;1;__ ("Cuenta Corriente"))
End if 
AL_SetWidths (xALP_CtasExluidas;1;1;200)
AL_SetFormat (xALP_CtasExluidas;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_CtasExluidas;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CtasExluidas;1;"Tahoma";9;0)
AL_SetStyle (xALP_CtasExluidas;1;"Tahoma";9;0)
AL_SetForeColor (xALP_CtasExluidas;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CtasExluidas;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CtasExluidas;1;0)
AL_SetEntryCtls (xALP_CtasExluidas;1;0)

  //column 2 settings
AL_SetHeaders (xALP_CtasExluidas;2;1;__ ("Motivo"))
AL_SetWidths (xALP_CtasExluidas;2;1;338)
AL_SetFormat (xALP_CtasExluidas;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_CtasExluidas;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CtasExluidas;2;"Tahoma";9;0)
AL_SetStyle (xALP_CtasExluidas;2;"Tahoma";9;0)
AL_SetForeColor (xALP_CtasExluidas;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CtasExluidas;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CtasExluidas;2;0)
AL_SetEntryCtls (xALP_CtasExluidas;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_CtasExluidas;9;2;6;1;8)
AL_SetColOpts (xALP_CtasExluidas;1;1;1;0;0)
AL_SetRowOpts (xALP_CtasExluidas;1;1;0;0;1;0)
AL_SetCellOpts (xALP_CtasExluidas;0;1;1)
AL_SetMainCalls (xALP_CtasExluidas;"";"")
AL_SetScroll (xALP_CtasExluidas;0;-3)
AL_SetEntryOpts (xALP_CtasExluidas;0;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_CtasExluidas;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_CtasExluidas;1;"";"";"")
AL_SetDrgSrc (xALP_CtasExluidas;2;"";"";"")
AL_SetDrgSrc (xALP_CtasExluidas;3;"";"";"")
AL_SetDrgDst (xALP_CtasExluidas;1;"";"";"")
AL_SetDrgDst (xALP_CtasExluidas;1;"";"";"")
AL_SetDrgDst (xALP_CtasExluidas;1;"";"";"")
