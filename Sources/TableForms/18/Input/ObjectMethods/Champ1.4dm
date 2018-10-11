If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+".")
	Self:C308->:=Old:C35(Self:C308->)
Else 
	If (Self:C308->)
		If (Not:C34([Asignaturas:18]Incluida_en_Actas:44))
			If (<>vtXS_CountryCode="cl")
				$r:=CD_Dlog (0;__ ("Las asignaturas promediables deben ser incluidas en el Acta Calificaciones.\rSi la mantiene fuera del acta obtendrá un error al imprimir.\r\r¿Desea mantener la asignatura como promediable pero no imprimible en el acta?");"";__ ("No");__ ("Si"))
				If ($r=1)
					[Asignaturas:18]Incluida_en_Actas:44:=True:C214
				End if 
			End if 
		End if 
	Else 
		If ([Asignaturas:18]Incluida_en_Actas:44)
			If (<>vtXS_CountryCode="cl")
				$r:=CD_Dlog (0;__ ("Esta asignatura ha sido configurada para ser incluida en el acta de calificaciones sin ser optativa. Las asignaturas no optativas que figuran en acta deben incidir en promedio.\rSi usted desactiva la incidencia en promedio obtendrá un error al imprimi"+"r el ")+__ (" General de Calificaciones.\r\r¿Desea mantener la asignatura sin incidencia en el promedio y presente en el acta?");"";__ ("No");__ ("Si"))
				If ($r=1)
					Self:C308->:=True:C214
				End if 
			End if 
		End if 
	End if 
	SAVE RECORD:C53([Asignaturas:18])
	POST KEY:C465(Character code:C91("*");256)
	For ($i;1;Size of array:C274(aNtaIdAlumno))
		BM_CreateRequest ("CalculaPromediosGenerales";String:C10(aNtaIdAlumno{$i});String:C10(aNtaIdAlumno{$i}))
	End for 
End if 