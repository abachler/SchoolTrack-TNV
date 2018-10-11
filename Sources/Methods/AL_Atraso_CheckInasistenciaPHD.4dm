//%attributes = {}
  //AL_Atraso_CheckInasistenciaPHD 
  //Verificamos con este método si un alumno faltó a una Fecha y Hora de clases
  //cuando existe la configuración de asistencia por hora detallada

C_LONGINT:C283($id_alumno;$nonivel;$numero_dia;$i;$1)
C_DATE:C307($date;$2)
C_TIME:C306($hora;$3)
C_POINTER:C301($ptr_msj;$ptr_num_bloque;$4;$ptr_idAsignatura;$ptr_msg;$7;$9)
C_TEXT:C284($asignatura;$msg)
C_BOOLEAN:C305($5;$vb_permiso;$vb_display_msg;$6;$atraso_intersesion;$8)
ARRAY LONGINT:C221($al_rn_ina;0)
  //MONO 180505
$id_alumno:=$1
$date:=$2
$hora:=$3
$ptr_num_bloque:=$4
$vb_permiso:=$5
$atraso_intersesion:=$6
$ptr_idAsignatura:=$7
$vb_display_msg:=$8
If (Count parameters:C259=9)
	$ptr_msg:=$9
End if 

$nonivel:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alumno;->[Alumnos:2]nivel_numero:29)

READ ONLY:C145([TMT_Horario:166])
READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([Asignaturas_Inasistencias:125])
READ ONLY:C145([Asignaturas_RegistroSesiones:168])

$numHora:=-1

PERIODOS_LoadData ($nonivel)
For ($i;1;Size of array:C274(aiSTR_Horario_HoraNo))
	If (($hora>=alSTR_Horario_Desde{$i}) & ($hora<=alSTR_Horario_Hasta{$i}))
		$numHora:=aiSTR_Horario_HoraNo{$i}
		$i:=Size of array:C274(aiSTR_Horario_HoraNo)
	End if 
End for 

If ($numHora>0)
	  //buscamos si el alumno tiene bloque de horario dentro la hora y el día solicitados
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=$id_alumno)
	KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=DT_GetDayNumber_ISO8601 ($date))
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12<=$date;*)
	QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$date)
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2=$numHora)
	
	If (Records in selection:C76([TMT_Horario:166])>0)
		$ptr_idAsignatura->:=[TMT_Horario:166]ID_Asignatura:5
		QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=$id_alumno;*)
		If ($atraso_intersesion)
			QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Asignatura:6=[TMT_Horario:166]ID_Asignatura:5;*)
		End if 
		QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4=$date;*)
		QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]Dia:7=DT_GetDayNumber_ISO8601 ($date);*)
		
		If ($atraso_intersesion)
			QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]Hora:8=$numHora)
		Else 
			QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]Hora:8>=$numHora)
		End if 
		
		If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
			
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];$al_rn_ina;"")
			$msg:="El alumno(a) se encuentra inasistente en la(s) asignatura(s)"
			For ($i;1;Size of array:C274($al_rn_ina))
				GOTO RECORD:C242([Asignaturas_Inasistencias:125];$al_rn_ina{$i})
				$asignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]denominacion_interna:16)
				$msg:=$msg+"\n "+$asignatura+", en el bloque "+String:C10([Asignaturas_Inasistencias:125]Hora:8)+" el "+String:C10($date)
			End for 
			
			If ($vb_permiso)  //Permiso de reemplazo inasistencia por atraso y permisos de la tabla etc
				
				$msg:=$msg+"\n Esto será reemplazado por el atraso."
				
				START TRANSACTION:C239
				For ($i;1;Size of array:C274($al_rn_ina))
					READ ONLY:C145([Asignaturas_Inasistencias:125])
					GOTO RECORD:C242([Asignaturas_Inasistencias:125];$al_rn_ina{$i})
					$msg_log:="Eliminación de inasistencia por hora detallada del alumno(a) "+[Alumnos:2]apellidos_y_nombres:40+" en la hora "+String:C10([Asignaturas_Inasistencias:125]Hora:8)+" de "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]denominacion_interna:16)
					$msg_log:=$msg_log+" "+"para el día "+String:C10([Asignaturas_Inasistencias:125]dateSesion:4)+", eliminada por ingreso de atraso."
					KRL_DeleteRecord (->[Asignaturas_Inasistencias:125];$al_rn_ina{$i})
					
					If (OK=1)
						LOG_RegisterEvt ($msg_log)
					Else 
						$i:=Size of array:C274($al_rn_ina)
					End if 
					
				End for 
				
				If (OK=1)
					  //revisamos si habia una inasistencia diaria para este alumno por faltar a todas las clases
					READ ONLY:C145([Alumnos_Inasistencias:10])
					QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
					QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$date)
					$rn_inasistencia:=Record number:C243([Alumnos_Inasistencias:10])
					
					If ($rn_inasistencia>=0)
						$msg_log:="Inasistencia diaria ("+String:C10($date)+") para "+[Alumnos:2]apellidos_y_nombres:40+", eliminada por ingreso de atraso"
						KRL_DeleteRecord (->[Alumnos_Inasistencias:10];$rn_inasistencia)
						If (OK=1)
							VALIDATE TRANSACTION:C240
							LOG_RegisterEvt ($msg_log)
							$0:=True:C214
						Else 
							CANCEL TRANSACTION:C241
							$0:=False:C215
							$msg:="El registro de la inasistencia no pudo ser reemplazado por el atraso, por favor intente nuevamente mas tarde."
						End if 
					Else 
						VALIDATE TRANSACTION:C240
						$0:=True:C214
					End if 
					
				Else 
					CANCEL TRANSACTION:C241
					$0:=False:C215
					$msg:="El registro de la inasistencia no pudo ser reemplazado por el atraso, por favor intente nuevamente mas tarde."
				End if 
				
			Else 
				  //sin permiso sólo avisamos que hay una inasistencia
				$0:=False:C215
			End if 
			
		Else 
			$0:=True:C214
		End if 
		
	Else 
		  // sin bloque de horario
		$msg:="No se encuentra un bloque "+String:C10($numHora)+" en el día "+DT_GetDayNameFromDate ($date)+" en el horario o el bloque no tiene vigencia para la fecha "+String:C10($date)
		$0:=False:C215
	End if 
	
Else 
	
	  //sin bloque en la configuración del periodo
	$msg:="No cuenta con un bloque para la hora ingresada en la configuración de horario dentro de la configuración de periodos"
	$0:=False:C215
	
End if 

$ptr_num_bloque->:=$numHora

If (Not:C34(Is nil pointer:C315($ptr_msg)))
	$ptr_msg->:=$msg
End if 

If (($msg#"") & ($vb_display_msg))
	CD_Dlog (0;$msg)
End if 