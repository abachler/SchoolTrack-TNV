//%attributes = {}
  //ASsev_AreaSettings


  //DECLARATIONS
C_LONGINT:C283($Error)

  //INITIALIZATION 
Case of 
	: (vi_LastGradeView=Simbolos)
		$colWidth:=33
	: (vi_LastGradeView=Notas)
		$colWidth:=33
	: (vi_LastGradeView=Puntos)
		$l:=Length:C16(String:C10(rPointsTo))
		$colWidth:=33
	: (vi_LastGradeView=Porcentaje)
		$colWidth:=33
End case 
$totalWidthParciales:=$colWidth*12
If ((Not:C34([Asignaturas:18]Seleccion:17)) & (Not:C34([Asignaturas:18]Electiva:11)))
	$colWidthCurso:=1
Else 
	$colWidthCurso:=40
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5>0)
	$colWidthControles:=30
Else 
	$colWidthControles:=0
End if 
$colWidthAlumnos:=693-20-40-$totalWidthParciales-$colWidthCurso-$colWidthControles

  //MAIN CODE
  //enterability settings

If (Application version:C493>="1400")
	$l_iconoEditable:=31995
	$l_iconoNoEditable:=31998
	$nonEnterableIcon:="^"+String:C10($l_iconoNoEditable)
	$enterableIcon:="^"+String:C10($l_iconoEditable)
Else 
	$nonEnterableIcon:="^20006"
	$enterableIcon:="^20005"
End if 

$l_iconoEditable:=8
$l_iconoNoEditable:=9
$l_iconoSubAsignatura:=10
$l_iconoConsolidante:=11

If ((vb_calificacionesEditables) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))  //vb_calificacionesEditables es asignada en AS_PageNotas
	$enterableGrades:=1
	$icono:=$enterableIcon
Else 
	$enterableGrades:=0
	$icono:=$nonEnterableIcon
End if 
$enterableFinalGrades:=0
If (<>vb_BloquearModifSituacionFinal)
	$enterableGrades:=0
	$enterableFinalGrades:=0
End if 

  //specify arrays to display
  //If ([xxSTR_Subasignaturas]ModoControles>0)
AL_RemoveArrays (xALP_SubEvals;1;35)
$Error:=AL_SetArraysNam (xALP_SubEvals;1;1;"aSubEvalOrden")
$Error:=AL_SetArraysNam (xALP_SubEvals;2;1;"aSubEvalStdNme")
$Error:=AL_SetArraysNam (xALP_SubEvals;3;1;"aSubEvalCurso")
$Error:=AL_SetArraysNam (xALP_SubEvals;4;1;"aSubEvalP1")
$Error:=AL_SetArraysNam (xALP_SubEvals;5;1;"aSubEvalControles")
$Error:=AL_SetArraysNam (xALP_SubEvals;6;1;"aSubEval1")
$Error:=AL_SetArraysNam (xALP_SubEvals;7;1;"aSubEval2")
$Error:=AL_SetArraysNam (xALP_SubEvals;8;1;"aSubEval3")
$Error:=AL_SetArraysNam (xALP_SubEvals;9;1;"aSubEval4")
$Error:=AL_SetArraysNam (xALP_SubEvals;10;1;"aSubEval5")
$Error:=AL_SetArraysNam (xALP_SubEvals;11;1;"aSubEval6")
$Error:=AL_SetArraysNam (xALP_SubEvals;12;1;"aSubEval7")
$Error:=AL_SetArraysNam (xALP_SubEvals;13;1;"aSubEval8")
$Error:=AL_SetArraysNam (xALP_SubEvals;14;1;"aSubEval9")
$Error:=AL_SetArraysNam (xALP_SubEvals;15;1;"aSubEval10")
$Error:=AL_SetArraysNam (xALP_SubEvals;16;1;"aSubEval11")
$Error:=AL_SetArraysNam (xALP_SubEvals;17;1;"aSubEval12")
$Error:=AL_SetArraysNam (xALP_SubEvals;18;1;"aSubEvalStatus")
$Error:=AL_SetArraysNam (xALP_SubEvals;19;1;"aSubEvalId")


For ($i;20;31)
	$error:=$error+AL_SetArraysNam (xALP_SubEvals;$i;1;aRealSubEvalArrNames{$i-19})
End for 
$error:=$error+AL_SetArraysNam (xALP_SubEvals;32;1;"aRealSubEvalP1")
$Error:=AL_SetArraysNam (xALP_SubEvals;33;1;"aRealSubEvalControles")
$Error:=AL_SetArraysNam (xALP_SubEvals;34;1;"aRealSubEvalPresentacion")

$Error:=AL_SetArraysNam (xALP_SubEvals;35;1;"aSubEvalSex")

  //column 1 settings
AL_SetHeaders (xALP_SubEvals;1;1;__ ("Nº"))
AL_SetWidths (xALP_SubEvals;1;1;20)
AL_SetFormat (xALP_SubEvals;1;"##";2;0;0;0)
AL_SetHdrStyle (xALP_SubEvals;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SubEvals;1;"Tahoma";9;0)
AL_SetStyle (xALP_SubEvals;1;"Tahoma";9;0)
AL_SetForeColor (xALP_SubEvals;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SubEvals;1;"White";0;"";(16*13)+1;"White";0)
AL_SetEnterable (xALP_SubEvals;1;0)

  //column 2 settings
