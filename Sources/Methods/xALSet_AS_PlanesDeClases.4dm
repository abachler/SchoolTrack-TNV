//%attributes = {}
  //xALSet_AS_PlanesDeClases

ARRAY DATE:C224(adSTRas_Planes_Desde;0)
ARRAY DATE:C224(adSTRas_Planes_Hasta;0)
ARRAY INTEGER:C220(aiSTRas_Planes_Horas;0)
ARRAY LONGINT:C221(alSTRas_Planes_ID;0)

C_LONGINT:C283($Error)

  //specify fields to display
$Error:=AL_SetArraysNam (xALP_Planes;1;1;"adSTRas_Planes_Desde")  //[Asignaturas_PlanesDeClases]Desde
$Error:=AL_SetArraysNam (xALP_Planes;2;1;"adSTRas_Planes_Hasta")  //[Asignaturas_PlanesDeClases]Hasta
$Error:=AL_SetArraysNam (xALP_Planes;3;1;"aiSTRas_Planes_Horas")  //[Asignaturas_PlanesDeClases]NumeroHoras
$Error:=AL_SetArraysNam (xALP_Planes;4;1;"alSTRas_Planes_ID")  //[Asignaturas_PlanesDeClases]ID_Plan

  //column 1 settings
AL_SetHeaders (xALP_Planes;1;1;__ ("Desde"))
AL_SetWidths (xALP_Planes;1;1;90)
AL_SetFormat (xALP_Planes;1;"7";1;0;0;0)
AL_SetHdrStyle (xALP_Planes;1;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Planes;1;"Tahoma";9;0)
AL_SetStyle (xALP_Planes;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Planes;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Planes;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Planes;1;1)
AL_SetEntryCtls (xALP_Planes;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Planes;2;1;__ ("Hasta"))
AL_SetWidths (xALP_Planes;2;1;90)
AL_SetFormat (xALP_Planes;2;"7";1;0;0;0)
AL_SetHdrStyle (xALP_Planes;2;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Planes;2;"Tahoma";9;0)
AL_SetStyle (xALP_Planes;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Planes;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Planes;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Planes;2;1)
AL_SetEntryCtls (xALP_Planes;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Planes;3;1;__ ("Hrs"))
AL_SetWidths (xALP_Planes;3;1;31)
AL_SetFormat (xALP_Planes;3;"####";3;0;0;0)
AL_SetHdrStyle (xALP_Planes;3;"Tahoma";9;0)
AL_SetFtrStyle (xALP_Planes;3;"Tahoma";9;0)
AL_SetStyle (xALP_Planes;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Planes;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Planes;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Planes;3;1)
AL_SetEntryCtls (xALP_Planes;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Planes;4;1;"ID (hidden)")
AL_SetFormat (xALP_Planes;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Planes;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Planes;4;"Tahoma";9;0)
AL_SetStyle (xALP_Planes;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Planes;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Planes;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Planes;4;1)
AL_SetEntryCtls (xALP_Planes;4;0)

  //general options
ALP_SetDefaultAppareance (xALP_Planes;9;1;4;1;4)
AL_SetColOpts (xALP_Planes;1;1;1;1;0)
AL_SetRowOpts (xALP_Planes;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Planes;0;1;1)
AL_SetMiscOpts (xALP_Planes;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Planes;"";"")
AL_SetCallbacks (xALP_Planes;"xALCB_EN_PlanesdeClases";"xALCB_EX_PlanesdeClases")
AL_SetScroll (xALP_Planes;0;-3)
AL_SetEntryOpts (xALP_Planes;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Planes;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Planes;1;"";"";"")
AL_SetDrgSrc (xALP_Planes;2;"";"";"")
AL_SetDrgSrc (xALP_Planes;3;"";"";"")
AL_SetDrgDst (xALP_Planes;1;"";"";"")
AL_SetDrgDst (xALP_Planes;1;"";"";"")
AL_SetDrgDst (xALP_Planes;1;"";"";"")

