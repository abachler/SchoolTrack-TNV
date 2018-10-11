//%attributes = {}
  // TMT_ValidaCambiosFechas()
  // Por: Alberto Bachler: 27/05/13, 16:32:30
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)

C_BOOLEAN:C305($b_extensionAplicacion;$b_requiereConfirmacion)
C_DATE:C307($d_inicioSesionesAnterior;$d_nuevoInicioSesiones;$d_nuevoTerminoSesiones;$d_terminoSesionesAnterior)
C_LONGINT:C283($l_Error;$l_idAsignatura;$l_IdProfesor;$l_Inasistencias;$l_numeroDeCiclo;$l_numeroDia_ISO;$l_numeroHora;$l_opcionUsuario;$l_recNumAsignacionHorario;$l_recNumAsignatura)
C_LONGINT:C283($l_Sesiones)
C_TIME:C306($h_horaInicio;$h_horaTermino)
C_TEXT:C284($t_NombreAsignatura;$t_NombreDia;$t_NombreHora;$t_textoError;$t_textoLog)

ARRAY LONGINT:C221($al_RecNumSesiones;0)
If (False:C215)
	C_TEXT:C284(TMT_ValidaCambiosFechas ;$0)
End if 

  // conservo el recnum del registro de asignación de horario actual para reestablecerlo
  // después de buscar conflictos y almacenar las fechas modificadas si son validadas
$l_recNumAsignacionHorario:=Record number:C243([TMT_Horario:166])

$l_numeroDia_ISO:=[TMT_Horario:166]NumeroDia:1
$l_numeroHora:=[TMT_Horario:166]NumeroHora:2
$h_horaInicio:=[TMT_Horario:166]Desde:3
$h_horaTermino:=[TMT_Horario:166]Hasta:4
$l_numeroDeCiclo:=[TMT_Horario:166]No_Ciclo:14
$d_inicioSesionesAnterior:=Old:C35([TMT_Horario:166]SesionesDesde:12)
$d_terminoSesionesAnterior:=Old:C35([TMT_Horario:166]SesionesHasta:13)
$d_nuevoInicioSesiones:=[TMT_Horario:166]SesionesDesde:12
$d_nuevoTerminoSesiones:=[TMT_Horario:166]SesionesHasta:13
$l_idAsignatura:=[TMT_Horario:166]ID_Asignatura:5
$l_IdProfesor:=[TMT_Horario:166]ID_Teacher:9
$l_recNumAsignatura:=Find in field:C653([Asignaturas:18]Numero:1;[TMT_Horario:166]ID_Asignatura:5)

  // Almaceno temporalmente el registro de horario ya que algunas rutinas llamadas desde aquí necesitan
  // oprerar con los valores de los campos almacenados el registro de asignación de horario
  // Si las fechas no son validadas se restablecen a sus valores previos a la modificación
SAVE RECORD:C53([TMT_Horario:166])