AL_SetHeaders (xALP_SubEvals;2;1;__ ("Alumno"))
AL_SetWidths (xALP_SubEvals;2;1;$colWidthAlumnos)
AL_SetFormat (xALP_SubEvals;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_SubEvals;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SubEvals;2;"Tahoma";9;0)
AL_SetStyle (xALP_SubEvals;2;"Tahoma";9;0)
AL_SetForeColor (xALP_SubEvals;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SubEvals;2;"White";0;"";(16*13)+1;"White";0)
AL_SetEnterable (xALP_SubEvals;2;0)

  //column 3 settings
AL_SetHeaders (xALP_SubEvals;3;1;__ ("Curso"))
AL_SetWidths (xALP_SubEvals;3;1;$colWidthCurso)
AL_SetFormat (xALP_SubEvals;3;"";2;0;0;0)
AL_SetHdrStyle (xALP_SubEvals;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SubEvals;3;"Tahoma";9;0)
AL_SetStyle (xALP_SubEvals;3;"Tahoma";9;0)
AL_SetForeColor (xALP_SubEvals;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SubEvals;3;"White";0;"";(16*13)+1;"White";0)
AL_SetEnterable (xALP_SubEvals;3;0)

  //column 4 settings
AL_SetWidths (xALP_SubEvals;4;1;40)
AL_SetFormat (xALP_SubEvals;4;"";2;0;0;0)
AL_SetHeaders (xALP_SubEvals;4;1;__ ("Prom."))
AL_SetHdrStyle (xALP_SubEvals;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SubEvals;4;"Tahoma";9;0)
AL_SetStyle (xALP_SubEvals;4;"Tahoma";9;2)
AL_SetForeColor (xALP_SubEvals;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SubEvals;4;"White";0;"";(16*9)+1;"White";0)
AL_SetEnterable (xALP_SubEvals;4;0)

  //column 5 settings
AL_SetWidths (xALP_SubEvals;5;1;$colWidthControles)
AL_SetHeaders (xALP_SubEvals;5;1;__ ("Control"))
AL_SetFormat (xALP_SubEvals;5;"";2;0;0;0)
AL_SetHdrStyle (xALP_SubEvals;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SubEvals;5;"Tahoma";9;0)
AL_SetStyle (xALP_SubEvals;5;"Tahoma";9;2)
AL_SetForeColor (xALP_SubEvals;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SubEvals;5;"White";0;"";(16*9)+1;"White";0)
AL_SetEntryCtls (xALP_SubEvals;5;$enterableGrades)

  //column 18  settings
AL_SetHeaders (xALP_SubEvals;18;1;__ ("Status"))
AL_SetFormat (xALP_SubEvals;18;"";0;0;0;0)
AL_SetHdrStyle (xALP_SubEvals;18;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SubEvals;18;"Tahoma";9;0)
AL_SetStyle (xALP_SubEvals;18;"Tahoma";9;0)
AL_SetForeColor (xALP_SubEvals;18;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SubEvals;18;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SubEvals;18;0)
AL_SetEntryCtls (xALP_SubEvals;18;0)

  //column 19 settings
AL_SetHeaders (xALP_SubEvals;19;1;"ID alumno")
AL_SetFormat (xALP_SubEvals;19;"";0;0;0;0)
AL_SetHdrStyle (xALP_SubEvals;19;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SubEvals;19;"Tahoma";9;0)
AL_SetStyle (xALP_SubEvals;19;"Tahoma";9;0)
AL_SetForeColor (xALP_SubEvals;19;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SubEvals;19;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SubEvals;19;0)
AL_SetEntryCtls (xALP_SubEvals;19;0)

AL_SetRowOpts (xALP_SubEvals;0;1;0;0;1;0)
AL_SetCellOpts (xALP_SubEvals;0;1;1)
AL_SetMiscOpts (xALP_SubEvals;0;0;"\\";0;1)
AL_SetMiscColor (xALP_SubEvals;0;"White";0)
AL_SetMiscColor (xALP_SubEvals;1;"White";0)
AL_SetMiscColor (xALP_SubEvals;2;"White";0)
AL_SetMiscColor (xALP_SubEvals;3;"White";0)
AL_SetMainCalls (xALP_SubEvals;"";"")
AL_SetScroll (xALP_SubEvals;0;0)
AL_SetCopyOpts (xALP_SubEvals;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_SubEvals;0;1;0;"Ordenamiento:";0)
AL_SetEntryOpts (xALP_SubEvals;3;0;0;1;2;<>tXS_RS_DecimalSeparator)
AL_SetCallbacks (xALP_SubEvals;"xALCB_EN_NotasSubasignaturas";"xALCB_EX_NotasSubasignaturas")
AL_SetHeight (xALP_SubEvals;1;1;1;1;2)
AL_SetDividers (xALP_SubEvals;"Black";"Gray";0;"Black";"Light Gray";0)
AL_SetColLock (xALP_SubEvals;4)
AL_SetDrgOpts (xALP_SubEvals;0;30;0)

  //dragging options
