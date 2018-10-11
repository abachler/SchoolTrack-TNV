If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
	Self:C308->:=Old:C35(Self:C308->)
Else 
	EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
	$f:=Records in selection:C76([Alumnos_Calificaciones:208])
	
	
	If ($f>0)
		If (Self:C308->)
			$r:=CD_Dlog (0;__ ("Los promedios serán ponderados por el factor ingresado en la definición del estilo de evaluación.\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
		Else 
			$r:=CD_Dlog (0;__ ("El factor de ponderación de los esfuerzos no será considerado en el promedio.\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
		End if 
		If ($r=1)
			$l_recordWasSaved:=AS_fSave 
			_O_ARRAY STRING:C218(5;$aString;0)
			_O_ARRAY STRING:C218(5;$aString;$f)
			KRL_Array2Selection (->$aString;->[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16;->$aString;->[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21;->$aString;->[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26;->$aString;->[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31;->$aString;->[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36)
			POST KEY:C465(Character code:C91("*");256)
			
			
		Else 
			Self:C308->:=Old:C35(Self:C308->)
		End if 
	End if 
End if 