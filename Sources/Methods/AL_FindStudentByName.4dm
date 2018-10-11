//%attributes = {}
  //AL_FindStudentByName

ARRAY LONGINT:C221(abrSelect;0)
If (sName#"")
	Case of 
		: ((<>lSTR_IDTutor_USR>0) & (USR_checkRights ("A";->[Alumnos_Conducta:8])=False:C215))
			QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=<>lSTR_IDTutor_USR)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Apellido_paterno:3=(sName+"@"))
		: ((<>tSTR_CursoProfesor_USR#"") & (USR_checkRights ("A";->[Alumnos_Conducta:8])=False:C215))
			$num:=Num:C11(sName)
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=<>tSTR_CursoProfesor_USR)
			If ($num>0)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]no_de_lista:53=$num)
			Else 
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Apellido_paterno:3=(sName+"@"))
			End if 
		Else 
			QUERY:C277([Alumnos:2];[Alumnos:2]Apellido_paterno:3=(sName+"@"))
	End case 
	Case of 
		: (Records in selection:C76([Alumnos:2])=0)
			CD_Dlog (0;__ ("Alumno inexistente."))
			sName:=""
			GOTO OBJECT:C206(sName)
		: (Records in selection:C76([Alumnos:2])=1)
			sName:=[Alumnos:2]apellidos_y_nombres:40
			GOTO OBJECT:C206(dFrom)
			HIGHLIGHT TEXT:C210(dFrom;1;80)
		: (Records in selection:C76([Alumnos:2])>1)
			READ ONLY:C145([Alumnos:2])
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aGenNme;[Alumnos:2]numero:1;<>aGenId)
			ARRAY POINTER:C280(<>aChoicePtrs;2)
			<>aChoicePtrs{1}:=-><>aGenNme
			<>aChoicePtrs{2}:=-><>aGenID
			TBL_ShowChoiceList (1;"Seleccione el alumno")
			If ((ok=1) & (choiceIdx>0))
				sName:=<>aChoicePtrs{1}->{choiceIdx}
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=<>aChoicePtrs{2}->{choiceIdx})
				GOTO OBJECT:C206(sMotivo)
				HIGHLIGHT TEXT:C210(dFrom;1;80)
			Else 
				REDUCE SELECTION:C351([Alumnos:2];0)
				sName:=""
				GOTO OBJECT:C206(sName)
			End if 
	End case 
Else 
	CD_Dlog (0;__ ("Por favor ingrese el apellido del alumnos."))
End if 