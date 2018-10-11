If (<>vtXS_CountryCode="cl")
	If (Self:C308->)
		If ([Asignaturas:18]Incide_en_promedio:27)
			$r:=CD_Dlog (0;__ ("Las asignaturas optativas no deben incidir en el promedio oficial del alumno.\rUsted puede sin embargo mantener la configuración actual, pero obtendrá un error al imprimir el Acta General de Calificaciones.\r\r¿Desea mantener la incidencia en el promedio"+"?");__ ("");__ ("No");__ ("Si"))
			If ($r=1)
				[Asignaturas:18]Incide_en_promedio:27:=False:C215
			End if 
		End if 
	End if 
	
	For ($i;1;Size of array:C274(aNtaIdAlumno))
		BM_CreateRequest ("Recalcular situación";String:C10(aNtaIdAlumno{$i});String:C10(aNtaIdAlumno{$i}))
	End for 
End if 