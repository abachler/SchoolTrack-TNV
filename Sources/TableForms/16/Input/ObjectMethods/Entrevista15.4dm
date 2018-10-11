If ((<>popIntLoc2=5) & ([Alumnos_EventosPersonales:16]Interlocutor3:17#""))
	QUERY:C277([Profesores:4];[Profesores:4]Apellido_paterno:3=([Alumnos_EventosPersonales:16]Interlocutor3:17+"@"))
	Case of 
		: (Records in selection:C76([Profesores:4])=0)
			$r:=CD_Dlog (1;__ ("Profesor inexistente."))
			[Alumnos_EventosPersonales:16]Interlocutor3:17:=""
			GOTO OBJECT:C206([Alumnos_EventosPersonales:16]Interlocutor3:17)
		: (Records in selection:C76([Profesores:4])=1)
			[Alumnos_EventosPersonales:16]Interlocutor3:17:=[Profesores:4]Nombre_comun:21
		: (Records in selection:C76([Profesores:4])>1)
			SELECTION TO ARRAY:C260([Profesores:4]Nombre_comun:21;aText1;[Profesores:4];aLong1)
			ARRAY POINTER:C280(<>aChoicePtrs;2)
			<>aChoicePtrs{1}:=->aText1
			<>aChoicePtrs{2}:=->along1
			TBL_ShowChoiceList (1)
			If ((ok=1) & (choiceIdx>0))
				GOTO RECORD:C242([Profesores:4];aLong1{choiceIdx})
				Self:C308->:=[Profesores:4]Nombre_comun:21
			Else 
				Self:C308->:=""
				GOTO OBJECT:C206(Self:C308->)
			End if 
	End case 
End if 
OBJECT SET ENTERABLE:C238([Alumnos_EventosPersonales:16]AsisInterlocutor2:22;([Alumnos_EventosPersonales:16]Interlocutor3:17#""))