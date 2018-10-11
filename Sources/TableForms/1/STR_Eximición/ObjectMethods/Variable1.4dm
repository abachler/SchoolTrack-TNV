Case of 
	: (Form event:C388=On Load:K2:1)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
		READ ONLY:C145([Asignaturas:18])
		QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear;*)
		QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & ;[Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7>!00-00-00!)
		ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;>;[Asignaturas:18]Asignatura:3;>)
		SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209];aRecNums;[Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Asignaturas:18]Asignatura:3;aPaName;[Alumnos:2]curso:20;<>aStdClass;[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;<>aExmNo;[Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7;<>aExmDate;[Alumnos_ComplementoEvaluacion:209]Eximicion_Obs:9;<>aExmObs)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		$err:=AL_SetArraysNam (Self:C308->;1;7;"<>aExmNo";"<>aExmDate";"<>aStdWhNme";"aPaName";"<>aStdClass";"<>aExmObs";"aRecNums")
		AL_SetSort (Self:C308->;1)
		AL_SetFormat (Self:C308->;1;"##0")
		AL_SetFormat (Self:C308->;2;"7")
		ALP_SetDefaultAppareance (Self:C308->;9;2;1;2;2)
		AL_SetColOpts (Self:C308->;0;0;0;1;0;0;0)
		AL_SetWidths (Self:C308->;1;6;20;60;130;120;60;162)
		AL_SetHeaders (Self:C308->;1;6;__ ("Nº");__ ("Fecha");__ ("Nombre y apellidos");__ ("Asignatura");__ ("Curso");__ ("Autorización especial"))
		AL_SetRowOpts (Self:C308->;1;1;1;0;0)
		AL_SetSortOpts (Self:C308->;1;1;0;"";1)
		AL_SetDrgOpts (Self:C308->;1;30;1)
		AL_SetEnterable (Self:C308->;2;1)
		AL_SetEnterable (Self:C308->;1;0)
		AL_SetEnterable (Self:C308->;3;0)
		AL_SetEnterable (Self:C308->;4;0)
		AL_SetEnterable (Self:C308->;5;0)
		AL_SetEntryOpts (Self:C308->;3;0;0;0;2;<>tXS_RS_DecimalSeparator)
		AL_SetMiscOpts (Self:C308->;0;1;"'";0;1)
		
		$accCode:=String:C10(Self:C308->)
		AL_SetDrgSrc (Self:C308->;1;$accCode)
		AL_SetDrgDst (Self:C308->;1;$accCode)
		ARRAY INTEGER:C220(alLines;0)
		AL_SetSelect (Self:C308->;alLines)
		
	: (alProEvt=-5)
		AL_GetDrgSrcRow (Self:C308->;$oldNo)
		AL_GetDrgArea (Self:C308->;$area;$pId)
		If ($area=Self:C308->)
			AL_GetDrgDstTyp (Self:C308->;$type)
			If ($type=1)
				AL_GetDrgDstRow (Self:C308->;$NewNo)
			End if 
		End if 
		
		If ($newNo<$oldNo)
			<>aExmNo{$newNo}:=$newNo+1
			<>aExmNo{$oldno}:=$newNo
			AL_SetSort (Self:C308->;1)
			$el:=Find in array:C230(<>aExmNo;$newNo+1)
			For ($i;$newNo+1;Size of array:C274(<>aExmNo))
				<>aExmNo{$i}:=$i
			End for 
		Else 
			If ($newNo>Size of array:C274(aRecNums))
				$newNo:=Size of array:C274(aRecNums)
			End if 
			<>aExmNo{$newNo}:=$newNo-1
			<>aExmNo{$oldno}:=$newNo
			AL_SetSort (Self:C308->;1)
			$el:=Find in array:C230(<>aExmNo;$newNo-1)
			For ($i;$newNo-1;1;-1)
				<>aExmNo{$i}:=$i
			End for 
		End if 
		AL_UpdateArrays (Self:C308->;Size of array:C274(aRecNums))
End case 