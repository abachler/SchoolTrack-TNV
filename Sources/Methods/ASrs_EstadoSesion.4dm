//%attributes = {}
  // ASrs_EstadoSesion()
  // Por: Alberto Bachler: 01/07/13, 19:01:27
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_sesionImpartida)
C_DATE:C307($d_fechaSesion)
_O_C_INTEGER:C282($i_alumnos)
C_LONGINT:C283($l_IdAsignatura;$l_idSesion;$l_recNumSesionActual;$l_resultado)
C_TEXT:C284($t_motivo)

ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY LONGINT:C221($al_IdAlumnosAusentesSesion;0)
If (False:C215)
	C_LONGINT:C283(ASrs_EstadoSesion ;$0)
	C_LONGINT:C283(ASrs_EstadoSesion ;$1)
End if 

$l_idSesion:=$1
$b_sesionImpartida:=$2

$l_resultado:=1
KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;True:C214)
$d_fechaSesion:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
$l_IdAsignatura:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2

If (OK=1)
	$l_recNumSesionActual:=Record number:C243([Asignaturas_RegistroSesiones:168])
	Case of 
		: (([Asignaturas_RegistroSesiones:168]Impartida:5=False:C215) & ($b_sesionImpartida=True:C214))
			$l_resultado:=1
			START TRANSACTION:C239
			[Asignaturas_RegistroSesiones:168]Motivo_para_no_impartir:16:=""
			[Asignaturas_RegistroSesiones:168]Impartida:5:=True:C214
			SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
			KRL_ReloadAsReadOnly (->[Asignaturas_RegistroSesiones:168])
			
			READ ONLY:C145([Alumnos_Calificaciones:208])
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_IdAsignatura)
			If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnos)
				For ($i_alumnos;1;Size of array:C274($al_IdAlumnos))
					$l_resultado:=AL_InasistenciaDiariaPorHoras ($al_IdAlumnos{$i_alumnos};$d_fechaSesion)
					If ($l_resultado=0)
						$i_alumnos:=Size of array:C274($al_IdAlumnos)
					End if 
				End for 
			End if 
			If ($l_resultado=1)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
			End if 
			
		: (([Asignaturas_RegistroSesiones:168]Impartida:5=False:C215) & ($b_SesionImpartida=False:C215))
			$t_motivo:=CD_Request ("Por favor indique el motivo para no impartir la sesión";"Aceptar";"Cancelar";"";[Asignaturas_RegistroSesiones:168]Motivo_para_no_impartir:16)
			[Asignaturas_RegistroSesiones:168]Motivo_para_no_impartir:16:=$t_motivo
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=False:C215
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=""
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=""
			SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
			KRL_ReloadAsReadOnly (->[Asignaturas_RegistroSesiones:168])
			
		: (([Asignaturas_RegistroSesiones:168]Impartida:5=True:C214) & ($b_SesionImpartida=False:C215))
			$t_motivo:=CD_Request ("Por favor indique el motivo para no impartir la sesión";"Aceptar";"Cancelar";"";[Asignaturas_RegistroSesiones:168]Motivo_para_no_impartir:16)
			If ((cdB_btn1=1) & ($t_motivo#""))
				START TRANSACTION:C239
				[Asignaturas_RegistroSesiones:168]Motivo_para_no_impartir:16:=$t_motivo
				[Asignaturas_RegistroSesiones:168]Impartida:5:=False:C215
				[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=False:C215
				[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=""
				[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=""
				SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
				KRL_ReloadAsReadOnly (->[Asignaturas_RegistroSesiones:168])
				
				QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$l_idSesion)
				If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
					SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Alumno:2;$al_IdAlumnosAusentesSesion)
					$l_resultado:=KRL_DeleteSelection (->[Asignaturas_Inasistencias:125])
				End if 
				If ($l_resultado=1)
					READ ONLY:C145([Alumnos_Calificaciones:208])
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_IdAsignatura)
					If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnos)
						For ($i_alumnos;1;Size of array:C274($al_IdAlumnos))
							$l_resultado:=AL_InasistenciaDiariaPorHoras ($al_IdAlumnos{$i_alumnos};$d_fechaSesion)
							If ($l_resultado=0)
								$i_alumnos:=Size of array:C274($al_IdAlumnos)
							End if 
						End for 
					End if 
				End if 
				If ($l_resultado=1)
					VALIDATE TRANSACTION:C240
				Else 
					CANCEL TRANSACTION:C241
				End if 
			End if 
	End case 
	KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];$l_recNumSesionActual;False:C215)
Else 
	$l_resultado:=0
End if 

$0:=$l_resultado