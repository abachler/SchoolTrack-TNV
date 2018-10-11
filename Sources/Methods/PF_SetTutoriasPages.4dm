//%attributes = {}
  //PF_SetTutoriasPages
  //TUTORIA NOTAS
C_LONGINT:C283($Error;$ALcol;$numperiodos)
  //$gradesColWidth:=30
$gradesFormat:=""
$numperiodos:=Size of array:C274(atSTR_Periodos_Nombre)
$gradesColWidth:=200/($numperiodos+4)  //ticket 158250 

$Error:=AL_SetArraysNam (xALP_Tutoria1;1;1;"aNtaInternalName")
AL_SetHeaders (xALP_Tutoria1;1;1;__ ("Asignatura"))
AL_SetWidths (xALP_Tutoria1;1;1;250)
AL_SetFormat (xALP_Tutoria1;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Tutoria1;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Tutoria1;1;"Tahoma";9;0)
AL_SetStyle (xALP_Tutoria1;1;"Tahoma";9;1)
AL_SetForeColor (xALP_Tutoria1;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Tutoria1;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Tutoria1;1;0)
AL_SetEntryCtls (xALP_Tutoria1;1;0)

$Error:=AL_SetArraysNam (xALP_Tutoria1;2;1;"aNtaP1")
AL_SetHeaders (xALP_Tutoria1;2;1;__ ("P1"))
AL_SetFormat (xALP_Tutoria1;2;$gradesFormat;0;0;0;0)
AL_SetWidths (xALP_Tutoria1;2;1;$gradesColWidth)
AL_SetHdrStyle (xALP_Tutoria1;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Tutoria1;2;"Tahoma";9;0)
AL_SetStyle (xALP_Tutoria1;2;"Tahoma";9;1)
AL_SetForeColor (xALP_Tutoria1;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Tutoria1;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Tutoria1;2;0)
AL_SetEntryCtls (xALP_Tutoria1;2;0)

$ALcol:=2

If ($numperiodos>=2)
	$ALcol:=$ALcol+1
	$Error:=AL_SetArraysNam (xALP_Tutoria1;$ALcol;1;"aNtaP2")
	AL_SetHeaders (xALP_Tutoria1;$ALcol;1;__ ("P2"))
	AL_SetWidths (xALP_Tutoria1;$ALcol;1;$gradesColWidth)
	AL_SetFormat (xALP_Tutoria1;$ALcol;$gradesFormat;0;0;0;0)
	AL_SetHdrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;0)
	AL_SetStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
	AL_SetForeColor (xALP_Tutoria1;$ALcol;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_Tutoria1;$ALcol;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_Tutoria1;$ALcol;0)
	AL_SetEntryCtls (xALP_Tutoria1;$ALcol;0)
	
End if 

If ($numperiodos>=3)
	$ALcol:=$ALcol+1
	$Error:=AL_SetArraysNam (xALP_Tutoria1;$ALcol;1;"aNtaP3")
	AL_SetHeaders (xALP_Tutoria1;$ALcol;1;__ ("P3"))
	AL_SetWidths (xALP_Tutoria1;$ALcol;1;$gradesColWidth)
	AL_SetFormat (xALP_Tutoria1;$ALcol;$gradesFormat;0;0;0;0)
	AL_SetHdrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;0)
	AL_SetStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
	AL_SetForeColor (xALP_Tutoria1;$ALcol;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_Tutoria1;$ALcol;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_Tutoria1;$ALcol;0)
	AL_SetEntryCtls (xALP_Tutoria1;$ALcol;0)
	
End if 

If ($numperiodos>=4)
	$ALcol:=$ALcol+1
	$Error:=AL_SetArraysNam (xALP_Tutoria1;$ALcol;1;"aNtaP4")
	AL_SetHeaders (xALP_Tutoria1;$ALcol;1;__ ("P4"))
	AL_SetWidths (xALP_Tutoria1;$ALcol;1;$gradesColWidth)
	AL_SetFormat (xALP_Tutoria1;$ALcol;$gradesFormat;0;0;0;0)
	AL_SetHdrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;0)
	AL_SetStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
	AL_SetForeColor (xALP_Tutoria1;$ALcol;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_Tutoria1;$ALcol;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_Tutoria1;$ALcol;0)
	AL_SetEntryCtls (xALP_Tutoria1;$ALcol;0)
	
