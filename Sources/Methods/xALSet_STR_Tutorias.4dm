//%attributes = {}
  //xALSet_STR_Tutorias

  //Configuration commands for ALP object 'xAL_Cursos'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_CursosTutorias;1;1;"aCursos")
$Error:=AL_SetArraysNam (xALP_CursosTutorias;2;1;"aJefes")
$Error:=AL_SetArraysNam (xALP_CursosTutorias;3;1;"aNivelCurso")

  //column 1 settings
AL_SetHeaders (xALP_CursosTutorias;1;1;__ ("Curso"))
AL_SetWidths (xALP_CursosTutorias;1;1;80)
AL_SetFormat (xALP_CursosTutorias;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_CursosTutorias;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CursosTutorias;1;"Tahoma";9;0)
AL_SetStyle (xALP_CursosTutorias;1;"Tahoma";9;0)
AL_SetForeColor (xALP_CursosTutorias;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CursosTutorias;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CursosTutorias;1;0)
AL_SetEntryCtls (xALP_CursosTutorias;1;0)

  //column 2 settings
AL_SetHeaders (xALP_CursosTutorias;2;1;__ ("Profesor jefe"))
AL_SetWidths (xALP_CursosTutorias;2;1;150)
AL_SetFormat (xALP_CursosTutorias;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_CursosTutorias;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CursosTutorias;2;"Tahoma";9;0)
AL_SetStyle (xALP_CursosTutorias;2;"Tahoma";9;0)
AL_SetForeColor (xALP_CursosTutorias;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CursosTutorias;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CursosTutorias;2;0)
AL_SetEntryCtls (xALP_CursosTutorias;2;0)

  //column 3 settings
AL_SetHeaders (xALP_CursosTutorias;3;1;__ ("Nivel"))
AL_SetFormat (xALP_CursosTutorias;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_CursosTutorias;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CursosTutorias;3;"Tahoma";9;0)
AL_SetStyle (xALP_CursosTutorias;3;"Tahoma";9;0)
AL_SetForeColor (xALP_CursosTutorias;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CursosTutorias;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CursosTutorias;3;0)
AL_SetEntryCtls (xALP_CursosTutorias;3;0)

  //general options

AL_SetColOpts (xALP_CursosTutorias;0;0;0;1;0)
AL_SetRowOpts (xALP_CursosTutorias;0;0;0;0;1;0)
AL_SetCellOpts (xALP_CursosTutorias;0;1;1)
AL_SetMiscOpts (xALP_CursosTutorias;0;0;"\\";0;1)
AL_SetMiscColor (xALP_CursosTutorias;0;"White";0)
AL_SetMiscColor (xALP_CursosTutorias;1;"White";0)
AL_SetMiscColor (xALP_CursosTutorias;2;"White";0)
AL_SetMiscColor (xALP_CursosTutorias;3;"White";0)
AL_SetMainCalls (xALP_CursosTutorias;"";"")
AL_SetScroll (xALP_CursosTutorias;0;-3)
AL_SetCopyOpts (xALP_CursosTutorias;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_CursosTutorias;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_CursosTutorias;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_CursosTutorias;1;2;1;1;2)
AL_SetDividers (xALP_CursosTutorias;"Black";"Gray";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_CursosTutorias;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_CursosTutorias;1;"";"";"")
AL_SetDrgSrc (xALP_CursosTutorias;2;"";"";"")
AL_SetDrgSrc (xALP_CursosTutorias;3;"";"";"")
AL_SetDrgDst (xALP_CursosTutorias;1;"";"";"")
AL_SetDrgDst (xALP_CursosTutorias;1;"";"";"")
AL_SetDrgDst (xALP_CursosTutorias;1;"";"";"")




  //Configuration commands for ALP object 'xAL_Profesores'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Profesores;1;1;"aProfesores")
$Error:=AL_SetArraysNam (xALP_Profesores;2;1;"aProfesoresID")

  //column 1 settings
AL_SetHeaders (xALP_Profesores;1;1;__ ("Profesores"))
AL_SetFormat (xALP_Profesores;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Profesores;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Profesores;1;"Tahoma";9;0)
AL_SetStyle (xALP_Profesores;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Profesores;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Profesores;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Profesores;1;0)
AL_SetEntryCtls (xALP_Profesores;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Profesores;2;1;"Column 2")
AL_SetFormat (xALP_Profesores;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Profesores;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Profesores;2;"Tahoma";9;0)
AL_SetStyle (xALP_Profesores;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Profesores;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Profesores;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Profesores;2;1)
AL_SetEntryCtls (xALP_Profesores;2;0)

  //general options

