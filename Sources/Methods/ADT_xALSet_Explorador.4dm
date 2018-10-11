//%attributes = {}
  //ADT_xALSet_Explorador

AL_RemoveFields (xALP_Postulaciones;1;20)

  //Configuration commands for ALP object 'xAL_Postulaciones'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)
  //specify fields to display
$Error:=AL_SetFile (xALP_Postulaciones;Table:C252(->[ADT_Candidatos:49]))  //[Alumnos]
$Error:=AL_SetFields (xALP_Postulaciones;2;1;1;40)  //[Alumnos]Nombre Completo
$Error:=AL_SetFields (xALP_Postulaciones;2;2;1;49)  //[Alumnos]Sexo
$Error:=AL_SetFields (xALP_Postulaciones;2;3;1;7)  //[Alumnos]Nacido el
$Error:=AL_SetFields (xALP_Postulaciones;2;4;1;5)  //[Alumnos]RUT
$Error:=AL_SetFields (xALP_Postulaciones;49;5;1;21)  //[Datos_Postulación]Grupo
$Error:=AL_SetFields (xALP_Postulaciones;49;6;1;13)  //Datos_Postulación]Calificación entrevista
$Error:=AL_SetFields (xALP_Postulaciones;49;7;1;15)  //Datos_Postulación]puntaje
$Error:=AL_SetFields (xALP_Postulaciones;49;8;1;38)  //Datos_Postulación]Ev conductual
$Error:=AL_SetFields (xALP_Postulaciones;49;9;1;16)  //Datos_Postulación]situación final

  //column 1 settings
AL_SetHeaders (xALP_Postulaciones;1;1;"Nombre del postulante")
AL_SetFormat (xALP_Postulaciones;1;"";0;1;0;0)
AL_SetHdrStyle (xALP_Postulaciones;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulaciones;1;"Tahoma";9;0)
AL_SetStyle (xALP_Postulaciones;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulaciones;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulaciones;1;"White";0;"";242;"White";0)
AL_SetEnterable (xALP_Postulaciones;1;0)
AL_SetEntryCtls (xALP_Postulaciones;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Postulaciones;2;1;"Sexo")
AL_SetFormat (xALP_Postulaciones;2;"";0;1;0;0)
AL_SetHdrStyle (xALP_Postulaciones;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulaciones;2;"Tahoma";9;0)
AL_SetStyle (xALP_Postulaciones;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulaciones;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulaciones;2;"White";0;"";242;"White";0)
AL_SetEnterable (xALP_Postulaciones;2;0)
AL_SetEntryCtls (xALP_Postulaciones;2;0)
AL_SetWidths (xALP_Postulaciones;2;1;32)

  //column 3 settings
AL_SetHeaders (xALP_Postulaciones;3;1;"Nacido el")
AL_SetFormat (xALP_Postulaciones;3;"7";0;0;0;0)
AL_SetHdrStyle (xALP_Postulaciones;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulaciones;3;"Tahoma";9;0)
AL_SetStyle (xALP_Postulaciones;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulaciones;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulaciones;3;"White";0;"";242;"White";0)
AL_SetEnterable (xALP_Postulaciones;3;0)
AL_SetEntryCtls (xALP_Postulaciones;3;0)
AL_SetWidths (xALP_Postulaciones;3;1;70)

  //column 4 settings
AL_SetHeaders (xALP_Postulaciones;4;1;"RUT")
AL_SetFormat (xALP_Postulaciones;4;"###.###.###-#";0;0;0;0)
AL_SetHdrStyle (xALP_Postulaciones;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulaciones;4;"Tahoma";9;0)
AL_SetStyle (xALP_Postulaciones;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulaciones;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulaciones;4;"White";0;"";242;"White";0)
AL_SetEnterable (xALP_Postulaciones;4;0)
AL_SetEntryCtls (xALP_Postulaciones;4;0)
AL_SetWidths (xALP_Postulaciones;4;1;75)

  //column 5 settings
