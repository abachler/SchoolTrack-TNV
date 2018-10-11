  //[Asignaturas].Input.EvaluaEsfuerzo

If ((Self:C308->) & (r1_EvEsfuerzoIndicadores=1))
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	OBJECT SET VISIBLE:C603([Asignaturas:18]Pondera_Esfuerzo:61;(AT_GetSumArray (->aFactorEsfuerzo)>0))
Else 
	EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
	$f:=Records in selection:C76([Alumnos_Calificaciones:208])
	
	
	If ($f>0)
		$r:=CD_Dlog (0;__ ("Las evaluaciones de esfuerzo existentes serán eliminadas.\r¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			OBJECT SET VISIBLE:C603([Asignaturas:18]Pondera_Esfuerzo:61;False:C215)
			[Asignaturas:18]Ingresa_Esfuerzo:40:=False:C215
			[Asignaturas:18]Pondera_Esfuerzo:61:=False:C215
			$l_recordWasSaved:=AS_fSave 
			_O_ARRAY STRING:C218(5;$aString;0)
			_O_ARRAY STRING:C218(5;$aString;$f)
			KRL_Array2Selection (->$aString;->[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16;->$aString;->[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21;->$aString;->[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26;->$aString;->[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31;->$aString;->[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36)
			
			POST KEY:C465(Character code:C91("*");256)
			
		Else 
			Self:C308->:=Old:C35(Self:C308->)
		End if 
	Else 
		OBJECT SET VISIBLE:C603([Asignaturas:18]Pondera_Esfuerzo:61;False:C215)
		[Asignaturas:18]Pondera_Esfuerzo:61:=False:C215
	End if 
End if 


