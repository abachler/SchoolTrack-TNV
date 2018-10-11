//%attributes = {}
  //MINEDUC_SetCursosALParea

  //Configuration commands for ALP object 'xALP_DatosCursos'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

AL_RemoveArrays (xALP_DatosCursos;1;7)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_DatosCursos;1;1;"at_Mineduc_Nivel")
$Error:=AL_SetArraysNam (xALP_DatosCursos;2;1;"at_Mineduc_LetraCurso")
$Error:=AL_SetArraysNam (xALP_DatosCursos;3;1;"ai_Mineduc_Dias")
$Error:=AL_SetArraysNam (xALP_DatosCursos;4;1;"ai_Mineduc_MatriculaCursos")
$Error:=AL_SetArraysNam (xALP_DatosCursos;5;1;"ai_Mineduc_AltasCursos")
$Error:=AL_SetArraysNam (xALP_DatosCursos;6;1;"ai_Mineduc_BajasCursos")
$Error:=AL_SetArraysNam (xALP_DatosCursos;7;1;"ai_Mineduc_AsistCursos")
$Error:=AL_SetArraysNam (xALP_DatosCursos;8;1;"ai_Mineduc_NivelCurso")

  //column 1 settings
AL_SetHeaders (xALP_DatosCursos;1;1;__ ("Nivel"))
AL_SetWidths (xALP_DatosCursos;1;1;110)
AL_SetFormat (xALP_DatosCursos;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_DatosCursos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DatosCursos;1;"Tahoma";9;0)
AL_SetStyle (xALP_DatosCursos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_DatosCursos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DatosCursos;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_DatosCursos;1;0)
AL_SetEntryCtls (xALP_DatosCursos;1;0)

  //column 2 settings
AL_SetHeaders (xALP_DatosCursos;2;1;__ ("Curso"))
AL_SetWidths (xALP_DatosCursos;2;1;50)
AL_SetFormat (xALP_DatosCursos;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_DatosCursos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DatosCursos;2;"Tahoma";9;0)
AL_SetStyle (xALP_DatosCursos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_DatosCursos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DatosCursos;2;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_DatosCursos;2;0)
AL_SetEntryCtls (xALP_DatosCursos;2;0)

  //column 3 settings
AL_SetHeaders (xALP_DatosCursos;3;1;__ ("Días"))
AL_SetWidths (xALP_DatosCursos;3;1;40)
AL_SetFormat (xALP_DatosCursos;3;"";0;2;0;0)
AL_SetHdrStyle (xALP_DatosCursos;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DatosCursos;3;"Tahoma";9;0)
AL_SetStyle (xALP_DatosCursos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_DatosCursos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DatosCursos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DatosCursos;3;1)
AL_SetEntryCtls (xALP_DatosCursos;3;0)

  //column 4 settings
AL_SetHeaders (xALP_DatosCursos;4;1;__ ("Matrícula"))
AL_SetWidths (xALP_DatosCursos;4;1;60)
AL_SetFormat (xALP_DatosCursos;4;"";0;2;0;0)
AL_SetHdrStyle (xALP_DatosCursos;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DatosCursos;4;"Tahoma";9;0)
AL_SetStyle (xALP_DatosCursos;4;"Tahoma";9;0)
AL_SetForeColor (xALP_DatosCursos;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DatosCursos;4;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_DatosCursos;4;0)
AL_SetEntryCtls (xALP_DatosCursos;4;0)

  //column 5 settings
AL_SetHeaders (xALP_DatosCursos;5;1;__ ("Altas"))
AL_SetWidths (xALP_DatosCursos;5;1;50)
AL_SetFormat (xALP_DatosCursos;5;"";0;2;0;0)
AL_SetHdrStyle (xALP_DatosCursos;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DatosCursos;5;"Tahoma";9;0)
AL_SetStyle (xALP_DatosCursos;5;"Tahoma";9;0)
AL_SetForeColor (xALP_DatosCursos;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DatosCursos;5;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_DatosCursos;5;0)
AL_SetEntryCtls (xALP_DatosCursos;5;0)

  //column 6 settings
AL_SetHeaders (xALP_DatosCursos;6;1;__ ("Bajas"))
AL_SetWidths (xALP_DatosCursos;6;1;50)
AL_SetFormat (xALP_DatosCursos;6;"";0;2;0;0)
AL_SetHdrStyle (xALP_DatosCursos;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DatosCursos;6;"Tahoma";9;0)
AL_SetStyle (xALP_DatosCursos;6;"Tahoma";9;0)
AL_SetForeColor (xALP_DatosCursos;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DatosCursos;6;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_DatosCursos;6;0)
AL_SetEntryCtls (xALP_DatosCursos;6;0)

  //column 7 settings
AL_SetHeaders (xALP_DatosCursos;7;1;__ ("Asistencia"))
AL_SetWidths (xALP_DatosCursos;7;1;60)
AL_SetFormat (xALP_DatosCursos;7;"";0;2;0;0)
AL_SetHdrStyle (xALP_DatosCursos;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DatosCursos;7;"Tahoma";9;0)
AL_SetStyle (xALP_DatosCursos;7;"Tahoma";9;0)
AL_SetForeColor (xALP_DatosCursos;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DatosCursos;7;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_DatosCursos;7;0)
AL_SetEntryCtls (xALP_DatosCursos;7;0)

  //general options

AL_SetColOpts (xALP_DatosCursos;1;1;1;1;0)
AL_SetRowOpts (xALP_DatosCursos;0;0;0;0;1;0)
AL_SetCellOpts (xALP_DatosCursos;0;1;1)
AL_SetMiscOpts (xALP_DatosCursos;0;0;"\\";0;1)
AL_SetMiscColor (xALP_DatosCursos;0;"White";0)
AL_SetMiscColor (xALP_DatosCursos;1;"White";0)
AL_SetMiscColor (xALP_DatosCursos;2;"White";0)
AL_SetMiscColor (xALP_DatosCursos;3;"White";0)
AL_SetMainCalls (xALP_DatosCursos;"";"")
AL_SetScroll (xALP_DatosCursos;0;-3)
AL_SetCopyOpts (xALP_DatosCursos;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_DatosCursos;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_DatosCursos;2;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_DatosCursos;1;2;1;1;2)
AL_SetDividers (xALP_DatosCursos;"Black";"Gray";0;"Black";"Gray";0)
AL_SetDrgOpts (xALP_DatosCursos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_DatosCursos;1;"";"";"")
AL_SetDrgSrc (xALP_DatosCursos;2;"";"";"")
AL_SetDrgSrc (xALP_DatosCursos;3;"";"";"")
AL_SetDrgDst (xALP_DatosCursos;1;"";"";"")
AL_SetDrgDst (xALP_DatosCursos;1;"";"";"")
AL_SetDrgDst (xALP_DatosCursos;1;"";"";"")