AL_SetHeaders (xALP_Postulaciones;5;1;"Grupo")
AL_SetFormat (xALP_Postulaciones;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_Postulaciones;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulaciones;5;"Tahoma";9;0)
AL_SetStyle (xALP_Postulaciones;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulaciones;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulaciones;5;"White";0;"";242;"White";0)
AL_SetEnterable (xALP_Postulaciones;5;0)
AL_SetEntryCtls (xALP_Postulaciones;5;0)
AL_SetWidths (xALP_Postulaciones;5;1;70)

  //column 6 settings
AL_SetHeaders (xALP_Postulaciones;6;1;"Cal. Entr.")
AL_SetWidths (xALP_Postulaciones;6;1;60)
AL_SetFormat (xALP_Postulaciones;6;"";0;0;0;0)
AL_SetHdrStyle (xALP_Postulaciones;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulaciones;6;"Tahoma";9;0)
AL_SetStyle (xALP_Postulaciones;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulaciones;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulaciones;6;"White";0;"";242;"White";0)
AL_SetEnterable (xALP_Postulaciones;6;0)  //asPST_CalifIiew
  //AL_SetEntryCtls (xAL_Postulaciones;6;0)

  //column 7 settings
<>vsPST_ExamEvalFormat:=("0"*Length:C16(String:C10(Int:C8(<>vrPST_maxPoints))))+","+("0"*<>vrPST_precision)
AL_SetHeaders (xALP_Postulaciones;7;1;"Puntaje")
AL_SetWidths (xALP_Postulaciones;7;1;50)
AL_SetFormat (xALP_Postulaciones;7;<>vsPST_ExamEvalFormat;0;0;0;0)
AL_SetHdrStyle (xALP_Postulaciones;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulaciones;7;"Tahoma";9;0)
AL_SetStyle (xALP_Postulaciones;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulaciones;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulaciones;7;"White";0;"";242;"White";0)
AL_SetEnterable (xALP_Postulaciones;7;0)
  //AL_SetEntryCtls (xAL_Postulaciones;7;0)


  //column 8 settings
<>vsPST_ExamEvalFormat:=("0"*Length:C16(String:C10(Int:C8(<>vrPST_maxEvConductual))))+","+("0"*<>vrPST_precisionEvConductual)
AL_SetHeaders (xALP_Postulaciones;8;1;"Conducta")
AL_SetWidths (xALP_Postulaciones;8;1;80)
AL_SetFormat (xALP_Postulaciones;8;<>vsPST_EvConductualFormat;0;0;0;0)
AL_SetHdrStyle (xALP_Postulaciones;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulaciones;8;"Tahoma";9;0)
AL_SetStyle (xALP_Postulaciones;8;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulaciones;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulaciones;8;"White";0;"";242;"White";0)
AL_SetEnterable (xALP_Postulaciones;8;0)  //asPST_FinalSit
  //AL_SetEntryCtls (xAL_Postulaciones;8;0)


  //column 9 settings
AL_SetHeaders (xALP_Postulaciones;9;1;"Sit. Final")
AL_SetWidths (xALP_Postulaciones;9;1;80)
AL_SetFormat (xALP_Postulaciones;9;"";0;0;0;0)
AL_SetHdrStyle (xALP_Postulaciones;9;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulaciones;9;"Tahoma";9;0)
AL_SetStyle (xALP_Postulaciones;9;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulaciones;9;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulaciones;9;"White";0;"";242;"White";0)
AL_SetEnterable (xALP_Postulaciones;9;0)  //asPST_FinalSit
  //AL_SetEntryCtls (xAL_Postulaciones;9;0)

  //general options

AL_SetColOpts (xALP_Postulaciones;1;1;1;0;0)
AL_SetRowOpts (xALP_Postulaciones;1;1;1;0;1;0)
AL_SetCellOpts (xALP_Postulaciones;0;1;1)
AL_SetMiscOpts (xALP_Postulaciones;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Postulaciones;0;"White";0)
AL_SetMiscColor (xALP_Postulaciones;1;"White";0)
AL_SetMiscColor (xALP_Postulaciones;2;"White";0)
AL_SetMiscColor (xALP_Postulaciones;3;"White";0)
AL_SetMainCalls (xALP_Postulaciones;"";"")
AL_SetScroll (xALP_Postulaciones;0;0)
AL_SetCopyOpts (xALP_Postulaciones;0;"\t";"\r")
AL_SetSortOpts (xALP_Postulaciones;0;1;0;"Select the columns to sort:";0)
AL_SetSort (xALP_Postulaciones;1)
AL_SetEntryOpts (xALP_Postulaciones;1;0;0;1;0;<>tXS_RS_DecimalSeparator;1)
AL_SetHeight (xALP_Postulaciones;2;2;1;1;2)
AL_SetDividers (xALP_Postulaciones;"Black";"Gray";0;"Black";"Gray";0)
AL_SetColLock (xALP_Postulaciones;1)
AL_SetDrgOpts (xALP_Postulaciones;0;30;0)

  //dragging options
