If (Is new record:C668([ADT_Candidatos:49]))
	If (Size of array:C274(adPST_FromDate)>0)  //20180321 RCH
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=-3)
		$r:=CD_Dlog (0;__ ("La asignación de un alumno de ")+[xxSTR_Niveles:6]Nivel:1+__ (" graba automaticamente el registro del candidato. Para deshacer es necesario eliminar el registro. ¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
		If ($r=1)
			QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=-3)
			CREATE SET:C116([Alumnos:2];"PlayGroup")
			PUSH RECORD:C176([ADT_Candidatos:49])
			ALL RECORDS:C47([ADT_Candidatos:49])
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[ADT_Candidatos:49]Candidato_numero:1;"")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29=-3)
			CREATE SET:C116([Alumnos:2];"Candidates")
			DIFFERENCE:C122("PlayGroup";"Candidates";"PlayGroup")
			USE SET:C118("PlayGroup")
			POP RECORD:C177([ADT_Candidatos:49])
			If (Records in selection:C76([Alumnos:2])>0)
				SELECTION TO ARRAY:C260([Alumnos:2];alPST_JfRecNum;[Alumnos:2]apellidos_y_nombres:40;atPST_JFname;[Alumnos:2]curso:20;atPST_JFClass;[Alumnos:2]Fecha_de_nacimiento:7;adPST_JFBirthDate)
				WDW_OpenFormWindow (->[xxSTR_Constants:1];"PST_SelectPGMember";-1;Palette form window:K39:9;__ ("Inscripción de Alumnos de ")+[xxSTR_Niveles:6]Nivel:1)
				DIALOG:C40([xxSTR_Constants:1];"PST_SelectPGMember")
				CLOSE WINDOW:C154
				If (Records in selection:C76([Alumnos:2])>0)
					PST_SetConnexions 
					SET WINDOW TITLE:C213(__ ("Postulantes: ")+[Alumnos:2]Nombres:2+" "+[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4)
				End if 
			Else 
				CD_Dlog (0;__ ("No hay registros de alumnos de ")+[xxSTR_Niveles:6]Nivel:1+__ ("."))
			End if 
			ADTcdd_OnRecordLoad 
			SET_ClearSets ("PlayGroup";"Candidates")
		End if 
	Else 
		CD_Dlog (0;__ ("Antes de utilizar esta opción, configure Grupos Etarios."))
	End if 
Else 
	WDW_OpenPopupWindow (Self:C308;->[Alumnos:2];"CustomNames";2)
	DIALOG:C40([Alumnos:2];"CustomNames")
	CLOSE WINDOW:C154
End if 