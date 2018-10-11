$line:=AL_GetLine (xALP_PlayGroup)
If ($line>0)
	READ WRITE:C146([Alumnos:2])
	GOTO RECORD:C242([Alumnos:2];alPST_JFRecNum{$line})
	Case of 
		: (([Alumnos:2]Sexo:49#"F") & ([Alumnos:2]Sexo:49#"M"))
			CD_Dlog (0;__ ("El postulante seleccionado no tiene definido su sexo."))
		: ([Alumnos:2]Familia_Número:24=0)
			CD_Dlog (0;__ ("El alumno no está asociado a ninguna familia. \r\rNo puede ser inscrito como postulante sin asociarlo previamente a una familia."))
			OK:=1
		Else 
			OK:=1
	End case 
	If (ok=1)
		Case of 
			: ([Alumnos:2]Fecha_de_nacimiento:7<adPST_FromDate{1})
				OK:=CD_Dlog (0;Replace string:C233(__ ("La fecha de nacimiento ingresada es inferior al límite mínimo (^0).\r¿Desea inscribir al postulante asignándolo al grupo de edad más cercano a su fecha de nacimiento?");__ ("^0");String:C10(adPST_FromDate{1}));__ ("");__ ("Sí");__ ("No"))
				If (ok=1)
					$group:=atPST_groupName{1}
				End if 
			: ([Alumnos:2]Fecha_de_nacimiento:7>adPST_ToDate{Size of array:C274(adPST_ToDate)})
				OK:=CD_Dlog (0;Replace string:C233(__ ("La fecha de nacimiento ingresada es superior al límite máximo (^0).\r¿Desea inscribir al postulante asignándolo al grupo de edad más cercano a su fecha de nacimiento?");__ ("^0");String:C10(adPST_ToDate{Size of array:C274(adPST_ToDate)}));__ ("");__ ("Sí");__ ("No"))
				If (ok=1)
					$group:=atPST_groupName{Size of array:C274(adPST_ToDate)}
				End if 
		End case 
		If (ok=1)
			QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Candidato_numero:1=[Alumnos:2]numero:1)
			If (Records in selection:C76([ADT_Candidatos:49])=0)
				For ($i;1;Size of array:C274(adPST_FromDate))
					If (([Alumnos:2]Fecha_de_nacimiento:7>=adPST_FromDate{$i}) & ([Alumnos:2]Fecha_de_nacimiento:7<=adPST_ToDate{$i}))
						$group:=atPst_GroupName{$i}
						$i:=Size of array:C274(adPST_FromDate)
					End if 
				End for 
				CREATE RECORD:C68([ADT_Candidatos:49])
				[ADT_Candidatos:49]Candidato_numero:1:=[Alumnos:2]numero:1
				[ADT_Candidatos:49]Fecha_de_Inscripción:2:=Current date:C33(*)
				[ADT_Candidatos:49]Inscriptor:3:=<>tUSR_CurrentUser
				[ADT_Candidatos:49]Sexo:25:=[Alumnos:2]Sexo:49
				[ADT_Candidatos:49]Postulante_de_JardinInfantil:39:=True:C214
				[ADT_Candidatos:49]Grupo:21:=$group
				For ($i;1;Size of array:C274(adPST_FromDate))
					If (([Alumnos:2]Fecha_de_nacimiento:7>=adPST_FromDate{$i}) & ([Alumnos:2]Fecha_de_nacimiento:7<=adPST_ToDate{$i}))
						[ADT_Candidatos:49]Grupo:21:=atPst_GroupName{$i}
						$i:=Size of array:C274(adPST_FromDate)
					End if 
				End for 
				
				  // test if Family has other students in school
				READ WRITE:C146([Familia:78])
				QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
				QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1;*)
				QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29>=-2)  // (The student current record is changed !!)
				If (Records in selection:C76([Alumnos:2])=0)
					[Familia:78]Es_Postulante:18:=True:C214
					SAVE RECORD:C53([Familia:78])
				End if 
				KRL_ReloadAsReadOnly (->[Familia:78])
				
				If ([ADT_Candidatos:49]Asistentes_presentación:22=0)
					If (([Familia:78]Padre_Número:5#0) & ([Familia:78]Madre_Número:6#0))
						[ADT_Candidatos:49]Asistentes_presentación:22:=2
					Else 
						[ADT_Candidatos:49]Asistentes_presentación:22:=1
					End if 
				End if 
				
				GOTO RECORD:C242([Alumnos:2];alPST_JFRecNum{$line})  // returning to the student record
				PST_AutoAsignIViewAndPresent 
				PST_AsignExamsDate 
				SAVE RECORD:C53([ADT_Candidatos:49])
			End if 
			ACCEPT:C269
		Else 
			REDUCE SELECTION:C351([Alumnos:2];0)
		End if 
	Else 
		REDUCE SELECTION:C351([Alumnos:2];0)
	End if 
End if 