AL_SetDrgSrc (xALP_Postulaciones;1;"";"";"")
AL_SetDrgSrc (xALP_Postulaciones;2;"";"";"")
AL_SetDrgSrc (xALP_Postulaciones;3;"";"";"")
AL_SetDrgDst (xALP_Postulaciones;1;"";"";"")
AL_SetDrgDst (xALP_Postulaciones;1;"";"";"")
AL_SetDrgDst (xALP_Postulaciones;1;"";"";"")



  //Configuration commands for ALP object 'xALP_Groups'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Groups;1;1;"atPST_SelEXmGroupNames")
$Error:=AL_SetArraysNam (xALP_Groups;2;1;"aLPST_SelEXmTime")
$Error:=AL_SetArraysNam (xALP_Groups;3;1;"aLPST_SelEXmID")
$Error:=AL_SetArraysNam (xALP_Groups;4;1;"alPST_SelEXmSecs")
$Error:=AL_SetArraysNam (xALP_Groups;5;1;"adPST_SelEXmDate")

  //column 1 settings
AL_SetHeaders (xALP_Groups;1;1;"Grupo")
AL_SetWidths (xALP_Groups;1;1;112)
AL_SetFormat (xALP_Groups;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Groups;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Groups;1;"Tahoma";9;0)
AL_SetStyle (xALP_Groups;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Groups;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Groups;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Groups;1;0)
AL_SetEntryCtls (xALP_Groups;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Groups;2;1;"Hora")
AL_SetWidths (xALP_Groups;2;1;40)
AL_SetFormat (xALP_Groups;2;"&/2";0;0;0;0)
AL_SetHdrStyle (xALP_Groups;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Groups;2;"Tahoma";9;0)
AL_SetStyle (xALP_Groups;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Groups;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Groups;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Groups;2;1)
AL_SetEntryCtls (xALP_Groups;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Groups;3;1;"ID")
AL_SetFormat (xALP_Groups;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Groups;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Groups;3;"Tahoma";9;0)
AL_SetStyle (xALP_Groups;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Groups;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Groups;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Groups;3;1)
AL_SetEntryCtls (xALP_Groups;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Groups;4;1;"secs")
AL_SetFormat (xALP_Groups;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Groups;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Groups;4;"Tahoma";9;0)
AL_SetStyle (xALP_Groups;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Groups;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Groups;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Groups;4;1)
AL_SetEntryCtls (xALP_Groups;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Groups;5;1;"date")
AL_SetFormat (xALP_Groups;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_Groups;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Groups;5;"Tahoma";9;0)
AL_SetStyle (xALP_Groups;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Groups;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Groups;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Groups;5;1)
AL_SetEntryCtls (xALP_Groups;5;0)

  //general options

AL_SetColOpts (xALP_Groups;1;1;1;3;0)
AL_SetRowOpts (xALP_Groups;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Groups;0;1;1)
AL_SetMiscOpts (xALP_Groups;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Groups;0;"White";0)
AL_SetMiscColor (xALP_Groups;1;"White";0)
AL_SetMiscColor (xALP_Groups;2;"White";0)
AL_SetMiscColor (xALP_Groups;3;"White";0)
AL_SetMainCalls (xALP_Groups;"";"")
AL_SetScroll (xALP_Groups;0;-3)
AL_SetCopyOpts (xALP_Groups;0;"\t";"\r")
AL_SetSortOpts (xALP_Groups;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Groups;3;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Groups;1;2;1;1;2)
AL_SetDividers (xALP_Groups;"Black";"Gray";0;"Black";"Gray";0)
AL_SetDrgOpts (xALP_Groups;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Groups;1;"";"";"")
AL_SetDrgSrc (xALP_Groups;2;"";"";"")
AL_SetDrgSrc (xALP_Groups;3;"";"";"")
AL_SetDrgDst (xALP_Groups;1;"";"";"")
AL_SetDrgDst (xALP_Groups;1;"";"";"")
AL_SetDrgDst (xALP_Groups;1;"";"";"")




  //Configuration commands for ALP object 'xALP_Sections'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify fields to display