Case of 
	: (($d_nuevoInicioSesiones<$d_inicioSesionesAnterior) | ($d_nuevoTerminoSesiones>$d_terminoSesionesAnterior))
		  // las fechas de aplicación fueron extendidas, necesitamos determinar si hay conflictos con otras asignaturas
		$b_extensionAplicacion:=True:C214
		$t_textoError:=TMT_ValidaAsignacion (1;$l_recNumAsignacionHorario)
		If (($t_textoError#"") | (OK=0))  // si se produjo algún error o si el usuario canceló una eventual petición de confirmación (OK=0)
			KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacionHorario;True:C214)
			[TMT_Horario:166]SesionesDesde:12:=$d_inicioSesionesAnterior
			[TMT_Horario:166]SesionesHasta:13:=$d_terminoSesionesAnterior
			SAVE RECORD:C53([TMT_Horario:166])
			If ($t_textoError#"")
				CD_Dlog (0;$t_textoError)
			End if 
		End if 
		
	: (($d_nuevoInicioSesiones>$d_inicioSesionesAnterior) | ($d_nuevoTerminoSesiones<$d_terminoSesionesAnterior))
		QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$l_idAsignatura;*)
		QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=$l_numeroDeCiclo;*)
		QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4;=;$l_numeroHora;*)
		QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]NumeroDia:15;=;$l_numeroDia_ISO)
		Case of 
			: ($d_nuevoInicioSesiones>$d_inicioSesionesAnterior)
				QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=$d_inicioSesionesAnterior;*)
				QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<$d_nuevoInicioSesiones)
				
			: ($d_nuevoTerminoSesiones<$d_terminoSesionesAnterior)  //reducción del rango de aplicación
				QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>$d_nuevoTerminoSesiones;*)
				QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=$d_terminoSesionesAnterior)
		End case 
		SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168];$al_RecNumSesiones)
		KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
		$l_Sesiones:=Size of array:C274($al_RecNumSesiones)
		$l_Inasistencias:=Records in selection:C76([Asignaturas_Inasistencias:125])
		$t_NombreAsignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]denominacion_interna:16)
		$t_NombreDia:=DT_DayNameFromISODayNumber ($l_numeroDia_ISO)
		$t_NombreHora:=String:C10($l_numeroHora)+__ ("ª hora")
		
		If (($l_Inasistencias>0) | ($l_Sesiones>0))
			
			  // Inicializo el componente IT_Confirmacion
			IT_Confirmacion_Inicializa 
			
			  //Cargo los elementos que se mostrarán en el mensaje de confirmación
			Case of 
				: ($l_Inasistencias>0)
					$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("44/_Encabezado_ConSesiones_e_Inasistencias"))
					$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("46/btn1_EliminarSesiones_e_inasistencias"))
					$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("48/btn2_Cancelar"))
					$b_requiereConfirmacion:=True:C214
					
				: ($l_Sesiones>0)
					$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("45/_Encabezado_ConSesiones_sin_Inasistencias"))
					$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("47/btn1_EliminarSesiones"))
					$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("48/btn2_Cancelar"))
				Else 
					$b_requiereConfirmacion:=True:C214
			End case 
			
			  // proceso los tags en en los elementos del mensaje de confirmación
			$l_error:=IT_Confirmacion_AgregaTagValor ("$t_NombreAsignatura";$t_NombreAsignatura)
			$l_error:=IT_Confirmacion_AgregaTagValor ("$t_NombreDia";$t_NombreDia)
			$l_error:=IT_Confirmacion_AgregaTagValor ("$t_nombreHora";$t_nombreHora)
			$l_error:=IT_Confirmacion_AgregaTagValor ("$d_inicioSesiones";String:C10($d_nuevoInicioSesiones;System date abbreviated:K1:2))
			$l_error:=IT_Confirmacion_AgregaTagValor ("$d_terminoSesiones";String:C10($d_nuevoTerminoSesiones;System date abbreviated:K1:2))
			$l_error:=IT_Confirmacion_AgregaTagValor ("$l_Sesiones";String:C10($l_Sesiones))
			$l_error:=IT_Confirmacion_AgregaTagValor ("$l_Inasistencias";String:C10($l_Inasistencias))
			
			  //Muestro el cuadro de diálogo de confirmación
			$t_textoLog:=__ ("Horario ^0: Modificación de fechas de aplicación en una asignación de horario")
			$t_textoLog:=Replace string:C233($t_textoLog;"^0";$t_NombreAsignatura)
			ST SET ATTRIBUTES:C1093($t_textoLog;1;Length:C16($t_textoLog);Attribute bold style:K65:1;1)
			
			$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_textoLog)
			
			If ($l_opcionUsuario>0)
				  // construyo el texto para el registro de actividades
				
				  // proceso la respuesta del usuario
				START TRANSACTION:C239
				Case of 
					: (($l_opcionUsuario=1) & ($l_Inasistencias>0))
						OK:=ASrs_EliminaSesiones (->$al_RecNumSesiones)
						If (OK=0)
							$t_textoError:=__ ("No fue posible eliminar una o más sesiones.\rPor favor intente nuevamente más tarde.")
						End if 
						
					: (($l_opcionUsuario=1) & ($l_Sesiones>0))
						OK:=ASrs_EliminaSesiones (->$al_RecNumSesiones)
						If (OK=0)
							$t_textoError:=__ ("No fue posible eliminar una o más sesiones.\rPor favor intente nuevamente más tarde.")
						End if 
				End case 
				
				KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacionHorario;True:C214)
				If (($t_textoError#"") | (OK=0))
					CANCEL TRANSACTION:C241
					[TMT_Horario:166]SesionesDesde:12:=$d_inicioSesionesAnterior
					[TMT_Horario:166]SesionesHasta:13:=$d_terminoSesionesAnterior
					SAVE RECORD:C53([TMT_Horario:166])
				Else 
					[TMT_Horario:166]SesionesDesde:12:=$d_nuevoInicioSesiones
					[TMT_Horario:166]SesionesHasta:13:=$d_nuevoTerminoSesiones
					SAVE RECORD:C53([TMT_Horario:166])
					VALIDATE TRANSACTION:C240
				End if 
			Else 
				
				  // el usuario cancelo la modificación de fechas
				  //reestablezco las fechas previas a la modificación
				[TMT_Horario:166]SesionesDesde:12:=$d_inicioSesionesAnterior
				[TMT_Horario:166]SesionesHasta:13:=$d_terminoSesionesAnterior
				SAVE RECORD:C53([TMT_Horario:166])
			End if 
			
		End if 
End case 

$0:=$t_textoError