End if 

If ($numperiodos>=5)
	$ALcol:=$ALcol+1
	$Error:=AL_SetArraysNam (xALP_Tutoria1;$ALcol;1;"aNtaP5")
	AL_SetHeaders (xALP_Tutoria1;$ALcol;1;__ ("P5"))
	AL_SetWidths (xALP_Tutoria1;$ALcol;1;$gradesColWidth)
	AL_SetFormat (xALP_Tutoria1;$ALcol;$gradesFormat;0;0;0;0)
	AL_SetHdrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;0)
	AL_SetStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
	AL_SetForeColor (xALP_Tutoria1;$ALcol;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_Tutoria1;$ALcol;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_Tutoria1;$ALcol;0)
	AL_SetEntryCtls (xALP_Tutoria1;$ALcol;0)
	
End if 

$ALcol:=$ALcol+1
$Error:=AL_SetArraysNam (xALP_Tutoria1;$ALcol;1;"aNtaPF")
AL_SetHeaders (xALP_Tutoria1;$ALcol;1;__ ("PA"))
AL_SetWidths (xALP_Tutoria1;$ALcol;1;$gradesColWidth)
AL_SetFormat (xALP_Tutoria1;$ALcol;$gradesFormat;0;0;0;0)
AL_SetHdrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;0)
AL_SetStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;0)
AL_SetForeColor (xALP_Tutoria1;$ALcol;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Tutoria1;$ALcol;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Tutoria1;$ALcol;0)
AL_SetEntryCtls (xALP_Tutoria1;$ALcol;0)

$ALcol:=$ALcol+1
$Error:=AL_SetArraysNam (xALP_Tutoria1;$ALcol;1;"aNtaEX")
AL_SetHeaders (xALP_Tutoria1;$ALcol;1;__ ("EX"))
AL_SetWidths (xALP_Tutoria1;$ALcol;1;$gradesColWidth)
AL_SetFormat (xALP_Tutoria1;$ALcol;$gradesFormat;0;0;0;0)
AL_SetHdrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;0)
AL_SetStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;2)
AL_SetForeColor (xALP_Tutoria1;$ALcol;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Tutoria1;$ALcol;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Tutoria1;$ALcol;0)
AL_SetEntryCtls (xALP_Tutoria1;$ALcol;0)

$ALcol:=$ALcol+1
$Error:=AL_SetArraysNam (xALP_Tutoria1;$ALcol;1;"aNtaF")
AL_SetHeaders (xALP_Tutoria1;$ALcol;1;__ ("NF"))
AL_SetWidths (xALP_Tutoria1;$ALcol;1;$gradesColWidth)
AL_SetFormat (xALP_Tutoria1;$ALcol;$gradesFormat;0;0;0;0)
AL_SetHdrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;0)
AL_SetStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
AL_SetForeColor (xALP_Tutoria1;$ALcol;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Tutoria1;$ALcol;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Tutoria1;$ALcol;0)
AL_SetEntryCtls (xALP_Tutoria1;$ALcol;0)

$ALcol:=$ALcol+1
$Error:=AL_SetArraysNam (xALP_Tutoria1;$ALcol;1;"aStrAsgAverage")
AL_SetHeaders (xALP_Tutoria1;$ALcol;1;__ ("GR"))
AL_SetWidths (xALP_Tutoria1;$ALcol;1;$gradesColWidth)
AL_SetFormat (xALP_Tutoria1;$ALcol;$gradesFormat;0;0;0;0)
AL_SetHdrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;0)
AL_SetStyle (xALP_Tutoria1;$ALcol;"Tahoma";9;2)
AL_SetForeColor (xALP_Tutoria1;$ALcol;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Tutoria1;$ALcol;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Tutoria1;$ALcol;0)
AL_SetEntryCtls (xALP_Tutoria1;$ALcol;0)

