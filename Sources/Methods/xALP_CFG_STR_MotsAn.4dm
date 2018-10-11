//%attributes = {}
  //xALP_CFG_STR_MotsAn

$Error:=AL_SetArraysNam (xALP_Motivos;1;1;"atSTR_Anotaciones_motivo")
$Error:=AL_SetArraysNam (xALP_Motivos;2;1;"aiSTR_Anotaciones_puntaje")
$Error:=AL_SetArraysNam (xALP_Motivos;3;1;"aiSTR_Anotaciones_Registradas")

  //column 1 settings
AL_SetHeaders (xALP_Motivos;1;1;__ ("Motivo"))
AL_SetWidths (xALP_Motivos;1;1;250)
AL_SetFormat (xALP_Motivos;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Motivos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Motivos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Motivos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Motivos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Motivos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Motivos;1;1)
AL_SetEntryCtls (xALP_Motivos;1;0)

AL_SetHeaders (xALP_Motivos;2;1;__ ("Puntaje"))
AL_SetWidths (xALP_Motivos;2;1;50)
AL_SetFormat (xALP_Motivos;2;"#####0";0;0;0;0)
AL_SetFilter (xALP_Motivos;2;"&9")
AL_SetHdrStyle (xALP_Motivos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Motivos;2;"Tahoma";9;0)
AL_SetStyle (xALP_Motivos;2;"Tahoma";9;1)
AL_SetForeColor (xALP_Motivos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Motivos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Motivos;2;1)
AL_SetEntryCtls (xALP_Motivos;2;0)

AL_SetHeaders (xALP_Motivos;3;1;__ ("Registradas"))
AL_SetWidths (xALP_Motivos;3;1;70)
AL_SetFormat (xALP_Motivos;3;"######";0;0;0;0)
AL_SetFilter (xALP_Motivos;3;"&9")
AL_SetHdrStyle (xALP_Motivos;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Motivos;3;"Tahoma";9;0)
AL_SetStyle (xALP_Motivos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Motivos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Motivos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Motivos;3;0)
AL_SetEntryCtls (xALP_Motivos;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_Motivos;9;2;6;1;8)
AL_SetColOpts (xALP_Motivos;1;1;1;0;0)
AL_SetRowOpts (xALP_Motivos;0;0;0;0;1;0)
AL_SetSortOpts (xALP_Motivos;1;1;0;"";1;1)
AL_SetCellOpts (xALP_Motivos;0;1;1)
AL_SetMiscOpts (xALP_Motivos;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Motivos;"";"")
AL_SetScroll (xALP_Motivos;0;-3)
AL_SetEntryOpts (xALP_Motivos;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Motivos;0;30;0;1)
AL_SetCallbacks (xALP_Motivos;"";"xALCB_EX_MotivoAnotaciones")
  //dragging options

AL_SetDrgSrc (xALP_Motivos;1;String:C10(xALP_Motivos))