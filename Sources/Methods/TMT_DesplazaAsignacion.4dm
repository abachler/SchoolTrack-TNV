//%attributes = {}
  // TMT_DesplazaAsignacion()
  // Por: Alberto Bachler: 22/03/13, 10:46:58
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_BOOLEAN:C305($b_asignacionDesplazada;$b_asignarDesdeInicio;$b_asignarDespuesUltimaSesion;$b_desplazamientoAbortado;$b_FechaInicioValida;$b_FechaTerminoValida;$b_FechaValidaDesdeOrigen;$b_FechaValidaEnDestino;$b_HayOtrasAsignaciones)
C_DATE:C307($d_finSesionesOrigen;$d_inicioAño;$d_InicioSesiones;$d_InicioSesionesDestino;$d_InicioSesionesOrigen;$d_primeraSesion;$d_terminoSesiones;$d_ultimaSesion)
C_LONGINT:C283($l_elemento;$l_error;$l_IdAsignatura;$l_idProfesor;$l_ignorar;$l_numeroDeCiclo_Destino;$l_numeroDeCicloOrigen;$l_numeroDeInasistencias;$l_numeroDeSesiones;$l_numeroDia_ISO_Destino)
C_LONGINT:C283($l_numeroDiaOrigen;$l_numeroHora_Destino;$l_numeroHoraOrigen;$l_numeroNivel;$l_recNumCeldaDestino;$l_recNumCeldaOrigen;$l_respuestaUsuario;$l_sesionesEliminadas)
C_TEXT:C284($t_destinoNombreDia;$t_destinoNombreHora;$t_nombreAsignatura;$t_nombreHora;$t_origenNombreDia;$t_origenNombreHora;$t_TextoError;$t_textoLog)

ARRAY DATE:C224($ad_fechasSesiones;0)
ARRAY LONGINT:C221($al_recNumSesiones;0)
ARRAY LONGINT:C221($al_RecNumConflictosHorario;0)
ARRAY LONGINT:C221($al_IdAlumnosEnConflicto;0)
ARRAY LONGINT:C221($al_IdAlumnosEnComun;0)

If (False:C215)
	C_BOOLEAN:C305(TMT_DesplazaAsignacion ;$0)
	C_LONGINT:C283(TMT_DesplazaAsignacion ;$1)
	C_LONGINT:C283(TMT_DesplazaAsignacion ;$2)
	C_LONGINT:C283(TMT_DesplazaAsignacion ;$3)
	C_LONGINT:C283(TMT_DesplazaAsignacion ;$4)
	C_LONGINT:C283(TMT_DesplazaAsignacion ;$5)
End if 

$l_recNumCeldaOrigen:=$1
$l_recNumCeldaDestino:=$2
$l_numeroDia_ISO_Destino:=$3
$l_numeroHora_Destino:=$4
$l_numeroDeCiclo_Destino:=$5

KRL_GotoRecord (->[TMT_Horario:166];$l_recNumCeldaOrigen;False:C215)
$l_IdAsignatura:=[TMT_Horario:166]ID_Asignatura:5
$d_InicioSesionesOrigen:=[TMT_Horario:166]SesionesDesde:12
$d_finSesionesOrigen:=[TMT_Horario:166]SesionesHasta:13
$l_numeroDeCicloOrigen:=[TMT_Horario:166]No_Ciclo:14
$l_numeroDiaOrigen:=[TMT_Horario:166]NumeroDia:1
$l_numeroHoraOrigen:=[TMT_Horario:166]NumeroHora:2
$l_numeroNivel:=[TMT_Horario:166]Nivel:10
$l_idProfesor:=[TMT_Horario:166]ID_Teacher:9

  //temporal, solo para pruebas
  //If (In transaction)
  //CANCEL TRANSACTION
  //End if 

