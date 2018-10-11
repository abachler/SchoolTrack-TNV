//%attributes = {}
  //EV2_AprobacionReprobacion


Case of 
	: (<>vtXS_CountryCode="ar")
		EV2_AprobacionReprobacion_ar 
		
	Else 
		$estiloActual:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
		$convertirA_EstiloOficial:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37)
		$idEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
		If (($convertirA_EstiloOficial=False:C215) | ([Asignaturas:18]NotaOficial_conEstiloAsignatura:95=True:C214))
			EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		Else 
			EVS_ReadStyleData ($idEstiloOficial)
		End if 
		If (vi_SinReprobacion=1)
			[Alumnos_Calificaciones:208]Reprobada:9:=False:C215
			If (([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32<vr_MinimoRecuperacion) & ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32>=vrNTA_MinimoEscalaReferencia))
				[Alumnos_Calificaciones:208]AprobacionPendiente:508:=True:C214
			Else 
				[Alumnos_Calificaciones:208]AprobacionPendiente:508:=False:C215
			End if 
			
		Else 
			
			If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32>=vrNTA_MinimoEscalaReferencia)
				Case of 
					: (iPrintActa=Notas)
						If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33>=rGradesMinimum)
							[Alumnos_Calificaciones:208]Reprobada:9:=False:C215
						Else 
							[Alumnos_Calificaciones:208]Reprobada:9:=True:C214
						End if 
					: (iPrintActa=Puntos)
						If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34>rPointsMinimum)
							[Alumnos_Calificaciones:208]Reprobada:9:=False:C215
						Else 
							[Alumnos_Calificaciones:208]Reprobada:9:=True:C214
						End if 
					Else 
						If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32>=rPctMinimum)
							[Alumnos_Calificaciones:208]Reprobada:9:=False:C215
						Else 
							[Alumnos_Calificaciones:208]Reprobada:9:=True:C214
						End if 
				End case 
				
				If ([Alumnos_Calificaciones:208]Reprobada:9=False:C215)
					If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32<vr_MinimoRecuperacion)
						[Alumnos_Calificaciones:208]AprobacionPendiente:508:=True:C214
					Else 
						[Alumnos_Calificaciones:208]AprobacionPendiente:508:=False:C215
					End if 
				End if 
				
			Else 
				[Alumnos_Calificaciones:208]AprobacionPendiente:508:=False:C215
				[Alumnos_Calificaciones:208]Reprobada:9:=False:C215
			End if 
		End if 
End case 

If (([Alumnos_Calificaciones:208]Reprobada:9#Old:C35([Alumnos_Calificaciones:208]Reprobada:9)) | ([Alumnos_Calificaciones:208]AprobacionPendiente:508#Old:C35([Alumnos_Calificaciones:208]AprobacionPendiente:508)))
	$0:=True:C214
Else 
	$0:=False:C215
End if 
EVS_ReadStyleData ($estiloActual)