AL_SetDrgSrc (xALP_SubEvals;1;"";"";"")
AL_SetDrgSrc (xALP_SubEvals;2;"";"";"")
AL_SetDrgSrc (xALP_SubEvals;3;"";"";"")
AL_SetDrgDst (xALP_SubEvals;1;"";"";"")
AL_SetDrgDst (xALP_SubEvals;1;"";"";"")
AL_SetDrgDst (xALP_SubEvals;1;"";"";"")

ALP_SetDefaultAppareance (xALP_SubEvals;0;0;8;1;8)
ALP_SetAlternateLigneColor (xALP_SubEvals;Size of array:C274(aSubEvalOrden))


  //hidding cols
If ([xxSTR_Subasignaturas:83]ModoControles:5=0)
	AL_RemoveArrays (xALP_SubEvals;5;1)
End if 
If (Not:C34([Asignaturas:18]Seleccion:17))
	AL_RemoveArrays (xALP_SubEvals;3;1)
	AL_SetColLock (xALP_SubEvals;3)
Else 
	AL_SetColLock (xALP_SubEvals;4)
End if 

  //footers
AL_SetFooters (xALP_SubEvals;2;1;"Promedios")
AL_SetFtrStyle (xALP_SubEvals;0;"Tahoma";9;1)
AL_SetFooters (xALP_SubEvals;4;4;sP1;sP2;sP3;sP4)


AL_UpdateArrays (xALP_SubEvals;-2)

  //sort settings

ARRAY TEXT:C222($aArrayNames;0)
$err:=AL_GetArrayNames (xALP_SubEvals;$aArrayNames)
$colOrden:=Find in array:C230($aArrayNames;"aSubEvalOrden")
$colNombres:=Find in array:C230($aArrayNames;"aSubEvalStdNme")
$colCurso:=Find in array:C230($aArrayNames;"aSubEvalCurso")
$colSex:=Find in array:C230($aArrayNames;"aSubEvalSex")

$l_columnaParciales:=Find in array:C230($aArrayNames;"aSubEval1")
For ($i_columna;$l_columnaParciales;$l_columnaParciales+11)
	AL_SetCellLongProperty (xALP_SubEvals;0;$i_columna;ALP_Cell_RightIconID;$l_iconoEditable)
	AL_SetWidths (xALP_SubEvals;$i_columna;1;$colWidth)
	AL_SetFormat (xALP_SubEvals;$i_columna;"";2;0;0;0)
	AL_SetHdrStyle (xALP_SubEvals;$i_columna;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_SubEvals;$i_columna;"Tahoma";9;0)
	AL_SetStyle (xALP_SubEvals;$i_columna;"Tahoma";9;0)
	AL_SetForeColor (xALP_SubEvals;$i_columna;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_SubEvals;$i_columna;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_SubEvals;$i_columna;$enterableGrades)
	AL_SetEntryCtls (xALP_SubEvals;$i_columna;0)
End for 

  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
$o_obj:=STR_ordenNominas ("query";$o_in)
Case of 
	: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
		If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
			$colSex:=$colSex*-1
		End if 
		Case of 
			: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
				AL_SetSort (xALP_SubEvals;$colSex;$colOrden)
			: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
				If ($colCurso>0)
					AL_SetSort (xALP_SubEvals;$colSex;$colCurso;$colNombres)
				Else 
					AL_SetSort (xALP_SubEvals;$colSex;$colNombres)
				End if 
			: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
				AL_SetSort (xALP_SubEvals;$colSex;$colNombres)
		End case 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		AL_SetSort (xALP_SubEvals;$colOrden)
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		If ($colCurso>0)
			AL_SetSort (xALP_SubEvals;$colCurso;$colNombres)
		Else 
			AL_SetSort (xALP_SubEvals;$colNombres)
		End if 
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		AL_SetSort (xALP_SubEvals;$colNombres)
End case 
  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //If ($colCurso>0)
  //AL_SetSort (xALP_SubEvals;$colCurso;$colNombres)
  //Else 
  //AL_SetSort (xALP_SubEvals;$colNombres)
  //End if 
  //: (<>gOrdenNta=1)
  //AL_SetSort (xALP_SubEvals;$colOrden)
  //: (<>gOrdenNta=2)
  //AL_SetSort (xALP_SubEvals;$colNombres)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //If ($colCurso>0)
  //AL_SetSort (xALP_SubEvals;-$colSex;$colCurso;$colNombres)
  //Else 
  //AL_SetSort (xALP_SubEvals;-$colSex;$colNombres)
  //End if 
  //: (<>gOrdenNta=1)
  //AL_SetSort (xALP_SubEvals;-$colSex;$colOrden)
  //: (<>gOrdenNta=2)
  //AL_SetSort (xALP_SubEvals;-$colSex;$colNombres)
  //End case 
  //End if 

  //cell colors
ASsev_SetColors 

AL_SetColOpts (xALP_SubEvals;0;0;0;18)
  //END OF MAIN CODE 

