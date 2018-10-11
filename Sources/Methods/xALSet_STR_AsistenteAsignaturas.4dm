//%attributes = {}
  //xALSet_STR_AsistenteAsignaturas

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_subsectores;1;1;"◊aAsign")

  //column 1 settings
AL_SetHeaders (xALP_subsectores;1;1;__ ("Subsectores"))
AL_SetWidths (xALP_subsectores;1;1;123)
AL_SetFormat (xALP_subsectores;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_subsectores;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_subsectores;1;"Tahoma";9;0)
AL_SetStyle (xALP_subsectores;1;"Tahoma";9;0)
AL_SetForeColor (xALP_subsectores;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_subsectores;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_subsectores;1;1)
AL_SetEntryCtls (xALP_subsectores;1;0)

  //general options
ALP_SetDefaultAppareance (xALP_subsectores)
AL_SetColOpts (xALP_subsectores;1;1;1;0;0)
AL_SetRowOpts (xALP_subsectores;0;0;0;0;1;0)
AL_SetCellOpts (xALP_subsectores;0;1;1)
AL_SetMiscOpts (xALP_subsectores;0;0;"\\";0;1)
AL_SetMainCalls (xALP_subsectores;"";"")
AL_SetScroll (xALP_subsectores;0;0)
AL_SetEntryOpts (xALP_subsectores;0;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_subsectores;0;30;0)

  //dragging options
AL_SetDrgSrc (xALP_subsectores;1;"PlanEstudios";"";"")
AL_SetDrgDst (xALP_subsectores;1;"Subsectores";"";"")


C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_PlanNivel;1;1;"aOrder")
$Error:=AL_SetArraysNam (xALP_PlanNivel;2;1;"aSubject")
$Error:=AL_SetArraysNam (xALP_PlanNivel;3;1;"aSubjectType")
$Error:=AL_SetArraysNam (xALP_PlanNivel;4;1;"aSex")
$Error:=AL_SetArraysNam (xALP_PlanNivel;5;1;"aNumber")
$Error:=AL_SetArraysNam (xALP_PlanNivel;6;1;"aIncide")
$Error:=AL_SetArraysNam (xALP_PlanNivel;7;1;"aStyle")

  //column 1 settings
AL_SetHeaders (xALP_PlanNivel;1;1;__ ("Orden"))
AL_SetWidths (xALP_PlanNivel;1;1;40)
AL_SetFormat (xALP_PlanNivel;1;"###";0;0;0;0)
AL_SetHdrStyle (xALP_PlanNivel;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlanNivel;1;"Tahoma";9;0)
AL_SetStyle (xALP_PlanNivel;1;"Tahoma";9;0)
AL_SetForeColor (xALP_PlanNivel;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlanNivel;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_PlanNivel;1;0)
AL_SetEntryCtls (xALP_PlanNivel;1;0)

  //column 2 settings
AL_SetHeaders (xALP_PlanNivel;2;1;__ ("Subsector"))
AL_SetWidths (xALP_PlanNivel;2;1;130)
AL_SetFormat (xALP_PlanNivel;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_PlanNivel;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlanNivel;2;"Tahoma";9;0)
AL_SetStyle (xALP_PlanNivel;2;"Tahoma";9;0)
AL_SetForeColor (xALP_PlanNivel;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlanNivel;2;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_PlanNivel;2;1)
AL_SetEntryCtls (xALP_PlanNivel;2;0)

  //column 3 settings
AL_SetHeaders (xALP_PlanNivel;3;1;__ ("Tipo"))
AL_SetWidths (xALP_PlanNivel;3;1;80)
AL_SetFormat (xALP_PlanNivel;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_PlanNivel;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlanNivel;3;"Tahoma";9;0)
AL_SetStyle (xALP_PlanNivel;3;"Tahoma";9;0)
AL_SetForeColor (xALP_PlanNivel;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlanNivel;3;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_PlanNivel;3;2;aText1)
AL_SetEntryCtls (xALP_PlanNivel;3;0)

  //column 4 settings
AL_SetHeaders (xALP_PlanNivel;4;1;__ ("Sexo"))
AL_SetWidths (xALP_PlanNivel;4;1;80)
AL_SetFormat (xALP_PlanNivel;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_PlanNivel;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlanNivel;4;"Tahoma";9;0)
AL_SetStyle (xALP_PlanNivel;4;"Tahoma";9;0)
AL_SetForeColor (xALP_PlanNivel;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlanNivel;4;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_PlanNivel;4;2;aText2)
AL_SetEntryCtls (xALP_PlanNivel;4;0)

  //column 5 settings
AL_SetHeaders (xALP_PlanNivel;5;1;__ ("Número"))
AL_SetFormat (xALP_PlanNivel;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_PlanNivel;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlanNivel;5;"Tahoma";9;0)
AL_SetStyle (xALP_PlanNivel;5;"Tahoma";9;0)
AL_SetForeColor (xALP_PlanNivel;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlanNivel;5;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_PlanNivel;5;3;aText3)
AL_SetFilter (xALP_PlanNivel;5;"&9")
AL_SetEntryCtls (xALP_PlanNivel;5;0)

  //column 6 settings
AL_SetHeaders (xALP_PlanNivel;6;1;__ ("Promediable"))
AL_SetFormat (xALP_PlanNivel;6;"Si;No";0;0;0;0)
AL_SetHdrStyle (xALP_PlanNivel;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlanNivel;6;"Tahoma";9;0)
AL_SetStyle (xALP_PlanNivel;6;"Tahoma";9;0)
AL_SetForeColor (xALP_PlanNivel;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlanNivel;6;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_PlanNivel;6;1)
AL_SetEntryCtls (xALP_PlanNivel;6;0)

  //column 7 settings
  //AL_SetCalcCall (xALP_PlanNivel;7;"xALP_SubjectsWzdCB")
AL_SetHeaders (xALP_PlanNivel;7;1;__ ("Estilo Evaluación"))
AL_SetWidths (xALP_PlanNivel;7;1;120)
AL_SetFormat (xALP_PlanNivel;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_PlanNivel;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlanNivel;7;"Tahoma";9;0)
AL_SetStyle (xALP_PlanNivel;7;"Tahoma";9;0)
AL_SetForeColor (xALP_PlanNivel;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlanNivel;7;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_PlanNivel;7;2;aEvStyleName)
AL_SetEntryCtls (xALP_PlanNivel;7;0)

  //general options
ALP_SetDefaultAppareance (xALP_PlanNivel)
AL_SetColOpts (xALP_PlanNivel;1;1;1;0;0)
AL_SetRowOpts (xALP_PlanNivel;0;0;0;0;1;0)
AL_SetCellOpts (xALP_PlanNivel;0;1;1)
AL_SetMiscOpts (xALP_PlanNivel;0;0;"\\";0;1)
AL_SetMainCalls (xALP_PlanNivel;"";"")
AL_SetScroll (xALP_PlanNivel;0;0)
AL_SetEntryOpts (xALP_PlanNivel;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_PlanNivel;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_PlanNivel;1;"Subsectores";"PlanEstudios")
AL_SetDrgDst (xALP_PlanNivel;1;"Subsectores";"PlanEstudios")