$Error:=AL_SetFile (xALP_Sections;Table:C252(->[ADT_Examenes:122]))  //[ADT_Examenes]
$Error:=AL_SetFields (xALP_Sections;122;1;1;7)  //[ADT_Examenes]Section
$Error:=AL_SetFields (xALP_Sections;122;2;1;5)  //[ADT_Examenes]Responsable
$Error:=AL_SetFields (xALP_Sections;122;3;1;9)  //[ADT_Examenes]Girls
$Error:=AL_SetFields (xALP_Sections;122;4;1;10)  //[ADT_Examenes]Boys
$Error:=AL_SetFields (xALP_Sections;122;5;1;11)  //[ADT_Examenes]Total
$Error:=AL_SetFields (xALP_Sections;122;6;1;1)  //[ADT_Examenes]ID
$Error:=AL_SetFields (xALP_Sections;122;7;1;8)  //[ADT_Examenes]Secs

  //column 1 settings
AL_SetHeaders (xALP_Sections;1;1;"S")
AL_SetWidths (xALP_Sections;1;1;20)
AL_SetFormat (xALP_Sections;1;"";2;2;0;0)
AL_SetHdrStyle (xALP_Sections;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;1;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;1;"Tahoma";9;1)
AL_SetForeColor (xALP_Sections;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;1;0)
AL_SetEntryCtls (xALP_Sections;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Sections;2;1;"Examinador")
AL_SetWidths (xALP_Sections;2;1;122)
AL_SetFormat (xALP_Sections;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_Sections;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;2;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;2;1)
AL_SetEntryCtls (xALP_Sections;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Sections;3;1;"M")
AL_SetWidths (xALP_Sections;3;1;20)
AL_SetFormat (xALP_Sections;3;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_Sections;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;3;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;3;0)
AL_SetEntryCtls (xALP_Sections;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Sections;4;1;"H")
AL_SetWidths (xALP_Sections;4;1;20)
AL_SetFormat (xALP_Sections;4;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_Sections;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;4;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;4;0)
AL_SetEntryCtls (xALP_Sections;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Sections;5;1;"T")
AL_SetWidths (xALP_Sections;5;1;20)
AL_SetFormat (xALP_Sections;5;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_Sections;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;5;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;5;0)
AL_SetEntryCtls (xALP_Sections;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Sections;6;1;"ID")
AL_SetFormat (xALP_Sections;6;"";0;0;0;0)
AL_SetHdrStyle (xALP_Sections;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;6;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;6;0)
AL_SetEntryCtls (xALP_Sections;6;0)

  //column 7 settings
AL_SetHeaders (xALP_Sections;7;1;"secs")
AL_SetFormat (xALP_Sections;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_Sections;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;7;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;7;0)
AL_SetEntryCtls (xALP_Sections;7;0)

  //general options

AL_SetColOpts (xALP_Sections;1;1;1;2;0)
AL_SetRowOpts (xALP_Sections;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Sections;0;1;1)
AL_SetMiscOpts (xALP_Sections;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Sections;0;"White";0)
AL_SetMiscColor (xALP_Sections;1;"White";0)
AL_SetMiscColor (xALP_Sections;2;"White";0)
AL_SetMiscColor (xALP_Sections;3;"White";0)
AL_SetMainCalls (xALP_Sections;"";"")
AL_SetScroll (xALP_Sections;0;-3)
AL_SetCopyOpts (xALP_Sections;0;"\t";"\r")
AL_SetSortOpts (xALP_Sections;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Sections;3;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Sections;1;2;1;1;2)
AL_SetDividers (xALP_Sections;"Black";"Gray";0;"Black";"Gray";0)
AL_SetDrgOpts (xALP_Sections;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Sections;1;"";"";"")
AL_SetDrgSrc (xALP_Sections;2;"";"";"")
AL_SetDrgSrc (xALP_Sections;3;"";"";"")
AL_SetDrgDst (xALP_Sections;1;"inscritos";"";"")
AL_SetDrgDst (xALP_Sections;1;"";"";"")
AL_SetDrgDst (xALP_Sections;1;"";"";"")




  //Configuration commands for ALP object 'xALP_Postulantes'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify fields to display