OK:=1
$b_HayConflicto:=TMT_asignaturaEstaAsignada ($l_idAsignatura;$l_IdProfesor;$l_numeroDia_ISO_Destino;$l_numeroHora_Destino;$l_numeroDeCiclo_Destino)
If (Not:C34($b_HayConflicto))
	$l_resultado:=TMT_alumnosEnConflicto (2;$l_recNumCeldaOrigen;$l_numeroDia_ISO_Destino;$l_numeroHora_Destino;$l_numeroDeCiclo_Destino;->$al_RecNumConflictosHorario;->$al_IdAlumnosEnConflicto)
	$b_HayConflicto:=$b_HayConflicto | ($l_resultado#0)
End if 
$b_HayConflicto:=$b_HayConflicto | TMT_ConflictosProfesor (2;$l_recNumCeldaOrigen;$l_numeroDia_ISO_Destino;$l_numeroHora_Destino;$l_numeroDeCiclo_Destino;->$al_RecNumConflictosHorario;->$al_IdAlumnosEnComun)
$b_HayConflicto:=$b_HayConflicto | TMT_validaHoraRecreo ($l_numeroNivel;$l_numeroDia_ISO_Destino;$l_numeroHora_Destino)
If ($b_HayConflicto)
	$t_Error:=__ ("Hay otras asignaciones en conflicto.\r\rNo es posible desplazar esta asignación al día ^0, en la ^1.")
	$t_Error:=Replace string:C233($t_Error;"^0";DT_DayNameFromISODayNumber ($l_numeroDia_ISO_Destino))
	$t_Error:=Replace string:C233($t_Error;"^1";String:C10($l_numeroHora_Destino)+__ ("ª hora"))
	CD_Dlog (0;$t_Error)
	$b_asignacionDesplazada:=False:C215
	
	
	
Else 
	START TRANSACTION:C239
	  // FASE 1
	  // Para asignar sin conflicto necesito determinar cual es la última fecha de sesión creada para las asignaciones existentes en el bloque horario,
	  // y obtener la fecha a partir de la cual puedo crear sesiones para la asignación en dezplazamiento
	  //
	  // 1.1: busco todas las asignaciones actuales en el horario de destino (el usuario puede haber decidido restringirlas al validar la asignación)
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$l_numeroDia_ISO_Destino;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]NumeroHora:2=$l_numeroHora_Destino;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID_Asignatura:5#$l_idAsignatura;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID_Teacher:9#$l_IdProfesor;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]No_Ciclo:14=$l_numeroDeCicloOrigen;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]Nivel:10=$l_numeroNivel)
	
	  // 1. 2: busco todas las sesiones asociadas a las asignaturas actualmente asociadas al bloque horario de destino
	KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[TMT_Horario:166]ID_Asignatura:5)
	QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=$l_numeroDeCiclo_Destino;*)
	QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4;=;$l_numeroHora_Destino;*)
	QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]NumeroDia:15;=;$l_numeroDia_ISO_Destino)
	SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$ad_fechasSesiones)
	If (Size of array:C274($ad_fechasSesiones)>0)
		$b_HayOtrasAsignaciones:=True:C214
		SORT ARRAY:C229($ad_fechasSesiones)
		$d_primeraSesion:=$ad_fechasSesiones{1}
		$d_ultimaSesion:=$ad_fechasSesiones{Size of array:C274($ad_fechasSesiones)}
		$d_InicioSesionesDestino:=$d_ultimaSesion+1  // si hay sesiones determino que la primera fecha posible es la de la ultima sesión mas 1
	Else 
		$d_InicioSesionesDestino:=vdSTR_Periodos_InicioEjercicio  // si no hay ninguna podría asignarse a contar del inicio de año escolar 
	End if 
	
	  // paso 3_ obtengo la primera fecha válida para el dia sobre el que se desplaza la asignación de horario
	$b_FechaValidaEnDestino:=TMT_FechaDiaValidos (->$d_InicioSesionesDestino;vdSTR_Periodos_FinEjercicio;$l_numeroDia_ISO_Destino)
	
	  // FASE 2
	  // Necesito saber cual es la última sesión registrada para la asignación de horario en desplazamiento
	  // para ofrecer al usuario la alternativa entre eliminar las sesiones existentes para esta asignatura en el bloque de origen
	  // y asignar desde la primera fecha posible en destino o bien mantener esas sesiones y asignar a partir de la primera fecha posible sin conflictos
	  // y sin eliminar las sesiones de esta asignatura en la asignación de origen
	KRL_GotoRecord (->[TMT_Horario:166];$l_recNumCeldaOrigen;False:C215)
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$l_IdAsignatura;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[TMT_Horario:166]No_Ciclo:14;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>=;[TMT_Horario:166]SesionesDesde:12;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<=;[TMT_Horario:166]SesionesHasta:13;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4;=;[TMT_Horario:166]NumeroHora:2;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]NumeroDia:15;=;[TMT_Horario:166]NumeroDia:1)
	SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168];$al_recNumSesiones;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$ad_fechasSesiones)
	If (Size of array:C274($ad_fechasSesiones)>0)
		SORT ARRAY:C229($ad_fechasSesiones)
		$d_primeraSesion:=$ad_fechasSesiones{1}
		$d_ultimaSesion:=$ad_fechasSesiones{Size of array:C274($ad_fechasSesiones)}
		$d_InicioSesionesOrigen:=$d_ultimaSesion+1
	Else 
		$d_InicioSesionesOrigen:=vdSTR_Periodos_InicioEjercicio
	End if 
	$b_FechaValidaDesdeOrigen:=TMT_FechaDiaValidos (->$d_InicioSesionesOrigen;vdSTR_Periodos_FinEjercicio;$l_numeroDia_ISO_Destino)
	
	  // determino las fechas de inicio y termino de asignación que permiten conservar la asignación previa en origen
	  // junto con sus sesiones de clases.
	  // si el usuario opta por la opción de mantener la asignación previa en origen hasta la última sesión registrada, se modificarán
	  // las fechas de aplicación en laasignación de origen
	$d_InicioSesiones:=Choose:C955($d_InicioSesionesOrigen>$d_InicioSesionesDestino;$d_InicioSesionesOrigen;$d_InicioSesionesDestino)
	$d_terminoSesiones:=vdSTR_Periodos_FinEjercicio
	$b_FechaInicioValida:=TMT_FechaDiaValidos (->$d_inicioSesiones;vdSTR_Periodos_FinEjercicio;$l_numeroDia_ISO_Destino)
	$b_FechaTerminoValida:=TMT_FechaDiaValidos (->$d_terminoSesiones;$d_inicioSesiones;$l_numeroDia_ISO_Destino)
	
	$l_numeroDeSesiones:=Size of array:C274($al_recNumSesiones)
	KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
	$l_numeroDeInasistencias:=Records in selection:C76([Asignaturas_Inasistencias:125])
	
	$t_nombreAsignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;->[Asignaturas:18]denominacion_interna:16)
	$t_origenNombreDia:=DT_DayNameFromISODayNumber ([TMT_Horario:166]NumeroDia:1)
	$t_origenNombreHora:=String:C10([TMT_Horario:166]NumeroHora:2)+"ª hora"
	$t_destinoNombreDia:=DT_DayNameFromISODayNumber ($l_numeroDia_ISO_Destino)
	$t_destinoNombreHora:=String:C10($l_numeroHora_Destino)+"ª hora"
	
	$d_inicioAño:=vdSTR_Periodos_InicioEjercicio
	
	If ($b_FechaInicioValida & $b_FechaTerminoValida)
		If (($l_numeroDeInasistencias>0) | ($l_numeroDeSesiones>0))
			
			  // introduzco un delay de 1/2 segundo para que los mensajes demasiado cercanos en el tiempo confundan al usuario
			If ($b_HayOtrasAsignaciones)
				DELAY PROCESS:C323(Current process:C322;60)
				BEEP:C151
			End if 
			
			  // Inicializo el componente IT_Confirmacion
			IT_Confirmacion_Inicializa 
			
			If ($b_HayOtrasAsignaciones)
				$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("82/Encabezado_ConConflictosPrevios"))
			Else 
				$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("4/Encabezado_SoloSesiones"))
			End if 
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("5/Boton1_Mantener_y_CrearSesionesDesdeHoy"))
			If ($b_HayOtrasAsignaciones=False:C215)
				$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("9/Boton2b_Eliminar_y_recrearSesionesDesdeinicio"))
			End if 
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("10/Boton3b_Eliminar_y_RecrearSesionesDesdeHoy"))
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("8/Botón4_CancelarDesplazamiento"))
			
			  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_inicioAño";String:C10($d_inicioAño;System date abbreviated:K1:2))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_inicioSesiones";String:C10($d_inicioSesiones;System date abbreviated:K1:2))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_primeraSesion";String:C10($d_primeraSesion;System date abbreviated:K1:2))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_ultimaSesion";String:C10($d_ultimaSesion;System date abbreviated:K1:2))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_numeroDeInasistencias";String:C10($l_numeroDeInasistencias))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_numeroDeSesiones";String:C10($l_numeroDeSesiones))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_destinoNombreDia";$t_destinoNombreDia)
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_destinoNombreHora";$t_destinoNombreHora)
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_nombreAsignatura";$t_nombreAsignatura)
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_nombreHora";$t_nombreHora)
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_origenNombreDia";$t_origenNombreDia)
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_origenNombreHora";$t_origenNombreHora)
			
			$t_textoLog:=__ ("Horario ^0: Desplazamiento de la asignación a otro bloque horario.")
			$t_textoLog:=Replace string:C233($t_textoLog;"^0";$t_nombreAsignatura)
			ST SET ATTRIBUTES:C1093($t_textoLog;1;Length:C16($t_textoLog);Attribute bold style:K65:1;1)
			
			$l_respuestaUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
			
		Else 
			  // no hay sesiones registradas, solo se modifica la asignación
			  // re-crear sesiones desde el inicio del año escolar
			$l_respuestaUsuario:=0
			KRL_ReloadInReadWriteMode (->[TMT_Horario:166])
			[TMT_Horario:166]NumeroHora:2:=$l_numeroHora_Destino
			[TMT_Horario:166]NumeroDia:1:=$l_numeroDia_ISO_Destino
			SAVE RECORD:C53([TMT_Horario:166])
			TMT_CreaSesiones (Record number:C243([TMT_Horario:166]);vdSTR_Periodos_InicioEjercicio;Current date:C33(*))
			VALIDATE TRANSACTION:C240
			$b_asignacionDesplazada:=True:C214
		End if 
		
		Case of 
			: ($l_respuestaUsuario=0)
				$b_desplazamientoAbortado:=True:C214
				CANCEL TRANSACTION:C241
				  // nada, usuario canceló el desplazamiento
				
			: (($l_respuestaUsuario=3) | ($l_respuestaUsuario=2))
				Case of 
					: (($b_HayOtrasAsignaciones) & ($l_respuestaUsuario=2))
						$b_asignarDespuesUltimaSesion:=True:C214
					: (($b_HayOtrasAsignaciones=False:C215) & ($l_respuestaUsuario=2))
						$b_asignarDesdeInicio:=True:C214
					: ($l_respuestaUsuario=3)
						$b_asignarDespuesUltimaSesion:=True:C214
				End case 
				
				  // eliminar sesiones e inasistencias existentes y
				  // re-crear sesiones desde el inicio del año escolar o crear sesiones a contar de hoy
				$l_sesionesEliminadas:=ASrs_EliminaSesiones (->$al_recNumSesiones)
				If ($l_sesionesEliminadas=1)
					Case of 
						: ($b_asignarDesdeInicio)
							  // re-crear sesiones desde el inicio del año escolar
							$d_inicioSesiones:=vdSTR_Periodos_InicioEjercicio
							$d_terminoSesiones:=vdSTR_Periodos_FinEjercicio
							$b_FechaInicioValida:=TMT_FechaDiaValidos (->$d_inicioSesiones;vdSTR_Periodos_FinEjercicio;$l_numeroDia_ISO_Destino)
							$b_FechaTerminoValida:=TMT_FechaDiaValidos (->$d_terminoSesiones;$d_inicioSesiones;$l_numeroDia_ISO_Destino)
							KRL_ReloadInReadWriteMode (->[TMT_Horario:166])
							[TMT_Horario:166]NumeroHora:2:=$l_numeroHora_Destino
							[TMT_Horario:166]NumeroDia:1:=$l_numeroDia_ISO_Destino
							[TMT_Horario:166]SesionesDesde:12:=$d_inicioSesiones
							[TMT_Horario:166]SesionesHasta:13:=$d_terminoSesiones
							SAVE RECORD:C53([TMT_Horario:166])
							TMT_CreaSesiones (Record number:C243([TMT_Horario:166]);vdSTR_Periodos_InicioEjercicio;Current date:C33(*))
							
						: ($b_asignarDespuesUltimaSesion)
							  // crear sesiones a contar de hoy
							KRL_ReloadInReadWriteMode (->[TMT_Horario:166])
							[TMT_Horario:166]NumeroHora:2:=$l_numeroHora_Destino
							[TMT_Horario:166]NumeroDia:1:=$l_numeroDia_ISO_Destino
							[TMT_Horario:166]SesionesDesde:12:=$d_inicioSesiones
							[TMT_Horario:166]SesionesHasta:13:=$d_terminoSesiones
							SAVE RECORD:C53([TMT_Horario:166])
							TMT_CreaSesiones (Record number:C243([TMT_Horario:166]);[TMT_Horario:166]SesionesDesde:12;Current date:C33(*))
					End case 
					TMT_CuentaHorasClases ($l_IdAsignatura)
					VALIDATE TRANSACTION:C240
					$b_asignacionDesplazada:=True:C214
				Else 
					CANCEL TRANSACTION:C241
				End if 
				
			: ($l_respuestaUsuario=1)
				  // mantener sesiones de clases e inasistencias en la asignación anterior y
				  // crear nuevas sesiones a contar de hoy en la nueva asignación de horario
				KRL_ReloadInReadWriteMode (->[TMT_Horario:166])
				[TMT_Horario:166]SesionesHasta:13:=$d_ultimaSesion
				SAVE RECORD:C53([TMT_Horario:166])
				
				DUPLICATE RECORD:C225([TMT_Horario:166])
				[TMT_Horario:166]NumeroHora:2:=$l_numeroHora_Destino
				[TMT_Horario:166]NumeroDia:1:=$l_numeroDia_ISO_Destino
				[TMT_Horario:166]Auto_UUID:17:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
				$l_elemento:=Find in array:C230(aiSTR_Horario_HoraNo;[TMT_Horario:166]NumeroHora:2)
				If ($l_elemento>0)
					[TMT_Horario:166]Desde:3:=alSTR_Horario_Desde{$l_elemento}
					[TMT_Horario:166]Hasta:4:=alSTR_Horario_Hasta{$l_elemento}
				End if 
				[TMT_Horario:166]SesionesDesde:12:=$d_inicioSesiones
				[TMT_Horario:166]SesionesHasta:13:=vdSTR_Periodos_FinEjercicio
				SAVE RECORD:C53([TMT_Horario:166])
				TMT_CreaSesiones (Record number:C243([TMT_Horario:166]);[TMT_Horario:166]SesionesDesde:12;Current date:C33(*))
				TMT_CuentaHorasClases ($l_IdAsignatura)
				VALIDATE TRANSACTION:C240
				$b_asignacionDesplazada:=True:C214
				
		End case 
	Else 
		$l_ignorar:=CD_Dlog (0;"No hay fechas válida disponibles para asignar esta asignatura al este bloque horario.\r\rEl desplazamiento no puede completarse.")
		CANCEL TRANSACTION:C241
	End if 
End if 

$0:=$b_asignacionDesplazada

