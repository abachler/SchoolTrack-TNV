//%attributes = {}
  //xALSet_Al_AreasObservaciones


  //ARRAY TEXT(aPJObs;Size of array(atSTR_Periodos_Nombre))

If (Count parameters:C259=1)
	$area:=$1
Else 
	$area:=1
End if 
  // entrevistas
$err:=AL_SetArraysNam (xALP_Interview;1;4;"aIWDate";"alWEvento";"aIWMotivo";"aIWId")
AL_SetHeaders (xALP_Interview;1;3;__ ("Fecha");__ ("Evento");__ ("Asunto"))
AL_SetStyle (xALP_Interview;0;"Tahoma";9;0)
AL_SetFormat (xALP_Interview;1;"";2)  //RCH
AL_SetHdrStyle (xALP_Interview;0;"Tahoma";9;1)
AL_SetStyle (xALP_Interview;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_Interview;0;"Tahoma";9;1)
AL_SetMiscOpts (xALP_Interview;0;0;"\\";0;1)
AL_SetDividers (xALP_Interview;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetColOpts (xALP_Interview;0;0;0;1;0;0;0)
AL_SetSortOpts (xALP_Interview;1;1;0;"";1)
AL_SetWidths (xALP_Interview;1;3;75;200;200)
AL_SetHeight (xALP_Interview;1;2;1;4;0;0)
AL_SetLine (xALP_Interview;0)
AL_SetSort (xALP_Interview;-1)

If ($area=1)
	  //mono 148569 
	  //$isAut:=((<>lUSR_RelatedTableUserID=[Cursos]Numero_del_profesor_jefe) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lSTR_IDTutor_USR=[Alumnos]Tutor_numero))
	  //If (($isAut) & (Not(<>vb_BloquearModifSituacionFinal)))
	  //$comentariosPJ_ingresables:=1
	  //Else 
	  //$comentariosPJ_ingresables:=0
	  //End if 
	
	AL_RemoveArrays (xALP_ComentariosAlumno;1;30)
	C_LONGINT:C283($Error)
	
	  //specify arrays to display
	$Error:=AL_SetArraysNam (xALP_ComentariosAlumno;1;1;"aObsPJTerm")
	$Error:=AL_SetArraysNam (xALP_ComentariosAlumno;2;1;"aPJObs")
	
	  //column 1 settings
	AL_SetHeaders (xALP_ComentariosAlumno;1;1;__ ("Período"))
	AL_SetWidths (xALP_ComentariosAlumno;1;1;100)
	AL_SetFormat (xALP_ComentariosAlumno;1;"";0;0;0;0)
	AL_SetHdrStyle (xALP_ComentariosAlumno;1;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_ComentariosAlumno;1;"Tahoma";9;0)
	AL_SetStyle (xALP_ComentariosAlumno;1;"Tahoma";9;0)
	AL_SetForeColor (xALP_ComentariosAlumno;1;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_ComentariosAlumno;1;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_ComentariosAlumno;1;0)
	AL_SetEntryCtls (xALP_ComentariosAlumno;1;0)
	
	  //column 2 settings
	AL_SetHeaders (xALP_ComentariosAlumno;2;1;__ ("Observaciones"))
	AL_SetWidths (xALP_ComentariosAlumno;2;1;615)
	AL_SetFormat (xALP_ComentariosAlumno;2;"";0;0;0;0)
	AL_SetHdrStyle (xALP_ComentariosAlumno;2;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_ComentariosAlumno;2;"Tahoma";9;0)
	AL_SetStyle (xALP_ComentariosAlumno;2;"Tahoma";9;0)
	AL_SetForeColor (xALP_ComentariosAlumno;2;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_ComentariosAlumno;2;"White";0;"White";0;"White";0)
	  //AL_SetEnterable (xALP_ComentariosAlumno;2;$comentariosPJ_ingresables)
	AL_SetEnterable (xALP_ComentariosAlumno;2;0)  //mono 148569 
	AL_SetEntryCtls (xALP_ComentariosAlumno;2;0)
	
	  //general options
	
	AL_SetColOpts (xALP_ComentariosAlumno;1;1;1;0;0)
	AL_SetRowOpts (xALP_ComentariosAlumno;0;1;0;0;1;0)
	AL_SetCellOpts (xALP_ComentariosAlumno;0;1;1)
	AL_SetMiscOpts (xALP_ComentariosAlumno;0;0;"\\";0;1)
	AL_SetCallbacks (xALP_ComentariosAlumno;"";"XALCB_EX_OBSERVACIONES")
	AL_SetMiscColor (xALP_ComentariosAlumno;0;"White";0)
	AL_SetMiscColor (xALP_ComentariosAlumno;1;"White";0)
	AL_SetMiscColor (xALP_ComentariosAlumno;2;"White";0)
	AL_SetMiscColor (xALP_ComentariosAlumno;3;"White";0)
	AL_SetMainCalls (xALP_ComentariosAlumno;"";"")
	AL_SetScroll (xALP_ComentariosAlumno;0;-3)
	AL_SetCopyOpts (xALP_ComentariosAlumno;0;"\t";"\r";Char:C90(0))
	AL_SetSortOpts (xALP_ComentariosAlumno;0;1;0;"Select the columns to sort:";0)
	AL_SetEntryOpts (xALP_ComentariosAlumno;3;1;0;0;0;<>tXS_RS_DecimalSeparator)
	AL_SetHeight (xALP_ComentariosAlumno;1;2;4;3;2)
	AL_SetDividers (xALP_ComentariosAlumno;"Black";"Light Gray";0;"Black";"Light Gray";0)
	AL_SetDrgOpts (xALP_ComentariosAlumno;0;30;0)
	AL_SetColLock (xALP_ComentariosAlumno;1)
	
	  //dragging options
	
	AL_SetDrgSrc (xALP_ComentariosAlumno;1;"";"";"")
	AL_SetDrgSrc (xALP_ComentariosAlumno;2;"";"";"")
	AL_SetDrgSrc (xALP_ComentariosAlumno;3;"";"";"")
	AL_SetDrgDst (xALP_ComentariosAlumno;1;"";"";"")
	AL_SetDrgDst (xALP_ComentariosAlumno;1;"";"";"")
	AL_SetDrgDst (xALP_ComentariosAlumno;1;"";"";"")
	
End if 
  //comentarios y entrevistas
If ($area=2)
	AL_RemoveArrays (xALP_ComentariosAlumno;1;30)
	Case of 
		: (vlSTR_Periodos_Tipo=5 Bimestres)
			$Col1width:=150
			$colWidth:=94
			
		: (vlSTR_Periodos_Tipo=4 Bimestres)
			$Col1width:=147
			$colWidth:=113
			
		: (vlSTR_Periodos_Tipo=3 Trimestres)
			$Col1width:=151
			$colWidth:=142
			
		: (vlSTR_Periodos_Tipo=2 Semestres)
			$Col1width:=151
			$colWidth:=188
			
		: (vlSTR_Periodos_Tipo=Anual)
			$Col1width:=150
			$colWidth:=565
	End case 
	$err:=AL_SetArraysNam (xALP_ComentariosAlumno;1;1;"aAsignatura")
	AL_SetHeaders (xALP_ComentariosAlumno;1;1;__ ("Asignatura"))
	AL_SetWidths (xALP_ComentariosAlumno;1;1;$Col1width)
	$column:=2
	$periodo:=1
	For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
		$err:=AL_SetArraysNam (xALP_ComentariosAlumno;$column;1;"aObsP"+String:C10($periodo))
		AL_SetHeaders (xALP_ComentariosAlumno;$column;1;atSTR_Periodos_Nombre{$i})
		AL_SetWidths (xALP_ComentariosAlumno;$column;1;$colWidth)
		$column:=$column+1
		$periodo:=$periodo+1
	End for 
	$err:=AL_SetArraysNam (xALP_ComentariosAlumno;$column;1;"aObsFinales")
	AL_SetHeaders (xALP_ComentariosAlumno;$column;1;__ ("Finales"))
	AL_SetWidths (xALP_ComentariosAlumno;$column;1;$colWidth)
	
	
	AL_SetStyle (xALP_ComentariosAlumno;0;"Tahoma";9;0)
	AL_SetHdrStyle (xALP_ComentariosAlumno;0;"Tahoma";9;1)
	AL_SetSort (xALP_ComentariosAlumno;1)
	AL_SetMiscOpts (xALP_ComentariosAlumno;0;0;"\\";0;1)
	AL_SetDividers (xALP_ComentariosAlumno;"Black";"Light Gray";0;"Black";"Light Gray";0)
	AL_SetColOpts (xALP_ComentariosAlumno;1;1;1;0;0;0;0)
	AL_SetColLock (xALP_ComentariosAlumno;1)
	AL_SetSortOpts (xALP_ComentariosAlumno;1;1;0;"";1)
	AL_SetEntryOpts (xALP_ComentariosAlumno;0)
	AL_SetScroll (xALP_ComentariosAlumno;0;-3)
	
	AL_SetHeight (xALP_ComentariosAlumno;1;1;4;0;0;0)
	AL_SetLine (xALP_ComentariosAlumno;0)
End if 