AL_SetColOpts (xALP_Profesores;0;0;0;1;0)
AL_SetRowOpts (xALP_Profesores;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Profesores;0;1;1)
AL_SetMiscOpts (xALP_Profesores;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Profesores;0;"White";0)
AL_SetMiscColor (xALP_Profesores;1;"White";0)
AL_SetMiscColor (xALP_Profesores;2;"White";0)
AL_SetMiscColor (xALP_Profesores;3;"White";0)
AL_SetMainCalls (xALP_Profesores;"";"")
AL_SetScroll (xALP_Profesores;0;-3)
AL_SetCopyOpts (xALP_Profesores;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Profesores;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Profesores;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Profesores;1;2;1;1;2)
AL_SetDividers (xALP_Profesores;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_Profesores;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Profesores;1;"";"";"")
AL_SetDrgSrc (xALP_Profesores;2;"";"";"")
AL_SetDrgSrc (xALP_Profesores;3;"";"";"")
AL_SetDrgDst (xALP_Profesores;1;"pupilos";"";"")
AL_SetDrgDst (xALP_Profesores;1;"";"";"")
AL_SetDrgDst (xALP_Profesores;1;"";"";"")




  //Configuration commands for ALP object 'xAL_Alumnos'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Alumnos;1;1;"aAlumnos")
$Error:=AL_SetArraysNam (xALP_Alumnos;2;1;"aAlumnosID")

  //column 1 settings
AL_SetHeaders (xALP_Alumnos;1;1;__ ("Alumno"))
AL_SetFormat (xALP_Alumnos;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Alumnos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Alumnos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Alumnos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Alumnos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Alumnos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Alumnos;1;1)
AL_SetEntryCtls (xALP_Alumnos;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Alumnos;2;1;"Column 2")
AL_SetFormat (xALP_Alumnos;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Alumnos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Alumnos;2;"Tahoma";9;0)
AL_SetStyle (xALP_Alumnos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Alumnos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Alumnos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Alumnos;2;0)
AL_SetEntryCtls (xALP_Alumnos;2;0)

  //general options

AL_SetColOpts (xALP_Alumnos;0;0;0;1;0)
AL_SetRowOpts (xALP_Alumnos;1;0;0;0;1;0)
AL_SetCellOpts (xALP_Alumnos;0;1;1)
AL_SetMiscOpts (xALP_Alumnos;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Alumnos;0;"White";0)
AL_SetMiscColor (xALP_Alumnos;1;"White";0)
AL_SetMiscColor (xALP_Alumnos;2;"White";0)
AL_SetMiscColor (xALP_Alumnos;3;"White";0)
AL_SetMainCalls (xALP_Alumnos;"";"")
AL_SetScroll (xALP_Alumnos;0;-3)
AL_SetCopyOpts (xALP_Alumnos;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Alumnos;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Alumnos;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Alumnos;1;2;1;1;2)
AL_SetDividers (xALP_Alumnos;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_Alumnos;0;30;1)

  //dragging options

AL_SetDrgSrc (xALP_Alumnos;1;"tutorias";"";"")
AL_SetDrgSrc (xALP_Alumnos;2;"";"";"")
AL_SetDrgSrc (xALP_Alumnos;3;"";"";"")
AL_SetDrgDst (xALP_Alumnos;1;"pupilos";"";"")
AL_SetDrgDst (xALP_Alumnos;1;"";"";"")
AL_SetDrgDst (xALP_Alumnos;1;"";"";"")




  //Configuration commands for ALP object 'xAL_Tutoria'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Tutoria;1;1;"aPupilos")
$Error:=AL_SetArraysNam (xALP_Tutoria;2;1;"aPupilosID")

  //column 1 settings
AL_SetHeaders (xALP_Tutoria;1;1;__ ("Miembros"))
AL_SetFormat (xALP_Tutoria;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Tutoria;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Tutoria;1;"Tahoma";9;0)
AL_SetStyle (xALP_Tutoria;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Tutoria;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Tutoria;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Tutoria;1;1)
AL_SetEntryCtls (xALP_Tutoria;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Tutoria;2;1;"Column 2")
AL_SetFormat (xALP_Tutoria;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Tutoria;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Tutoria;2;"Tahoma";9;0)
AL_SetStyle (xALP_Tutoria;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Tutoria;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Tutoria;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Tutoria;2;1)
AL_SetEntryCtls (xALP_Tutoria;2;0)

  //general options

AL_SetColOpts (xALP_Tutoria;1;1;1;1;0)
AL_SetRowOpts (xALP_Tutoria;1;0;0;0;1;0)
AL_SetCellOpts (xALP_Tutoria;0;1;1)
AL_SetMiscOpts (xALP_Tutoria;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Tutoria;0;"White";0)
AL_SetMiscColor (xALP_Tutoria;1;"White";0)
AL_SetMiscColor (xALP_Tutoria;2;"White";0)
AL_SetMiscColor (xALP_Tutoria;3;"White";0)
AL_SetMainCalls (xALP_Tutoria;"";"")
AL_SetScroll (xALP_Tutoria;0;0)
AL_SetCopyOpts (xALP_Tutoria;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Tutoria;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Tutoria;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Tutoria;1;2;1;1;2)
AL_SetDividers (xALP_Tutoria;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_Tutoria;0;30;1)

  //dragging options

AL_SetDrgSrc (xALP_Tutoria;1;"pupilos";"";"")
AL_SetDrgSrc (xALP_Tutoria;2;"";"";"")
AL_SetDrgSrc (xALP_Tutoria;3;"";"";"")
AL_SetDrgDst (xALP_Tutoria;1;"tutorias";"tutores";"")
AL_SetDrgDst (xALP_Tutoria;1;"out";"";"")
AL_SetDrgDst (xALP_Tutoria;1;"";"";"")

