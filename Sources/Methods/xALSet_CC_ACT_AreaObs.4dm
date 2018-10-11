//%attributes = {}
  //xALSet_CC_ACT_AreaObs

C_LONGINT:C283($Error)

AL_RemoveArrays (xALP_Observaciones;1;3)
$Error:=AL_SetArraysNam (xALP_Observaciones;1;3;"adACT_FechaObs";"atACT_Observacion";"alACT_IDObs")

  //column 1 settings
AL_SetHeaders (xALP_Observaciones;1;1;__ ("Fecha"))
AL_SetFormat (xALP_Observaciones;1;"";0;0;0;0)
AL_SetWidths (xALP_Observaciones;1;1;148)
AL_SetHdrStyle (xALP_Observaciones;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Observaciones;1;"Tahoma";9;0)
AL_SetStyle (xALP_Observaciones;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Observaciones;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Observaciones;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Observaciones;1;3)
AL_SetEntryCtls (xALP_Observaciones;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Observaciones;2;1;__ ("Observación"))
AL_SetFormat (xALP_Observaciones;2;"";0;0;0;0)
AL_SetWidths (xALP_Observaciones;2;1;600)
AL_SetHdrStyle (xALP_Observaciones;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Observaciones;2;"Tahoma";9;0)
AL_SetStyle (xALP_Observaciones;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Observaciones;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Observaciones;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Observaciones;2;1)
AL_SetEntryCtls (xALP_Observaciones;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Observaciones;3;1;"ID")
AL_SetFormat (xALP_Observaciones;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Observaciones;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Observaciones;3;"Tahoma";9;0)
AL_SetStyle (xALP_Observaciones;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Observaciones;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Observaciones;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Observaciones;3;0)
AL_SetEntryCtls (xALP_Observaciones;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_Observaciones;9;4;8;1;6)
AL_SetColOpts (xALP_Observaciones;1;1;1;1;0)
AL_SetRowOpts (xALP_Observaciones;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Observaciones;0;1;1)
AL_SetMainCalls (xALP_Observaciones;"";"")
AL_SetCallbacks (xALP_Observaciones;"";"xALP_CB_ACT_CtasObs")
AL_SetScroll (xALP_Observaciones;0;-3)
AL_SetEntryOpts (xALP_Observaciones;3;0;0;0;0;".";1)
AL_SetDrgOpts (xALP_Observaciones;0;30;0)
