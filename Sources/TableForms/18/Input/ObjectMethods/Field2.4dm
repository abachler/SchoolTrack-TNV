If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
	Self:C308->:=Old:C35(Self:C308->)
Else 
	
	If (Not:C34([Asignaturas:18]Resultado_no_calculado:47))
		POST KEY:C465(Character code:C91("*");256)
	Else 
		
		  //201706012 ABC-RCH 
		  //Cuando  se marca la opcion de "No calcular promedios" no se ejecuta el metodo EV2_AprobacionReprobacion por ende los alumnos
		  //cuando tienen nota aprobatoria pero estaba reprobados en algún re-calculo previo a la marcación de esta opción 
		  //este codigo servirá para todos los colegios 
		C_BOOLEAN:C305($b_txvalida;$b_aprobado)
		C_LONGINT:C283($l_ProgressProcID;$i)
		ARRAY LONGINT:C221($al_RecNum;0)
		
		$b_txvalida:=True:C214
		
		READ WRITE:C146([Alumnos_Calificaciones:208])
		
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
		  //QUERY([Alumnos_Calificaciones]; & ;[Alumnos_Calificaciones]EvaluacionFinal_Real#-10)
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$al_RecNum)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Revisando Aprobación de Alumnos..."))
		START TRANSACTION:C239
		For ($i;1;Size of array:C274($al_RecNum))
			GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_RecNum{$i})
			If (Not:C34(Locked:C147([Alumnos_Calificaciones:208])))
				EV2_AprobacionReprobacion 
			Else 
				$b_txvalida:=False:C215
				$i:=Size of array:C274($al_RecNum)
			End if 
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
		
		If ($b_txvalida)
			VALIDATE TRANSACTION:C240
		Else 
			CANCEL TRANSACTION:C241
			Self:C308->:=Old:C35(Self:C308->)
			CD_Dlog (0;"Existen registros de Alumnos Calificaciones bloqueados, intente marcar la opción más tarde.")
		End if 
	End if 
End if 
