If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
	Self:C308->:=Old:C35(Self:C308->)
Else 
	
	If (Self:C308->=False:C215)
		If (([Asignaturas:18]Incide_en_promedio:27) & (Not:C34([Asignaturas:18]Es_Optativa:70)))
			If (<>vtXS_CountryCode="cl")
				$r:=CD_Dlog (0;__ ("Las asignaturas promediables deben ser incluidas en el Acta Calificaciones.\rSi la mantiene fuera del acta obtendrá un error al imprimir.\r\r¿Desea mantener la asignatura como promediable pero no imprimible en el acta?");__ ("");__ ("No");__ ("Si"))
				If ($r=1)
					Self:C308->:=True:C214
				End if 
			End if 
		End if 
	Else 
		If ((Not:C34([Asignaturas:18]Incide_en_promedio:27)) & (Not:C34([Asignaturas:18]Es_Optativa:70)))
			If (<>vtXS_CountryCode="cl")
				$r:=CD_Dlog (0;__ ("Las asignaturas incluidas en acta deben ser promediables u optativas. En caso contrario obtendrá un error al imprimir el acta.\r\r¿Desea imprimir en acta una asignatura no promediable y no optativa?");__ ("");__ ("No");__ ("Si"))
				If ($r=1)
					Self:C308->:=False:C215
				End if 
			End if 
		End if 
	End if 
	
	If (Self:C308->#Old:C35(Self:C308->))
		SAVE RECORD:C53([Asignaturas:18])
		$l_recNum:=Record number:C243([Asignaturas:18])
		ACTAS_LeeConfiguracion ([Asignaturas:18]Numero_del_Nivel:6)
		KRL_GotoRecord (->[Asignaturas:18];$l_recNum;True:C214)
		
		POST KEY:C465(Character code:C91("*");256)
		For ($i;1;Size of array:C274(aNtaIdAlumno))
			BM_CreateRequest ("CalculaPromediosGenerales";String:C10(aNtaIdAlumno{$i});String:C10(aNtaIdAlumno{$i}))
		End for 
	End if 
	
End if 
