Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_BOOLEAN:C305($reprobado)
		QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Año:2=(<>gYear-1);*)
		QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1)
		If (Records in selection:C76([Alumnos_Historico:25])>0)
			
			Case of 
				: (<>vtXS_CountryCode="cl")
					If ([Alumnos_Historico:25]Situacion_final:19#"P")
						$reprobado:=True:C214
					End if 
					
				: (<>vtXS_CountryCode="pe")
					If (([Alumnos_Historico:25]Situacion_final:19#"A") & ([Alumnos_Historico:25]Situacion_final:19#"RR") & ([Alumnos_Historico:25]Situacion_final:19#"C"))
						$reprobado:=True:C214
					End if 
					
				: (<>vtXS_CountryCode="co")
					If ([Alumnos_Historico:25]Situacion_final:19="NP")  //en CO la situación de reprobación es NP
						$reprobado:=True:C214
					End if 
					
				: (<>vtXS_CountryCode="ve")
					If ([Alumnos_Historico:25]Situacion_final:19#"P")
						$reprobado:=True:C214
					End if 
					
				: (<>vtXS_CountryCode="ar")
					If ([Alumnos_Historico:25]Situacion_final:19#"P")
						$reprobado:=True:C214
					End if 
					
				Else 
					If ([Alumnos_Historico:25]Situacion_final:19#"P")
						$reprobado:=True:C214
					End if 
			End case 
			
			If ($reprobado)
				$registeredStatus:="Repitente"
			Else 
				$registeredStatus:="Promovido"
				CD_Dlog (0;__ ("El registro histórico indica que este alumno fue ")+$registeredStatus+__ (" el año anterior.\rNo es posible modificar este atributo."))
				[Alumnos:2]Es_Repitente:77:=Old:C35([Alumnos:2]Es_Repitente:77)
			End if 
		End if 
		
End case 