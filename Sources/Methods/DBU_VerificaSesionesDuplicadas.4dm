//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 28-03-18, 15:52:05
  // ----------------------------------------------------
  // Método: DBU_VerificaSesionesDuplicadas
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

ARRAY LONGINT:C221($al_recnumAsig;0)
ARRAY LONGINT:C221($al_recnumSesion;0)
ARRAY LONGINT:C221($al_revInasist;0)

C_LONGINT:C283($l_IdProceso;$i_asig;$id_sesion;$i_sesion;$i_ina)
C_TEXT:C284($msg1;$msg2;$llave)
C_REAL:C285($progress1;$progress2)
C_BOOLEAN:C305($b_trapaso)

READ ONLY:C145([Asignaturas:18])
$l_IdProceso:=IT_Progress (1;0;0;"Revisión de registros de sesiones de clases...")
ALL RECORDS:C47([Asignaturas:18])
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recnumAsig;"")

For ($i_asig;1;Size of array:C274($al_recnumAsig))
	GOTO RECORD:C242([Asignaturas:18];$al_recnumAsig{$i_asig})
	$msg1:=[Asignaturas:18]denominacion_interna:16+" - "+[Asignaturas:18]Curso:5
	$progress1:=$i_asig/Size of array:C274($al_recnumAsig)
	
	READ ONLY:C145([Asignaturas_RegistroSesiones:168])
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Año:13=<>gyear)
	ORDER BY:C49([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>;[Asignaturas_RegistroSesiones:168]Hora:4;>)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_recnumSesion;"")
	
	ARRAY TEXT:C222($at_key;0)  //llave fecha y bloque
	ARRAY LONGINT:C221($al_idSesion;0)  //id sesion
	
	For ($i_sesion;1;Size of array:C274($al_recnumSesion))
		
		READ WRITE:C146([Asignaturas_RegistroSesiones:168])
		GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$al_recnumSesion{$i_sesion})
		$llave:=String:C10([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)+"."+String:C10([Asignaturas_RegistroSesiones:168]Ciclo_Numero:9)+"."+String:C10([Asignaturas_RegistroSesiones:168]Hora:4)
		
		$msg2:="Fecha - Ciclo - Bloque: "+$llave
		$progress2:=$i_sesion/Size of array:C274($al_recnumSesion)
		
		$l_IdProceso:=IT_Progress (0;$l_IdProceso;$progress1;$msg1;$progress2;$msg2)
		
		$fia:=Find in array:C230($at_key;$llave)
		If ($fia=-1)
			APPEND TO ARRAY:C911($at_key;$llave)
			APPEND TO ARRAY:C911($al_idSesion;[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
			
		Else 
			READ ONLY:C145([Asignaturas_Inasistencias:125])
			QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
			$ris:=Records in selection:C76([Asignaturas_Inasistencias:125])
			If ($ris>0)
				$b_trapaso:=False:C215
				LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];$al_revInasist;"")
				For ($i_ina;1;Size of array:C274($al_revInasist))
					READ WRITE:C146([Asignaturas_Inasistencias:125])
					GOTO RECORD:C242([Asignaturas_Inasistencias:125];$al_revInasist{$i_ina})
					
					QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Asignaturas_Inasistencias:125]ID_Alumno:2;*)
					QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Asignatura:6=[Asignaturas_Inasistencias:125]ID_Asignatura:6;*)
					QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Sesión:1=$al_idSesion{$fia})
					
					If (Records in selection:C76([Asignaturas_Inasistencias:125])=0)  //si la sesion original con la que nos quedaremos no tiene la inasistencia se la pasamos 
						GOTO RECORD:C242([Asignaturas_Inasistencias:125];$al_revInasist{$i_ina})
						[Asignaturas_Inasistencias:125]ID_Sesión:1:=$al_idSesion{$fia}
						SAVE RECORD:C53([Asignaturas_Inasistencias:125])
						$b_trapaso:=True:C214
					Else   //si la tiene eliminamos esta inasistencia junto a la sesion duplicada 
						GOTO RECORD:C242([Asignaturas_Inasistencias:125];$al_revInasist{$i_ina})
						DELETE RECORD:C58([Asignaturas_Inasistencias:125])
					End if 
					
					KRL_UnloadReadOnly (->[Asignaturas_Inasistencias:125])
				End for 
				
				If ($b_trapaso)
					LOG_RegisterEvt (String:C10($ris)+" registros de asignaturas inasistencia de "+$msg1+", fueron traspasados a la sesion "+$msg2+" ID("+String:C10($al_idSesion{$fia})+"), desde la sesion ID("+String:C10([Asignaturas_RegistroSesiones:168]ID_Sesion:1)+")")
				End if 
				
			End if 
			
			$id_sesion:=[Asignaturas_RegistroSesiones:168]ID_Sesion:1
			DELETE RECORD:C58([Asignaturas_RegistroSesiones:168])
			LOG_RegisterEvt ("Se elimina de "+$msg1+" la sesion "+$msg2+", ID("+String:C10($id_sesion)+"), por que es un duplicado de la sesion ID("+String:C10($al_idSesion{$fia})+")")
		End if 
		
		KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
	End for 
	
End for 
$l_IdProceso:=IT_Progress (-1;$l_IdProceso)
