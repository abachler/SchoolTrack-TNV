//%attributes = {}
  //xALSet_TMT_Asignaturas

C_LONGINT:C283($Error)

ALP_RemoveAllArrays (xALP_Subsectores)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Subsectores;1;1;"atSTK_Subsectores_ShortName")
$Error:=AL_SetArraysNam (xALP_Subsectores;2;1;"atSTK_Subsectores_LongName")
$Error:=AL_SetArraysNam (xALP_Subsectores;3;1;"atTMT_Subsectores_Curso")
$Error:=AL_SetArraysNam (xALP_Subsectores;4;1;"atSTK_Subsectores_teacherName")
$Error:=AL_SetArraysNam (xALP_Subsectores;5;1;"alSTK_IDSubsectores")

  //column 1 settings
AL_SetHeaders (xALP_Subsectores;1;1;__ ("Abreviación"))
AL_SetWidths (xALP_Subsectores;1;1;100)
AL_SetFormat (xALP_Subsectores;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Subsectores;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Subsectores;1;"Tahoma";9;0)
AL_SetStyle (xALP_Subsectores;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Subsectores;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Subsectores;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Subsectores;1;1)
AL_SetEntryCtls (xALP_Subsectores;1;0)



  //column 2 settings
AL_SetHeaders (xALP_Subsectores;2;1;__ ("Nombre interno"))
AL_SetWidths (xALP_Subsectores;2;2;300)
AL_SetFormat (xALP_Subsectores;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Subsectores;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Subsectores;2;"Tahoma";9;0)
AL_SetStyle (xALP_Subsectores;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Subsectores;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Subsectores;2;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Subsectores;2;1)
AL_SetEntryCtls (xALP_Subsectores;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Subsectores;3;1;__ ("Grupo"))
AL_SetWidths (xALP_Subsectores;3;3;100)
AL_SetFormat (xALP_Subsectores;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Subsectores;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Subsectores;3;"Tahoma";9;0)
AL_SetStyle (xALP_Subsectores;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Subsectores;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Subsectores;3;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Subsectores;3;1)
AL_SetEntryCtls (xALP_Subsectores;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Subsectores;4;1;__ ("Profesor"))
AL_SetWidths (xALP_Subsectores;4;3;200)
AL_SetFormat (xALP_Subsectores;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Subsectores;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Subsectores;4;"Tahoma";9;0)
AL_SetStyle (xALP_Subsectores;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Subsectores;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Subsectores;4;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Subsectores;4;1)
AL_SetEntryCtls (xALP_Subsectores;4;0)

  //column 4 settings
AL_SetHeaders (xALP_Subsectores;5;1;"id (hidden)")
AL_SetFormat (xALP_Subsectores;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_Subsectores;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Subsectores;5;"Tahoma";9;0)
AL_SetStyle (xALP_Subsectores;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Subsectores;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Subsectores;5;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Subsectores;5;1)
AL_SetEntryCtls (xALP_Subsectores;5;0)

  //general options
ALP_SetDefaultAppareance (xALP_Subsectores;11;1;4;1;4)
AL_SetColOpts (xALP_Subsectores;1;1;1;1;0)
AL_SetRowOpts (xALP_Subsectores;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Subsectores;0;1;1)
AL_SetMiscOpts (xALP_Subsectores;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Subsectores;"";"")
AL_SetScroll (xALP_Subsectores;0;0)
AL_SetEntryOpts (xALP_Subsectores;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Subsectores;0;30;0)
AL_SetSort (xALP_Subsectores;2;4;3)
AL_SetInterface (xALP_Subsectores;AL Force OSX Interface;1;1;0;0;1)


  //dragging options

AL_SetDrgSrc (xALP_Subsectores;1;"subsectores";"";"")
AL_SetDrgSrc (xALP_Subsectores;2;"";"";"")
AL_SetDrgSrc (xALP_Subsectores;3;"";"";"")
AL_SetDrgDst (xALP_Subsectores;1;"horario";"";"")
AL_SetDrgDst (xALP_Subsectores;2;"";"";"")
AL_SetDrgDst (xALP_Subsectores;3;"";"";"")

AL_SetLine (xALP_Subsectores;0)