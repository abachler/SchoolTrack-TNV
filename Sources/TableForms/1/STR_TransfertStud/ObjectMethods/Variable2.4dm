Case of 
	: (Form event:C388=On Load:K2:1)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (atSTR_CursoDestino>0)
			If (Self:C308->{Self:C308->}=atSTR_CursoOrigen{atSTR_CursoOrigen})
				CD_Dlog (0;__ ("El curso de origen y el curso de destino no pueden ser los mismos."))
				Self:C308->:=0
				REDUCE SELECTION:C351([Alumnos:2];0)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aPlantel)
			Else 
				Case of 
					: (atSTR_CursoDestino=Size of array:C274(atSTR_CursoDestino))
						QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_Egresados*1)
						SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aPlantel)
					: (atSTR_CursoDestino=(Size of array:C274(atSTR_CursoDestino)-1))
						QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_Retirados*1)
						SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aPlantel)
					: (atSTR_CursoDestino=(Size of array:C274(atSTR_CursoDestino)-2))
						QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_AdmisionDirecta*1)
						SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aPlantel)
					Else 
						QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=atSTR_CursoDestino{atSTR_CursoDestino})
						SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aPlantel)
				End case 
			End if 
		Else 
			REDUCE SELECTION:C351([Alumnos:2];0)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aPlantel)
		End if 
		AL_UpdateArrays (xALP_Trans2;-2)
End case 