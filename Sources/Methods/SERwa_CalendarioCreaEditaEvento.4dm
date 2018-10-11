//%attributes = {}
C_TEXT:C284($0)
C_POINTER:C301($y_Names;$y_Data;$1;$2)

$y_Names:=$1
$y_Data:=$2

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	
	C_TEXT:C284($t_uuidAsignatura;$t_uuidUser;$t_uuidEvento;$t_tipoEvento;$t_evento;$t_descripcion;$t_fecha)
	C_LONGINT:C283($l_evento;$l_idEvento)
	C_DATE:C307($d_fecha)
	C_BOOLEAN:C305($b_publicar;$b_privado)
	C_TIME:C306($h_horaInicio;$h_horaFin)
	C_TEXT:C284($t_uuidEvento)
	C_LONGINT:C283($l_idEventoProc)
	C_LONGINT:C283($l_idUsuario;$l_idProfesor)
	
	$t_uuidAsignatura:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuidasignatura")
	$t_uuidUser:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuidusuario")
	$t_uuidEvento:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuidevento")
	$t_fecha:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fechaevento")
	$d_fecha:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($t_fecha;9;2));Num:C11(Substring:C12($t_fecha;6;2));Num:C11(Substring:C12($t_fecha;1;4)))
	$b_publicar:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"publicar")="true")
	$b_privado:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"privado")="true")
	$t_tipoEvento:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tipoevento")
	$t_evento:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"evento")
	$t_descripcion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"descripcion")
	$h_horaInicio:=Time:C179(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"horainicio"))
	$h_horaFin:=Time:C179(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"horafin"))
	
	$l_evento:=Find in field:C653([Asignaturas_Eventos:170]Auto_UUID:18;$t_uuidEvento)
	If ($l_evento>=0)
		GOTO RECORD:C242([Asignaturas_Eventos:170];$l_evento)
		$l_idEvento:=[Asignaturas_Eventos:170]ID_Event:11
	Else 
		$l_idEvento:=-1
	End if 
	$l_RNAsignatura:=Find in field:C653([Asignaturas:18]auto_uuid:12;$t_uuidAsignatura)
	
	$l_idProfesor:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_uuidUser;->[Profesores:4]Numero:1)
	$l_idUsuario:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$l_idProfesor;->[xShell_Users:47]No:1)
	  //$l_idUsuario:=KRL_GetNumericFieldData (->[xShell_Users]Auto_UUID;->$t_uuidUser;->[xShell_Users]No)
	
	C_OBJECT:C1216($ob_objetoError;$ob_objeto)
	$ob_objetoError:=OB_Create 
	If ($l_RNAsignatura>=0)
		If ($l_idUsuario>0)
			$b_asignaturaExiste:=Calendario_CreaEditaEvento ($l_idEvento;$l_RNAsignatura;$ob_objetoError;$d_fecha;$b_publicar;$b_privado;$t_tipoEvento;$t_evento;$t_descripcion;$h_horaInicio;$h_horaFin;False:C215;$l_idUsuario)
			If ($b_asignaturaExiste)
				READ ONLY:C145([Asignaturas_Eventos:170])
				If (OB Is defined:C1231($ob_objetoError;"idevento"))
					$l_idEventoProc:=Num:C11(OB Get:C1224($ob_objetoError;"idevento"))
				End if 
				If ($l_idEventoProc>0)
					C_OBJECT:C1216($ob_nodo;$ob_raiz;$ob_data)
					
					$t_uuidEvento:=KRL_GetTextFieldData (->[Asignaturas_Eventos:170]ID_Event:11;->$l_idEventoProc;->[Asignaturas_Eventos:170]Auto_UUID:18)
					Calendario_ObtieneEvento ($ob_nodo;[Asignaturas_Eventos:170]ID_Event:11;$l_idUsuario;$l_idProfesor;False:C215)
					
					OB SET:C1220($ob_raiz;"error";"0")
					OB SET:C1220($ob_raiz;"mensaje";"Evento creado")
					OB SET:C1220($ob_objeto;"uuidevento";$t_uuidEvento)
					OB SET:C1220($ob_objeto;"detalleevento";$ob_nodo)
					OB SET:C1220($ob_raiz;"data";$ob_objeto)
					$0:=JSON Stringify:C1217($ob_raiz)
					
				Else 
					If ($l_idEvento=-1)
						$0:=SERwa_GeneraRespuesta ("-5";"Evento no creado")
					Else 
						$0:=SERwa_GeneraRespuesta ("-4";"Evento no modificado")
					End if 
				End if 
			Else 
				$0:=SERwa_GeneraRespuesta ("-3";"Error en la creación del evento. Asignatura no existe "+OB Get:C1224($ob_objetoError;"permiso")+".")
			End if 
		Else 
			$0:=SERwa_GeneraRespuesta ("-1";"Usuario inexistente.")
		End if 
	Else 
		$0:=SERwa_GeneraRespuesta ("-2";"Asignatura inexistente.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 