ALP_SetDefaultAppareance (xALP_Tutoria1;9;1;6;1;8)
AL_SetColOpts (xALP_Tutoria1;0;1;1;0;0)
AL_SetRowOpts (xALP_Tutoria1;0;0;0;0;1;1)
AL_SetCellOpts (xALP_Tutoria1;0;1;1)
AL_SetMiscOpts (xALP_Tutoria1;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Tutoria1;"";"")
AL_SetScroll (xALP_Tutoria1;0;0)
AL_SetEntryOpts (xALP_Tutoria1;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetColLock (xALP_Tutoria1;1)
AL_SetDrgOpts (xALP_Tutoria1;0;30;0)


  //TUTORIA ENTREVISTAS
  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Tutoria2;1;1;"aInterviewDate")
$Error:=AL_SetArraysNam (xALP_Tutoria2;2;1;"aInterviewPerson")
$Error:=AL_SetArraysNam (xALP_Tutoria2;3;1;"aInterviewRecNo")

  //column 1 settings
AL_SetHeaders (xALP_Tutoria2;1;1;__ ("Fecha"))
AL_SetFormat (xALP_Tutoria2;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Tutoria2;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Tutoria2;1;"Tahoma";9;0)
AL_SetStyle (xALP_Tutoria2;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Tutoria2;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Tutoria2;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Tutoria2;1;0)
AL_SetEntryCtls (xALP_Tutoria2;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Tutoria2;2;1;__ ("Interlocutor"))
AL_SetFormat (xALP_Tutoria2;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Tutoria2;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Tutoria2;2;"Tahoma";9;0)
AL_SetStyle (xALP_Tutoria2;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Tutoria2;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Tutoria2;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Tutoria2;2;0)
AL_SetEntryCtls (xALP_Tutoria2;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_Tutoria2;9;1;6;1;8)
AL_SetColOpts (xALP_Tutoria2;1;1;1;1;0)
AL_SetRowOpts (xALP_Tutoria2;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Tutoria2;0;1;1)
AL_SetMiscOpts (xALP_Tutoria2;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Tutoria2;"";"")
AL_SetScroll (xALP_Tutoria2;0;0)
AL_SetEntryOpts (xALP_Tutoria2;1;0;0;1;0;<>tXS_RS_DecimalSeparator)


  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Tutoria3;1;1;"aObsPeriodos")
$Error:=AL_SetArraysNam (xALP_Tutoria3;2;1;"aObsText")

  //column 1 settings
AL_SetHeaders (xALP_Tutoria3;1;1;__ ("Periodo"))
AL_SetWidths (xALP_Tutoria3;1;1;50)
AL_SetFormat (xALP_Tutoria3;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Tutoria3;1;"Tahoma";9;1)
AL_SetStyle (xALP_Tutoria3;1;"Tahoma";9;0)
AL_SetEnterable (xALP_Tutoria3;1;0)


  //column 2 settings
AL_SetHeaders (xALP_Tutoria3;2;1;__ ("Observaciones"))
AL_SetWidths (xALP_Tutoria3;2;1;390)
AL_SetFormat (xALP_Tutoria3;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Tutoria3;2;"Tahoma";9;1)
AL_SetStyle (xALP_Tutoria3;2;"Tahoma";9;0)
AL_SetEnterable (xALP_Tutoria3;2;1)


  //general options
ALP_SetDefaultAppareance (xALP_Tutoria3;9;7;6;1;8)
AL_SetColOpts (xALP_Tutoria3;1;1;1;0;0)
AL_SetRowOpts (xALP_Tutoria3;0;0;0;0;1;0)
AL_SetEntryOpts (xALP_Tutoria3;3;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetCallbacks (xALP_Tutoria3;"xalCB_EN_TutoriasProfesores";"xalCB_EX_TutoriasProfesores")