$Error:=AL_SetFile (xALP_Postulantes;Table:C252(->[ADT_Candidatos:49]))  //[ADT_Candidatos]
$Error:=AL_SetFields (xALP_Postulantes;2;1;1;40)  //[Alumnos]Apellidos_y_Nombres
$Error:=AL_SetFields (xALP_Postulantes;49;2;1;11)  //[ADT_Candidatos]Calificación_Inscripción
$Error:=AL_SetFields (xALP_Postulantes;49;3;1;15)  //[ADT_Candidatos]Puntaje_examen
$Error:=AL_SetFields (xALP_Postulantes;49;4;1;16)  //[ADT_Candidatos]Situación_final

  //column 1 settings
AL_SetHeaders (xALP_Postulantes;1;1;"Postulante")
AL_SetWidths (xALP_Postulantes;1;1;200)
AL_SetFormat (xALP_Postulantes;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Postulantes;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulantes;1;"Tahoma";9;0)
AL_SetStyle (xALP_Postulantes;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulantes;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulantes;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Postulantes;1;0)
AL_SetEntryCtls (xALP_Postulantes;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Postulantes;2;1;"Calif.")
AL_SetWidths (xALP_Postulantes;2;1;50)
AL_SetFormat (xALP_Postulantes;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Postulantes;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulantes;2;"Tahoma";9;0)
AL_SetStyle (xALP_Postulantes;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulantes;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulantes;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Postulantes;2;0)
AL_SetEntryCtls (xALP_Postulantes;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Postulantes;3;1;"Puntaje")
AL_SetWidths (xALP_Postulantes;3;1;50)
AL_SetFormat (xALP_Postulantes;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Postulantes;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulantes;3;"Tahoma";9;0)
AL_SetStyle (xALP_Postulantes;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulantes;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulantes;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Postulantes;3;1)
AL_SetEntryCtls (xALP_Postulantes;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Postulantes;4;1;"Situación")
AL_SetWidths (xALP_Postulantes;4;1;80)
AL_SetFormat (xALP_Postulantes;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Postulantes;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulantes;4;"Tahoma";9;0)
AL_SetStyle (xALP_Postulantes;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulantes;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulantes;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Postulantes;4;1)
AL_SetEntryCtls (xALP_Postulantes;4;0)

  //general options

AL_SetColOpts (xALP_Postulantes;1;1;1;0;0)
AL_SetRowOpts (xALP_Postulantes;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Postulantes;0;1;1)
AL_SetMiscOpts (xALP_Postulantes;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Postulantes;0;"White";0)
AL_SetMiscColor (xALP_Postulantes;1;"White";0)
AL_SetMiscColor (xALP_Postulantes;2;"White";0)
AL_SetMiscColor (xALP_Postulantes;3;"White";0)
AL_SetMainCalls (xALP_Postulantes;"";"")
AL_SetScroll (xALP_Postulantes;0;0)
AL_SetCopyOpts (xALP_Postulantes;0;"\t";"\r")
AL_SetSortOpts (xALP_Postulantes;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Postulantes;3;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Postulantes;1;2;1;1;2)
AL_SetDividers (xALP_Postulantes;"Black";"Gray";0;"Black";"Gray";0)
AL_SetDrgOpts (xALP_Postulantes;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Postulantes;1;"inscritos";"";"")
AL_SetDrgSrc (xALP_Postulantes;2;"";"";"")
AL_SetDrgSrc (xALP_Postulantes;3;"";"";"")
AL_SetDrgDst (xALP_Postulantes;1;"";"";"")
AL_SetDrgDst (xALP_Postulantes;1;"";"";"")
AL_SetDrgDst (xALP_Postulantes;1;"";"";"")




