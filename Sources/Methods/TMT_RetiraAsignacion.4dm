//%attributes = {}
  // TMT_RetiraAsignacion()
  // Por: Alberto Bachler: 22/05/13, 08:54:40
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_DATE:C307($d_finSesionesOrigen;$d_InicioSesionesOrigen;$d_primeraSesion;$d_ultimaSesion)
C_LONGINT:C283($l_error;$l_IdAsignatura;$l_numeroDeCiclo;$l_numeroDeInasistencias;$l_numeroDeSesiones;$l_opcionUsuario;$l_renumAsignacionHorario)
C_TEXT:C284($t_nombreAsignatura;$t_NombreDia;$t_NombreHora;$t_TextoError;$t_textoLog)

ARRAY DATE:C224($ad_fechasSesiones;0)
ARRAY LONGINT:C221($al_recNumAsignaciones;0)
If (False:C215)
	C_TEXT:C284(TMT_RetiraAsignacion ;$0)
	C_LONGINT:C283(TMT_RetiraAsignacion ;$1)
End if 

$l_renumAsignacionHorario:=$1
KRL_GotoRecord (->[TMT_Horario:166];$l_renumAsignacionHorario;True:C214)
If (OK=1)
	
	$l_IdAsignatura:=[TMT_Horario:166]ID_Asignatura:5
	$d_InicioSesionesOrigen:=[TMT_Horario:166]SesionesDesde:12
	$d_finSesionesOrigen:=[TMT_Horario:166]SesionesHasta:13
	$l_numeroDeCiclo:=[TMT_Horario:166]No_Ciclo:14
	
	KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;False:C215)
	$t_nombreAsignatura:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5
	$t_NombreDia:=DT_DayNameFromISODayNumber ([TMT_Horario:166]NumeroDia:1)
	$t_NombreHora:=String:C10([TMT_Horario:166]NumeroHora:2)+__ ("ª hora")
	
	  // Verifico si hay sesiones de clases registradas en esta asignación de horario
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[TMT_Horario:166]ID_Asignatura:5;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[TMT_Horario:166]No_Ciclo:14;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>=;[TMT_Horario:166]SesionesDesde:12;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<=;[TMT_Horario:166]SesionesHasta:13;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4;=;[TMT_Horario:166]NumeroHora:2;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]NumeroDia:15;=;[TMT_Horario:166]NumeroDia:1)
	CREATE SET:C116([Asignaturas_RegistroSesiones:168];"$sesiones_a_eliminar")
	SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$ad_fechasSesiones)
	If (Size of array:C274($ad_fechasSesiones)>0)
		SORT ARRAY:C229($ad_fechasSesiones)
		$d_primeraSesion:=$ad_fechasSesiones{1}
		$d_ultimaSesion:=$ad_fechasSesiones{Size of array:C274($ad_fechasSesiones)}
	End if 
	
	$l_numeroDeSesiones:=Records in set:C195("$sesiones_a_eliminar")
	USE SET:C118("$sesiones_a_eliminar")
	
	KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
	CREATE SET:C116([Asignaturas_Inasistencias:125];"$inasistencias_a_eliminar")
	$l_numeroDeInasistencias:=Records in set:C195("$inasistencias_a_eliminar")
	
	IT_Confirmacion_Inicializa 
	
	Case of 
		: ($l_numeroDeInasistencias>0)
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("35/_EncabezadoConSesiones_e_inasistencias"))
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("38/btn1_MantenerHastaHoy"))
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("37/btn2_EliminarSesiones_e_Inasistencias"))
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("39/btn3_Cancelar"))
			
		: ($l_numeroDeSesiones>0)
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("40/_EncabezadoConSesiones_sin_inasistencias"))
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("38/btn1_MantenerHastaHoy"))
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("42/btn2_EliminarSesiones"))
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("39/btn3_Cancelar"))
			
	End case 
	
	$l_error:=IT_Confirmacion_AgregaTagValor ("$t_nombreAsignatura";$t_nombreAsignatura)
	$l_error:=IT_Confirmacion_AgregaTagValor ("$l_numeroDeSesiones";String:C10($l_numeroDeSesiones))
	$l_error:=IT_Confirmacion_AgregaTagValor ("$l_numeroDeInasistencias";String:C10($l_numeroDeInasistencias))
	$l_error:=IT_Confirmacion_AgregaTagValor ("$d_primeraSesion";String:C10($d_primeraSesion;Internal date short special:K1:4))
	$l_error:=IT_Confirmacion_AgregaTagValor ("$d_ultimaSesion";String:C10($d_ultimaSesion;Internal date short special:K1:4))
	$l_error:=IT_Confirmacion_AgregaTagValor ("$t_NombreDia";$t_NombreDia)
	$l_error:=IT_Confirmacion_AgregaTagValor ("$t_NombreHora";$t_NombreHora)
	
	$t_textoLog:=__ ("Horario ^0: Retiro de asignación de bloque de horario.")
	$t_textoLog:=Replace string:C233($t_textoLog;"^0";$t_nombreAsignatura)
	$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_textoLog)
	
	Case of 
		: (($l_numeroDeSesiones=0) & ($l_numeroDeInasistencias=0))
			OK:=KRL_DeleteRecord (->[TMT_Horario:166])
			If (OK=1)
				$t_TextoError:=""
			Else 
				$t_TextoError:=__ ("La asignatura no pudo ser retirada del bloque horario asignado.\r\rPor favor intente nuevamente más tarde.")
			End if 
			
		: ($l_OpcionUsuario=2)  // eliminar sesiones e inasistencias cuando existen
			APPEND TO ARRAY:C911($al_recNumAsignaciones;$l_renumAsignacionHorario)
			OK:=TMT_EliminaSesionesAsociadas (->$al_recNumAsignaciones)
			If (OK=1)
				OK:=KRL_DeleteRecord (->[TMT_Horario:166])
				If (OK=0)
					$t_TextoError:=__ ("La asignatura no pudo ser retirada del bloque horario asignado.\r\rPor favor intente nuevamente más tarde.")
				End if 
			Else 
				$t_TextoError:=__ ("La asignatura no pudo ser retirada del bloque horario asignado.\r\rPor favor intente nuevamente más tarde.")
			End if 
			
		: ($l_OpcionUsuario=1)  // mantener sesiones de clases y asignación hasta la fecha de la última asignación registrada.
			[TMT_Horario:166]SesionesHasta:13:=$d_ultimaSesion
			SAVE RECORD:C53([TMT_Horario:166])
			KRL_UnloadReadOnly (->[TMT_Horario:166])
			
		: ($l_OpcionUsuario=0)  // cancelar
			
	End case 
Else 
	$t_TextoError:=__ ("La asignatura no pudo ser retirada del bloque horario asignado.\r\rPor favor intente nuevamente más tarde.")
End if 

$0:=$t_TextoError
