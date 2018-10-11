//%attributes = {}
  //PST_AutoAsignIViewAndPresent

If ([Familia:78]Es_Postulante:18)
	[ADT_Candidatos:49]Es_familia_nueva:27:=True:C214
	  //asignación de entrevista     
	READ WRITE:C146([ADT_Entrevistas:121])
	QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]ID_familia:5=[Alumnos:2]Familia_Número:24)
	If ((Records in selection:C76([ADT_Entrevistas:121])=0) & (viPST_AutoAsigInterview=1))
		$date:=Current date:C33(*)
		QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]ID_familia:5=0;*)
		QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Date_IView:2>$date)
		ORDER BY:C49([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2;>;[ADT_Entrevistas:121]Start_IView:3;>)
		If (Records in selection:C76([ADT_Entrevistas:121])>0)
			[ADT_Entrevistas:121]ID_familia:5:=[Alumnos:2]Familia_Número:24
			SAVE RECORD:C53([ADT_Entrevistas:121])
		End if 
		KRL_ReloadAsReadOnly (->[ADT_Entrevistas:121])
		READ ONLY:C145([Profesores:4])
		RELATE ONE:C42([ADT_Entrevistas:121]ID_Funcionario:1)
		[ADT_Candidatos:49]Fecha_de_Entrevista:4:=[ADT_Entrevistas:121]Date_IView:2
		[ADT_Candidatos:49]Hora_de_entrevista:17:=[ADT_Entrevistas:121]Start_IView:3
		[ADT_Candidatos:49]Entrevistador:20:=[Profesores:4]Apellidos_y_nombres:28
		[ADT_Candidatos:49]ID_Entrevistador:54:=[Profesores:4]Numero:1
	Else 
		If (Records in selection:C76([ADT_Entrevistas:121])=1)
			KRL_ReloadAsReadOnly (->[ADT_Entrevistas:121])
			READ ONLY:C145([Profesores:4])
			RELATE ONE:C42([ADT_Entrevistas:121]ID_Funcionario:1)
			[ADT_Candidatos:49]Fecha_de_Entrevista:4:=[ADT_Entrevistas:121]Date_IView:2
			[ADT_Candidatos:49]Hora_de_entrevista:17:=[ADT_Entrevistas:121]Start_IView:3
			[ADT_Candidatos:49]Entrevistador:20:=[Profesores:4]Apellidos_y_nombres:28
			[ADT_Candidatos:49]ID_Entrevistador:54:=[Profesores:4]Numero:1
			[ADT_Candidatos:49]Es_familia_nueva:27:=False:C215
		End if 
	End if 
	  //fin asignación entrevista
	  //-
	  //asignación presentación
	If ((viPST_AutoAsigPresent=1) & ([ADT_Candidatos:49]secs_Presentación:23=0))
		$flia:=[Alumnos:2]Familia_Número:24
		$id:=[ADT_Candidatos:49]Candidato_numero:1
		SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Familia_numero:30=$flia;*)
		QUERY:C277([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]secs_Presentación:23#0;*)
		QUERY:C277([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]Candidato_numero:1#$id)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($recs=0)
			If ([ADT_Candidatos:49]Asistentes_presentación:22=0)
				If (([Familia:78]Padre_Número:5#0) & ([Familia:78]Madre_Número:6#0))
					[ADT_Candidatos:49]Asistentes_presentación:22:=2
				Else 
					[ADT_Candidatos:49]Asistentes_presentación:22:=1
				End if 
			End if 
			
			$date:=Current date:C33(*)
			$presentationAsigned:=False:C215
			AT_MultiLevelSort (">>";->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
			For ($i;1;Size of array:C274(aiPST_Asistentes))
				If (adPST_PresentDate{$i}>$date)
					If ((aiPST_Asistentes{$i}+[ADT_Candidatos:49]Asistentes_presentación:22)<=viPST_MaxPerPresentation)
						[ADT_Candidatos:49]secs_Presentación:23:=SYS_DateTime2Secs (adPST_PresentDate{$i};aLPST_PresentTime{$i})
						[ADT_Candidatos:49]Fecha_de_presentación:5:=adPST_PresentDate{$i}
						[ADT_Candidatos:49]Hora_de_presentación:18:=aLPST_PresentTime{$i}
						$presentationAsigned:=True:C214
						SAVE RECORD:C53([ADT_Candidatos:49])
						$rn:=Record number:C243([ADT_Candidatos:49])
						While (Semaphore:C143("Saving_parameters"))
							DELAY PROCESS:C323(Current process:C322;5)
						End while 
						aiPST_Asistentes{$i}:=aiPST_Asistentes{$i}+[ADT_Candidatos:49]Asistentes_presentación:22
						PST_SaveParameters 
						If ($rn#-1)
							GOTO RECORD:C242([ADT_Candidatos:49];$rn)
						End if 
						CLEAR SEMAPHORE:C144("Saving_parameters")
						$i:=Size of array:C274(aiPST_Asistentes)+1
					End if 
				End if 
			End for 
			If ($presentationAsigned=False:C215)
				CD_Dlog (0;__ ("No existen fechas de presentación con cupos disponibles.\rNo fue posible asignar una jornada de presentación.\r\rPuede crear una nueva jornada de presentación y reintentarlo."))
			End if 
			SAVE RECORD:C53([ADT_Candidatos:49])
		Else 
			PUSH RECORD:C176([ADT_Candidatos:49])
			QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Familia_numero:30=$flia;*)
			QUERY:C277([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]secs_Presentación:23#0;*)
			QUERY:C277([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]Candidato_numero:1#$id)
			$dts:=[ADT_Candidatos:49]secs_Presentación:23
			$date:=[ADT_Candidatos:49]Fecha_de_presentación:5
			$time:=[ADT_Candidatos:49]Hora_de_presentación:18
			$asist:=[ADT_Candidatos:49]Asistentes_presentación:22
			POP RECORD:C177([ADT_Candidatos:49])
			[ADT_Candidatos:49]secs_Presentación:23:=$dts
			[ADT_Candidatos:49]Fecha_de_presentación:5:=$date
			[ADT_Candidatos:49]Hora_de_presentación:18:=$time
			[ADT_Candidatos:49]Asistentes_presentación:22:=$asist
			[ADT_Candidatos:49]Es_familia_nueva:27:=False:C215
			SAVE RECORD:C53([ADT_Candidatos:49])
		End if 
	Else 
		[ADT_Candidatos:49]Es_familia_nueva:27:=False:C215
		SAVE RECORD:C53([ADT_Candidatos:49])
	End if 
End if 
  //esto va a depender de si se ha asignado o no una entrevista, aunque
  //sea a una familia nueva, si es un postulante que ya tiene familia en el colegio,
  //se debe mostrar si ya se ha asignado una entrevista

If ([Familia:78]Es_Postulante:18=False:C215)
	If (([ADT_Candidatos:49]Fecha_de_presentación:5#!00-00-00!) | ([ADT_Candidatos:49]Fecha_de_Entrevista:4#!00-00-00!))
		OBJECT SET VISIBLE:C603(*;"iview@";True:C214)
		OBJECT SET VISIBLE:C603(*;"datosiview@";True:C214)
		OBJECT SET VISIBLE:C603(*;"pres@";True:C214)
		OBJECT SET VISIBLE:C603(*;"NoPost";False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*;"iview@";False:C215)
		OBJECT SET VISIBLE:C603(*;"datosiview@";False:C215)
		OBJECT SET VISIBLE:C603(*;"pres@";False:C215)
		OBJECT SET VISIBLE:C603(*;"NoPost";True:C214)
	End if 
Else 
	OBJECT SET VISIBLE:C603(*;"iview@";True:C214)
	OBJECT SET VISIBLE:C603(*;"datosiview@";True:C214)
	OBJECT SET VISIBLE:C603(*;"pres@";True:C214)
	OBJECT SET VISIBLE:C603(*;"NoPost";False:C215)
End if 

OBJECT SET VISIBLE:C603(*;"bAsignarIgual";True:C214)
ADT_VistasIViewExam 