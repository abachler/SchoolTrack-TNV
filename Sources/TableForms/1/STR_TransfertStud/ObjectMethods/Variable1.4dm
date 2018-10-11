Case of 
	: (Form event:C388=On Load:K2:1)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (Self:C308->#0)
			If (Self:C308->{Self:C308->}=atSTR_CursoDestino{atSTR_CursoDestino})
				CD_Dlog (0;__ ("El curso de origen y el curso de destino no pueden ser los mismos."))
				Self:C308->:=0
				REDUCE SELECTION:C351([Alumnos:2];0)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID;[Alumnos:2]Situacion_final:33;<>aStatPromo)
			Else 
				Case of 
					: (atSTR_CursoOrigen=Size of array:C274(atSTR_CursoOrigen))
						  //QUERY([Alumnos];[Alumnos]Nivel_Número;=;Nivel_Egresados*1)
						  //20120928 ASM. Para cargar los alumnos del curso egresado (nivel 1002)
						QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_Egresados*1;*)
						QUERY:C277([Alumnos:2]; | ;[Alumnos:2]nivel_numero:29;=;1002)
						SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID;[Alumnos:2]Situacion_final:33;<>aStatPromo)
					: (atSTR_CursoOrigen=(Size of array:C274(atSTR_CursoOrigen)-1))
						  //QUERY([Alumnos];[Alumnos]Nivel_Número;=;Nivel_Retirados*1)
						QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_Retirados*1;*)  //20160525 ASM Ticket 155677
						QUERY:C277([Alumnos:2]; | ;[Alumnos:2]curso:20="RET")
						SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID;[Alumnos:2]Situacion_final:33;<>aStatPromo)
					: (atSTR_CursoOrigen=(Size of array:C274(atSTR_CursoOrigen)-2))
						QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_AdmisionDirecta*1)
						SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID;[Alumnos:2]Situacion_final:33;<>aStatPromo)
					Else 
						QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=atSTR_CursoOrigen{atSTR_CursoOrigen})
						SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID;[Alumnos:2]Situacion_final:33;<>aStatPromo)
				End case 
			End if 
		Else 
			REDUCE SELECTION:C351([Alumnos:2];0)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID;[Alumnos:2]Situacion_final:33;<>aStatPromo)
		End if 
		AL_UpdateArrays (xALP_Trans1;-2)
End case 
