//%attributes = {}
  // TMT_ValidaAsignacion()
  // Por: Alberto Bachler: 15/05/13, 16:27:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_BOOLEAN:C305($b_enTransaccion;$b_asignar;$b_AsignarAntes;$b_AsignarAntesPosible;$b_AsignarDespues;$b_AsignarDespuesPosible;$b_asignaturaYaAsignada;$b_ConflictoProfesor;$b_eliminarSesiones;$b_extensionFechasAplicacion)
C_DATE:C307($d_inicioSesiones;$d_inicioSesionesAntes;$d_inicioSesionesDespues;$d_PrimeraSesion;$d_terminoSesiones;$d_terminoSesionesAntes;$d_terminoSesionesDespues;$d_ultimaSesion)
C_LONGINT:C283($l_alumnosDistintos;$l_alumnosEnComun;$l_alumnosEnConflicto;$l_asignacionesProfesor;$l_asignacionValida;$l_asignaturasEnConflicto;$l_Error;$l_IdAsignatura;$l_IdProfesor;$l_inasistencias)
C_LONGINT:C283($l_NumeroDeCiclo;$l_numeroDia_ISO;$l_numeroHora;$l_numeroNivel;$l_opcionUsuario;$l_recNumAsignacionHorario;$l_recNumAsignatura;$l_resultado;$l_Sesiones;$l_tipoValidacion)
C_TEXT:C284($t_NombreAsignatura;$t_nombreDia;$t_nombreHora;$t_NombreProfesor;$t_rangoAplicacion;$t_textoDetalle;$t_textoError;$t_textoLog;$t_titulo)

ARRAY DATE:C224($ad_FechaSesiones;0)
ARRAY LONGINT:C221($al_IdAlumnosDistintos;0)
ARRAY LONGINT:C221($al_IdAlumnosEnComun;0)
ARRAY LONGINT:C221($al_IdAlumnosEnConflicto;0)
ARRAY LONGINT:C221($al_IdSesiones;0)
ARRAY LONGINT:C221($al_RecNumConflictosHorario;0)
ARRAY TEXT:C222($at_curso;0)
ARRAY TEXT:C222($at_nombresAlumnos;0)
ARRAY TEXT:C222($at_NombresAsignatura;0)

If (False:C215)
	C_TEXT:C284(TMT_ValidaAsignacion ;$0)
	C_LONGINT:C283(TMT_ValidaAsignacion ;$1)
	C_LONGINT:C283(TMT_ValidaAsignacion ;$2)
	C_LONGINT:C283(TMT_ValidaAsignacion ;$3)
	C_LONGINT:C283(TMT_ValidaAsignacion ;$4)
	C_LONGINT:C283(TMT_ValidaAsignacion ;$5)
End if 

$l_tipoValidacion:=$1
Case of 
	: ($l_tipoValidacion=0)  // asignación de una asignatura
		$l_recNumAsignatura:=$2
		$l_numeroDia_ISO:=$3
		$l_numeroHora:=$4
		$l_NumeroDeCiclo:=$5
		KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;False:C215)
		$l_IdAsignatura:=[Asignaturas:18]Numero:1
		$l_IdProfesor:=[Asignaturas:18]profesor_numero:4
		$l_numeroNivel:=[Asignaturas:18]Numero_del_Nivel:6
		PERIODOS_LoadData ($l_numeroNivel)
		$d_inicioSesiones:=vdSTR_Periodos_InicioEjercicio
		$d_terminoSesiones:=vdSTR_Periodos_FinEjercicio
		$t_textoLog:=__ ("Horario ^0: Asignación a bloque horario.")
		ST SET ATTRIBUTES:C1093($t_textoLog;1;Length:C16($t_textoLog);Attribute bold style:K65:1;1)
		
	: ($l_tipoValidacion=1)  // modificación de fechas de una asignación a un bloque horario
		$b_extensionFechasAplicacion:=True:C214
		$l_recNumAsignacionHorario:=$2
		KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacionHorario;False:C215)
		$l_IdAsignatura:=[TMT_Horario:166]ID_Asignatura:5
		$l_IdProfesor:=[TMT_Horario:166]ID_Teacher:9
		$l_numeroDia_ISO:=[TMT_Horario:166]NumeroDia:1
		$l_numeroHora:=[TMT_Horario:166]NumeroHora:2
		$l_numeroDeCiclo:=[TMT_Horario:166]No_Ciclo:14
		$l_numeroNivel:=[TMT_Horario:166]Nivel:10
		$d_inicioSesiones:=[TMT_Horario:166]SesionesDesde:12
		$d_terminoSesiones:=[TMT_Horario:166]SesionesHasta:13
		$t_textoLog:=__ ("Horario ^0: Extension de fechas de aplicacion.")
		ST SET ATTRIBUTES:C1093($t_textoLog;1;Length:C16($t_textoLog);Attribute bold style:K65:1;1)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;False:C215)
		
	: ($l_tipoValidacion=2)  // desplazamiento de una asignación existente a otro bloque horario
		$l_recNumAsignacionHorario:=$2
		KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacionHorario;False:C215)
		$l_IdAsignatura:=[TMT_Horario:166]ID_Asignatura:5
		$l_IdProfesor:=[TMT_Horario:166]ID_Teacher:9
		$d_inicioSesiones:=[TMT_Horario:166]SesionesDesde:12
		$d_terminoSesiones:=[TMT_Horario:166]SesionesHasta:13
		$l_numeroDia_ISO:=$3
		$l_numeroHora:=$4
		$l_NumeroDeCiclo:=$5
		$t_textoLog:=__ ("Horario ^0: Desplazamiento de una asignación.")
		ST SET ATTRIBUTES:C1093($t_textoLog;1;Length:C16($t_textoLog);Attribute bold style:K65:1;1)
		$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;False:C215)
End case 

$t_NombreAsignatura:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5
$l_IdAsignatura:=[Asignaturas:18]Numero:1
$l_IdProfesor:=[Asignaturas:18]profesor_numero:4
$t_NombreProfesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_numero:4;->[Profesores:4]Nombre_comun:21)
$t_nombreDia:=DT_DayNameFromISODayNumber ($l_numeroDia_ISO)
$t_nombreHora:=String:C10($l_numeroHora)+"ª hora"
$t_textoLog:=Replace string:C233($t_textoLog;"^0";$t_NombreAsignatura)

  // 1. DETERMINAMOS SI EXISTEN CONFLICTOS O INCONSISTENCIAS QUE IMPIDEN LA ASIGNACION AL HORARIO
  //    O REQUIEREN UNA DECISION O CONFIRMACIÓN DEL USUARIO

  // si la peticion de validación no se origina en una extensión de fechas de aplicación en el formulario de asignación
  // verifico si la asignatura que se desea asignar ya está asignada el mismo día en la misma hora
If (Not:C34($b_extensionFechasAplicacion))
	$b_asignaturaYaAsignada:=TMT_asignaturaEstaAsignada ($l_idAsignatura;$l_IdProfesor;$l_numeroDia_ISO;$l_numeroHora;$l_numeroDeCiclo)
End if 

If (Not:C34($b_asignaturaYaAsignada))
	  // verifico que los alumnos de la asignatura que se desean asignar no tengan asignadas otras asignaturas
	  // con distinto profesor en el mismo día y hora
	If ($l_tipoValidacion=0)
		$l_resultado:=TMT_alumnosEnConflicto ($l_tipoValidacion;$l_recNumAsignatura;$l_numeroDia_ISO;$l_numeroHora;$l_numeroDeCiclo;->$al_RecNumConflictosHorario;->$al_IdAlumnosEnConflicto)
	Else 
		$l_resultado:=TMT_alumnosEnConflicto ($l_tipoValidacion;$l_recNumAsignacionHorario;$l_numeroDia_ISO;$l_numeroHora;$l_numeroDeCiclo;->$al_RecNumConflictosHorario;->$al_IdAlumnosEnConflicto)
	End if 
	Case of 
		: ($l_resultado=0)  // no hay conflictos
			$l_alumnosEnConflicto:=0
			$l_asignaturasEnConflicto:=0
		: ($l_resultado>0)  // numero de alumnos en conflictos
			$l_alumnosEnConflicto:=$l_resultado
		: ($l_resultado<0)  // numero de asignaturas en conflicto
			$l_asignaturasEnConflicto:=Abs:C99($l_resultado)
	End case 
End if 

  //If ((Not($b_asignaturaYaAsignada)) & ($l_asignaturasEnConflicto=0) & ($l_alumnosEnConflicto=0))
If ((Not:C34($b_asignaturaYaAsignada)) & ($l_alumnosEnConflicto=0))
	If ($l_tipoValidacion=0)
		$b_ConflictoProfesor:=TMT_ConflictosProfesor ($l_tipoValidacion;$l_recNumAsignatura;$l_numeroDia_ISO;$l_numeroHora;$l_numeroDeCiclo;->$al_RecNumConflictosHorario;->$al_IdAlumnosEnComun)
	Else 
		$b_ConflictoProfesor:=TMT_ConflictosProfesor ($l_tipoValidacion;$l_recNumAsignacionHorario;$l_numeroDia_ISO;$l_numeroHora;$l_numeroDeCiclo;->$al_RecNumConflictosHorario;->$al_IdAlumnosEnComun)
	End if 
End if 
If ($b_ConflictoProfesor)
	$l_asignacionesProfesor:=Size of array:C274($al_RecNumConflictosHorario)
	$l_alumnosDistintos:=Size of array:C274($al_IdAlumnosDistintos)
	$l_alumnosEnComun:=Size of array:C274($al_IdAlumnosEnComun)
End if 

Case of 
	: ($b_asignaturaYaAsignada)
		BEEP:C151
	: (($l_alumnosEnConflicto=0) & ($l_asignaturasEnConflicto=0) & ($b_ConflictoProfesor=False:C215))
		  // La asignatura no estaba asignada y no hay ningún tipo de conflicto. No hay mensaje de confirmación mostrar
		  // fuerzo la variable l opción usuario para asignar la asignatura o extender la asignación o asignar la asignatura
		  // dejo registro de la asignación o extensión en el registro de actividades
		$l_opcionUsuario:=1
		$b_asignar:=True:C214
		If ($l_tipoValidacion=0)
			$t_rangoAplicacion:=String:C10($d_InicioSesiones;System date abbreviated:K1:2)+" - "+String:C10($d_TerminoSesiones;System date abbreviated:K1:2)
			$t_textoLog:=$t_TextoLog+$t_nombreDia+", "+$t_NombreHora+"\r"+$t_rangoAplicacion
			  //ST SET ATTRIBUTES($t_textoLog;1;Length($t_textoLog);Attribute bold style;1)
			LOG_RegisterEvt ($t_textoLog)
		End if 
		
	: (($l_alumnosEnConflicto=0) & ($l_asignaturasEnConflicto>0) & ($b_ConflictoProfesor=False:C215))
		  //  Hay otras asignaturas asignadas en el nivel pero no hay conflictos entre alumnos ni entre profesores
		$l_opcionUsuario:=1
		$b_asignar:=True:C214
		If ($l_tipoValidacion=0)
			$t_rangoAplicacion:=String:C10($d_InicioSesiones;System date abbreviated:K1:2)+" - "+String:C10($d_TerminoSesiones;System date abbreviated:K1:2)
			$t_textoLog:=$t_TextoLog+$t_nombreDia+", "+$t_NombreHora+"\r"+$t_rangoAplicacion
			LOG_RegisterEvt ($t_textoLog)
		End if 
		
		
	: (($l_alumnosEnConflicto>0) & ($b_ConflictoProfesor=False:C215))
		  // hay alumnos en la asignatura que se desea asignar con sesiones de clases en otras asignaturas con distintos profesores en el mismo horario
		  // esto solo es permitido cuando no hay sopreposicion de las fechas de aplicacion de ninguna asignatura
		  // el usuario debe optar por alguna de las opciones de asignacion
		
		CREATE SELECTION FROM ARRAY:C640([TMT_Horario:166];$al_RecNumConflictosHorario)
		KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5)
		SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$at_NombresAsignatura;[Asignaturas:18]Curso:5;$at_curso)
		For ($i;1;Size of array:C274($at_NombresAsignatura))
			$at_NombresAsignatura{$i}:=$at_NombresAsignatura{$i}+", "+$at_curso{$i}
		End for 
		SORT ARRAY:C229($at_NombresAsignatura)
		$t_titulo:=__ ("Asignaturas con profesores distintos ya asignadas a este bloque horario: ")
		$t_titulo:=Replace string:C233($t_titulo;"^0";$t_nombreProfesor)
		ST SET ATTRIBUTES:C1093($t_titulo;1;Length:C16($t_titulo);Attribute bold style:K65:1;1)
		$t_textoDetalle:=$t_titulo
		$t_textoDetalle:=$t_textoDetalle+"\r"+AT_array2text (->$at_NombresAsignatura;"\r")
		If (Size of array:C274($al_IdAlumnosEnConflicto)>0)
			QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$al_IdAlumnosEnConflicto)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_nombresAlumnos)
			SORT ARRAY:C229($at_nombresAlumnos)
			$t_titulo:=__ ("Alumnos en común con las asignaturas ya asignadas: ")
			ST SET ATTRIBUTES:C1093($t_titulo;1;Length:C16($t_titulo);Attribute bold style:K65:1;1)
			$t_textoDetalle:=$t_textoDetalle+"\r\r"+$t_titulo
			$t_textoDetalle:=$t_textoDetalle+"\r"+AT_array2text (->$at_nombresAlumnos;"\r")
		End if 
		
		$b_AsignarDespuesPosible:=False:C215
		$b_AsignarAntesPosible:=False:C215
		$l_alumnosEnConflicto:=Size of array:C274($al_IdAlumnosEnConflicto)
		KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[TMT_Horario:166]ID_Asignatura:5)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]NumeroDia:15=$l_numeroDia_ISO;*)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]NumeroDia:15=$l_numeroDia_ISO)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_numeroHora)
		If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
			SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_IdSesiones;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$ad_FechaSesiones)
			QUERY WITH ARRAY:C644([Asignaturas_Inasistencias:125]ID_Sesión:1;$al_IdSesiones)
			$l_inasistencias:=Records in selection:C76([Asignaturas_Inasistencias:125])
			$l_Sesiones:=Size of array:C274($ad_FechaSesiones)
			SORT ARRAY:C229($ad_FechaSesiones;>)
			$d_PrimeraSesion:=$ad_FechaSesiones{1}
			$d_ultimaSesion:=$ad_FechaSesiones{Size of array:C274($ad_FechaSesiones)}
			
			  // determino cual es la primera fecha disponible y válida después de la última sesión registrada en asignaciones anteriores
			$d_inicioSesionesDespues:=$d_ultimaSesion+1
			$d_terminoSesionesDespues:=vdSTR_Periodos_FinEjercicio
			If ($d_inicioSesionesDespues<$d_terminoSesionesDespues)
				$b_AsignarDespuesPosible:=TMT_FechaDiaValidos (->$d_inicioSesionesDespues;$d_terminoSesionesDespues;$l_numeroDia_ISO)
				$b_AsignarDespuesPosible:=TMT_FechaDiaValidos (->$d_terminoSesionesDespues;$d_inicioSesionesDespues;$l_numeroDia_ISO)
			End if 
			
			  // determino cual es la primera fecha disponible y válida antes de la primera sesión registrada en asignaciones anteriores
			$d_inicioSesionesAntes:=vdSTR_Periodos_InicioEjercicio
			$d_terminoSesionesAntes:=$d_PrimeraSesion-1
			If ($d_terminoSesionesAntes>$d_inicioSesionesAntes)
				$b_AsignarAntesPosible:=TMT_FechaDiaValidos (->$d_inicioSesionesAntes;vdSTR_Periodos_InicioEjercicio;$l_numeroDia_ISO)
				$b_AsignarAntesPosible:=TMT_FechaDiaValidos (->$d_terminoSesionesAntes;$d_inicioSesionesAntes;$l_numeroDia_ISO)
			End if 
			
		End if 
		
		  // Inicializo el componente IT_Confirmacion
		IT_Confirmacion_Inicializa 
		
		  //Cargo los elementos que se mostrarán en el mensaje de confirmación según el contexto
		Case of 
			: ($l_sesiones=0)
				  // No hay sesiones. El usuario puede optar por Reemplazar las asignaciones previas o cancelar
				$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("50/_Encabezado"))
				$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("54/btn2_Reemplazar"))
				$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("57/btn3_Cancelar"))
			: ($l_inasistencias>0)
				  // Hay sesiones con inasistencias. El usuario puede Mantener las asignaciones previas y asignar antes o después (según sea posible), reemplazar las asignaciones previas o cancelar
				$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("50/_Encabezado"))
				If ($b_AsignarAntesPosible)
					$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("68/btn0_Mantener_y_AsignarAntes"))
				End if 
				If ($b_AsignarDespuesPosible)
					$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("55/btn1_Mantener_y_AsignarDespues"))
				End if 
				$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("52/btn2_ReemplazarEliminandoSesiones_e_Inasistencias"))
				$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("57/btn3_Cancelar"))
			: ($l_sesiones>0)
				  // Hay sesiones sin inasistencias. El usuario puede Mantener las asignaciones anteriores y asignar antes o después (según sea posible), reemplzar la asignación o cancelar
				$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("50/_Encabezado"))
				If ($b_AsignarAntesPosible)
					$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("68/btn0_Mantener_y_AsignarAntes"))
				End if 
				If ($b_AsignarDespuesPosible)
					$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("55/btn1_Mantener_y_AsignarDespues"))
				End if 
				$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("53/btn2_ReemplazarEliminandoSesiones"))
				$l_Error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("57/btn3_Cancelar"))
		End case 
		  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_inicioSesiones";String:C10($d_inicioSesiones;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_InicioSesionesAntes";String:C10($d_InicioSesionesAntes;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_inicioSesionesDespues";String:C10($d_inicioSesionesDespues;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_primeraSesion";String:C10($d_primeraSesion;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_terminoSesiones";String:C10($d_terminoSesiones;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_terminoSesionesAntes";String:C10($d_terminoSesionesAntes;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_terminoSesionesDespues";String:C10($d_terminoSesionesDespues;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_ultimaSesion";String:C10($d_ultimaSesion;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_AlumnosEnConflicto";String:C10($l_AlumnosEnConflicto))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_inasistencias";String:C10($l_inasistencias))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_sesiones";String:C10($l_sesiones))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_NombreAsignatura";$t_NombreAsignatura)
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_NombreDia";$t_NombreDia)
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_NombreHora";$t_NombreHora)
		  //Muestro el cuadro de diálogo de confirmación
		$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog;$t_textoDetalle)
		
		If ($l_opcionUsuario>0)
			  // pre-proceso la respuesta del usuario
			Case of 
				: ($b_extensionFechasAplicacion)
					Case of 
						: (($l_opcionUsuario=1) & ($l_Sesiones=0))
							$b_Asignar:=True:C214
						: (($b_AsignarAntesPosible) & ($b_AsignarDespuesPosible))
							Case of 
								: ($l_opcionUsuario=1)
									$b_AsignarAntes:=True:C214
								: ($l_opcionUsuario=2)
									$b_AsignarDespues:=True:C214
								: ($l_opcionUsuario=3)
									$b_eliminarSesiones:=True:C214
							End case 
						: (($b_AsignarAntesPosible) & (Not:C34($b_AsignarDespuesPosible)))
							Case of 
								: ($l_opcionUsuario=1)
									$b_AsignarAntes:=True:C214
								: ($l_opcionUsuario=2)
									$b_eliminarSesiones:=True:C214
							End case 
						: ((Not:C34($b_AsignarAntesPosible)) & ($b_AsignarDespuesPosible))
							Case of 
								: ($l_opcionUsuario=1)
									$b_AsignarDespues:=True:C214
								: ($l_opcionUsuario=2)
									$b_eliminarSesiones:=True:C214
							End case 
						: ((Not:C34($b_AsignarAntesPosible)) & (Not:C34($b_AsignarDespuesPosible)))
							Case of 
								: ($l_opcionUsuario=1)
									$b_eliminarSesiones:=True:C214
							End case 
					End case 
					
				: (Not:C34($b_extensionFechasAplicacion))
					Case of 
						: (($l_opcionUsuario=1) & ($l_Sesiones=0))
							$b_asignar:=True:C214
						: (($b_AsignarAntesPosible) & ($b_AsignarDespuesPosible))
							Case of 
								: ($l_opcionUsuario=1)
									$b_AsignarAntes:=True:C214
								: ($l_opcionUsuario=2)
									$b_AsignarDespues:=True:C214
								: ($l_opcionUsuario=3)
									$b_eliminarSesiones:=True:C214
							End case 
						: (($b_AsignarAntesPosible) & (Not:C34($b_AsignarDespuesPosible)))
							Case of 
								: ($l_opcionUsuario=1)
									$b_AsignarAntes:=True:C214
								: ($l_opcionUsuario=2)
									$b_eliminarSesiones:=True:C214
							End case 
						: ((Not:C34($b_AsignarAntesPosible)) & ($b_AsignarDespuesPosible))
							Case of 
								: ($l_opcionUsuario=1)
									$b_AsignarDespues:=True:C214
								: ($l_opcionUsuario=2)
									$b_eliminarSesiones:=True:C214
							End case 
						: ((Not:C34($b_AsignarAntesPosible)) & (Not:C34($b_AsignarDespuesPosible)))
							Case of 
								: ($l_opcionUsuario=1)
									$b_eliminarSesiones:=True:C214
							End case 
					End case 
			End case 
		Else 
			$l_asignacionValida:=0  // el usuario canceló la petición de confirmación
		End if 
		
	: ($b_ConflictoProfesor)
		  // HAY OTRA(S) ASIGNATURA(S) ASIGNADAS EN EL MISMO HORARIO EN FECHAS QUE SE SOBREPONEN CON EL MISMO PROFESOR Y CON LOS MISMOS ALUMNOS
		  // ESTO ES PERMITIDO PERO EL USUARIO DEBE OPTAR POR ALGUNA DE LAS OPCIONES DE ASIGNACION POSIBLES
		
		CREATE SELECTION FROM ARRAY:C640([TMT_Horario:166];$al_RecNumConflictosHorario)
		
		  // Creo el texto para mostrar el detalle de los conflictos
		KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5)
		SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$at_NombresAsignatura;[Asignaturas:18]Curso:5;$at_curso)
		For ($i;1;Size of array:C274($at_NombresAsignatura))
			$at_NombresAsignatura{$i}:=$at_NombresAsignatura{$i}+", "+$at_curso{$i}
		End for 
		SORT ARRAY:C229($at_NombresAsignatura)
		$t_titulo:=__ ("Asignaturas de ^0 ya asignadas a este bloque horario: ")
		$t_titulo:=Replace string:C233($t_titulo;"^0";$t_nombreProfesor)
		ST SET ATTRIBUTES:C1093($t_titulo;1;Length:C16($t_titulo);Attribute bold style:K65:1;1)
		$t_textoDetalle:=$t_titulo
		$t_textoDetalle:=$t_textoDetalle+"\r"+AT_array2text (->$at_NombresAsignatura;"\r")
		If (Size of array:C274($al_IdAlumnosEnComun)>0)
			QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$al_IdAlumnosEnComun)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_nombresAlumnos)
			SORT ARRAY:C229($at_nombresAlumnos)
			$t_titulo:=__ ("Alumnos en común con las asignaturas ya asignadas: ")
			ST SET ATTRIBUTES:C1093($t_titulo;1;Length:C16($t_titulo);Attribute bold style:K65:1;1)
			$t_textoDetalle:=$t_textoDetalle+"\r\r"+$t_titulo
			$t_textoDetalle:=$t_textoDetalle+"\r"+AT_array2text (->$at_nombresAlumnos;"\r")
		End if 
		
		  // determino si hay sesiones e inasistencias registradas
		KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[TMT_Horario:166]ID_Asignatura:5)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=$d_inicioSesiones;*)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=$d_terminoSesiones;*)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]NumeroDia:15=$l_numeroDia_ISO;*)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_numeroHora)
		If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
			SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_IdSesiones;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$ad_FechaSesiones)
			QUERY WITH ARRAY:C644([Asignaturas_Inasistencias:125]ID_Sesión:1;$al_IdSesiones)
			$l_inasistencias:=Records in selection:C76([Asignaturas_Inasistencias:125])
			$l_Sesiones:=Size of array:C274($ad_FechaSesiones)
			SORT ARRAY:C229($ad_FechaSesiones;>)
			$d_PrimeraSesion:=$ad_FechaSesiones{1}
			$d_ultimaSesion:=$ad_FechaSesiones{Size of array:C274($ad_FechaSesiones)}
			
			  // determino cual es la primera fecha disponible y válida después de la última sesión registrada en asignaciones anteriores
			$d_inicioSesionesDespues:=$d_ultimaSesion+1
			$d_terminoSesionesDespues:=vdSTR_Periodos_FinEjercicio
			If ($d_inicioSesionesDespues<$d_terminoSesionesDespues)
				$b_AsignarDespuesPosible:=TMT_FechaDiaValidos (->$d_inicioSesionesDespues;$d_terminoSesionesDespues;$l_numeroDia_ISO)
				$b_AsignarDespuesPosible:=TMT_FechaDiaValidos (->$d_terminoSesionesDespues;$d_inicioSesionesDespues;$l_numeroDia_ISO)
			End if 
			
			  // determino cual es la primera fecha disponible y válida antes de la primera sesión registrada en asignaciones anteriores
			$d_inicioSesionesAntes:=vdSTR_Periodos_InicioEjercicio
			$d_terminoSesionesAntes:=$d_PrimeraSesion-1
			If ($d_terminoSesionesAntes>$d_inicioSesionesAntes)
				$b_AsignarAntesPosible:=TMT_FechaDiaValidos (->$d_inicioSesionesAntes;vdSTR_Periodos_InicioEjercicio;$l_numeroDia_ISO)
				$b_AsignarAntesPosible:=TMT_FechaDiaValidos (->$d_terminoSesionesAntes;$d_inicioSesionesAntes;$l_numeroDia_ISO)
			End if 
		End if 
		
		  // Inicializo el componente IT_Confirmacion
		IT_Confirmacion_Inicializa 
		
		  //Cargo los elementos que se mostrarán en el mensaje de confirmación
		If ($l_Sesiones=0)
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("12/_Encabezado_SinSesiones"))
		Else 
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("78/_Encabezado_ConSesiones"))
		End if 
		IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("13/Btn1_AsignarEnSimultaneo"))
		If ($b_AsignarAntesPosible)
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("77/Btn3_Mantener_y_asignarAntes"))
		End if 
		If ($b_AsignarDespuesPosible)
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("14/Btn2_Mantener_y_asignarDespues"))
		End if 
		If ($l_Sesiones=0)
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("79/Btn4_RemplazarAsignacionesSinSesiones"))
		Else 
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("15/Btn4_ReemplazaAsignacionesConSesiones"))
		End if 
		IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("16/Btn5_Cancelar"))
		
		  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_InicioSesiones";String:C10($d_InicioSesiones;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_InicioSesionesAntes";String:C10($d_InicioSesionesAntes;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_inicioSesionesDespues";String:C10($d_inicioSesionesDespues;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_primeraSesion";String:C10($d_primeraSesion;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_terminoSesiones";String:C10($d_terminoSesiones;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_terminoSesionesAntes";String:C10($d_terminoSesionesAntes;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_terminoSesionesDespues";String:C10($d_terminoSesionesDespues;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_ultimaSesion";String:C10($d_ultimaSesion;System date abbreviated:K1:2))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_alumnosEnComun";String:C10($l_alumnosEnComun))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_alumnosDistintos";String:C10($l_alumnosDistintos))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_asignacionesProfesor";String:C10($l_asignacionesProfesor))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_inasistencias";String:C10($l_inasistencias))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_sesiones";String:C10($l_sesiones))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_nombreAsignatura";$t_nombreAsignatura)
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_nombreDia";$t_nombreDia)
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_NombreHora";$t_NombreHora)
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_nombreProfesor";$t_nombreProfesor)
		
		  // Muestro el cuadro de diálogo de confirmación
		  // pasa en $t_textoLog el encabezado para el registro de actividades
		$t_Textolog:=""
		$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog;$t_TextoDetalle)
		
		  // si el usuario no canceló preproceso de la respuesta del usuario en función del contexto
		If ($l_opcionUsuario>0)
			Case of 
				: ($b_extensionFechasAplicacion)
					Case of 
						: (($l_opcionUsuario=1) & ($l_Sesiones=0))
							$b_asignar:=True:C214
							
						: (($b_AsignarAntesPosible) & ($b_AsignarDespuesPosible))
							Case of 
								: ($l_opcionUsuario=1)
									$b_asignar:=True:C214
								: ($l_opcionUsuario=2)
									$b_asignarAntes:=True:C214
								: ($l_opcionUsuario=3)
									$b_asignarDespues:=True:C214
								: ($l_opcionUsuario=4)
									$b_eliminarSesiones:=True:C214
							End case 
							
						: (($b_AsignarAntesPosible) & (Not:C34($b_AsignarDespuesPosible)))
							Case of 
								: ($l_opcionUsuario=1)
									$b_asignar:=True:C214
								: ($l_opcionUsuario=2)
									$b_asignarAntes:=True:C214
								: ($l_opcionUsuario=3)
									$b_eliminarSesiones:=True:C214
							End case 
							
						: ((Not:C34($b_AsignarAntesPosible)) & ($b_AsignarDespuesPosible))
							Case of 
								: ($l_opcionUsuario=1)
									$b_asignar:=True:C214
								: ($l_opcionUsuario=2)
									$b_asignarDespues:=True:C214
								: ($l_opcionUsuario=3)
									$b_eliminarSesiones:=True:C214
							End case 
					End case 
					
				: (Not:C34($b_extensionFechasAplicacion))
					Case of 
						: (($l_opcionUsuario=1) & ($l_Sesiones=0))
							$b_asignar:=True:C214
							
						: (($b_AsignarAntesPosible) & ($b_AsignarDespuesPosible))
							Case of 
								: ($l_opcionUsuario=1)
									$b_asignar:=True:C214
								: ($l_opcionUsuario=2)
									$b_asignarAntes:=True:C214
								: ($l_opcionUsuario=3)
									$b_asignarDespues:=True:C214
								: ($l_opcionUsuario=4)
									$b_eliminarSesiones:=True:C214
							End case 
							
						: (($b_AsignarAntesPosible) & (Not:C34($b_AsignarDespuesPosible)))
							Case of 
								: ($l_opcionUsuario=1)
									$b_asignar:=True:C214
								: ($l_opcionUsuario=2)
									$b_asignarAntes:=True:C214
								: ($l_opcionUsuario=3)
									$b_eliminarSesiones:=True:C214
							End case 
							
						: ((Not:C34($b_AsignarAntesPosible)) & ($b_AsignarDespuesPosible))
							Case of 
								: ($l_opcionUsuario=1)
									$b_asignar:=True:C214
								: ($l_opcionUsuario=2)
									$b_asignarDespues:=True:C214
								: ($l_opcionUsuario=3)
									$b_eliminarSesiones:=True:C214
							End case 
					End case 
			End case 
		End if 
	Else 
		  //  no hay conflictos. Fuerzo $b_Asignar a
		  //$b_asignar:=True
		  //$l_opcionUsuario
End case 

If ($l_opcionUsuario>0)
	If (Not:C34(In transaction:C397))
		START TRANSACTION:C239
		$b_enTransaccion:=True:C214
	End if 
	
	Case of 
		: ($l_tipoValidacion=0)  // asignación de una asignatura
			Case of 
				: ($b_asignar)  // No hay sesiones en conflictos. El usuario confirma la asignación (aunque sea en simultáneo)
					$l_asignacionValida:=TMT_AsignaHorario ($l_recNumAsignatura;$d_inicioSesiones;$d_terminoSesiones;$l_numeroDia_ISO;$l_numeroHora;$l_numeroDeCiclo)
					If ($l_asignacionValida=0)
						$t_textoError:=__ ("No hay fechas válidas para asignar la asignatura a este bloque.")
					End if 
					
				: ($b_asignarAntes)  // Mantener asignaciones previas asignando con aplicacion hasta antes de la primera sesión en conflicto
					$l_asignacionValida:=TMT_CambiaFechasAplicacion (->$al_RecNumConflictosHorario;$d_PrimeraSesion;$d_ultimaSesion)
					If ($l_asignacionValida=1)
						$l_asignacionValida:=TMT_AsignaHorario ($l_recNumAsignatura;$d_inicioSesionesAntes;$d_terminoSesionesAntes;$l_numeroDia_ISO;$l_numeroHora;$l_numeroDeCiclo)
						If ($l_asignacionValida=0)
							$t_textoError:=__ ("No hay fechas válidas para asignar la asignatura a este bloque.")
						End if 
					Else 
						$t_textoError:=__ ("No fue posible modificar las fechas de aplicación de las asignaciones de horario actuales en este bloque.\rPor favor intente nuevamente más tarde.")
					End if 
					
				: ($b_asignarDespues)  // Mantener asignaciones previas asignando desde depués de la última sesión en conflicto
					$l_asignacionValida:=TMT_CambiaFechasAplicacion (->$al_RecNumConflictosHorario;$d_PrimeraSesion;$d_ultimaSesion)
					If ($l_asignacionValida=1)
						$l_asignacionValida:=TMT_AsignaHorario ($l_recNumAsignatura;$d_inicioSesionesDespues;$d_terminoSesionesDespues;$l_numeroDia_ISO;$l_numeroHora;$l_numeroDeCiclo)
						If ($l_asignacionValida=0)
							$t_textoError:=__ ("No hay fechas válidas para asignar la asignatura a este bloque.")
						End if 
					End if 
				: ($b_eliminarSesiones)  // Mantener asignaciones previas asignando hasta antes de la primera sesión en conflicto
					$l_asignacionValida:=TMT_EliminaSesionesAsociadas (->$al_RecNumConflictosHorario;$d_PrimeraSesion;$d_ultimaSesion)
					If ($l_asignacionValida=1)
						$l_asignacionValida:=TMT_EliminaAsignaciones (->$al_RecNumConflictosHorario)
						If ($l_asignacionValida=1)
							$l_asignacionValida:=TMT_AsignaHorario ($l_recNumAsignatura;$d_inicioSesiones;$d_terminoSesiones;$l_numeroDia_ISO;$l_numeroHora;$l_numeroDeCiclo)
							If ($l_asignacionValida=0)
								$t_textoError:=__ ("No hay fechas válidas para asignar la asignatura a este bloque.")
							End if 
						Else 
							$t_textoError:=__ ("No fue posible eliminar una o más sesiones.\rPor favor intente nuevamente más tarde.")
						End if 
					Else 
						$t_textoError:=__ ("No fue posible eliminar una o más sesiones.\rPor favor intente nuevamente más tarde.")
					End if 
			End case 
			
		: ($l_tipoValidacion=1)  // extension de fechas de aplicación
			Case of 
				: ($b_asignar)  // No hay sesiones en conflicto. El usuario confirma la asignación (aunque sea en simultáneo)
					TMT_ExtiendeAplicacion ($l_recNumAsignacionHorario;$d_inicioSesiones;$d_terminoSesiones)
					If (Size of array:C274($al_RecNumConflictosHorario)>0)
						$l_asignacionValida:=TMT_EliminaAsignaciones (->$al_RecNumConflictosHorario)
					Else 
						$l_asignacionValida:=1
					End if 
					
				: ($b_asignarAntes)  // Mantener asignaciones previas asignando con aplicacion hasta antes de la primera sesión en conflicto
					$l_asignacionValida:=TMT_CambiaFechasAplicacion (->$al_RecNumConflictosHorario;$d_PrimeraSesion;$d_ultimaSesion)
					If ($l_asignacionValida=1)
						TMT_ExtiendeAplicacion ($l_recNumAsignacionHorario;$d_inicioSesionesAntes;$d_terminoSesionesAntes)
					Else 
						$t_textoError:=__ ("No fue posible modificar las fechas de aplicación de las asignaciones de horario actuales en este bloque.\rPor favor intente nuevamente más tarde.")
					End if 
					
				: ($b_asignarDespues)  // Mantener asignaciones previas asignando desde depués de la última sesión en conflicto
					$l_asignacionValida:=TMT_CambiaFechasAplicacion (->$al_RecNumConflictosHorario;$d_PrimeraSesion;$d_ultimaSesion)
					If ($l_asignacionValida=1)
						TMT_ExtiendeAplicacion ($l_recNumAsignacionHorario;$d_inicioSesionesDespues;$d_terminoSesionesDespues)
					Else 
						$t_textoError:=__ ("No fue posible modificar las fechas de aplicación de las asignaciones de horario actuales en este bloque.\rPor favor intente nuevamente más tarde.")
					End if 
					
				: ($b_eliminarSesiones)  // Reemplazar las asignaciones previas eliminando las sesiones (e inasistencias a esas sesiones) existentes
					$l_asignacionValida:=TMT_EliminaSesionesAsociadas (->$al_RecNumConflictosHorario;$d_PrimeraSesion;$d_ultimaSesion)
					If ($l_asignacionValida=1)
						TMT_ExtiendeAplicacion ($l_recNumAsignacionHorario;$d_inicioSesiones;$d_terminoSesiones)
					Else 
						$t_textoError:=__ ("No fue posible eliminar una o más sesiones.\rPor favor intente nuevamente más tarde.")
					End if 
			End case 
			
		: ($l_tipoValidacion=2)  // desplazamiento de una asignación
			Case of 
				: ($b_asignar)  // No hay sesiones en conflicto. El usuario confirma la asignación (aunque sea en simultáneo)
					  //el cambio de la asignación se hará efectiva en TMT_DesplazaAsignación una vez que el usuario confirme el desplazamiento.
					$l_asignacionValida:=1
					
				: ($b_asignarAntes)  // Mantener asignaciones previas asignando con aplicacion hasta antes de la primera sesión en conflicto
					$l_asignacionValida:=TMT_CambiaFechasAplicacion (->$al_RecNumConflictosHorario;$d_PrimeraSesion;$d_ultimaSesion)
					If ($l_asignacionValida=0)
						$t_textoError:=__ ("No fue posible modificar las fechas de aplicación de las asignaciones de horario actuales en este bloque.\rPor favor intente nuevamente más tarde.")
					End if 
					
				: ($b_asignarDespues)  // Mantener asignaciones previas asignando desde depués de la última sesión en conflicto
					$l_asignacionValida:=TMT_CambiaFechasAplicacion (->$al_RecNumConflictosHorario;$d_PrimeraSesion;$d_ultimaSesion)
					If ($l_asignacionValida=0)
						$t_textoError:=__ ("No fue posible modificar las fechas de aplicación de las asignaciones de horario actuales en este bloque.\rPor favor intente nuevamente más tarde.")
					End if 
					
				: ($b_eliminarSesiones)  // Reemplazar las asignaciones previas eliminando las sesiones (e inasistencias a esas sesiones) existentes
					$l_asignacionValida:=TMT_EliminaSesionesAsociadas (->$al_RecNumConflictosHorario;$d_PrimeraSesion;$d_ultimaSesion)
					If ($l_asignacionValida=0)
						$t_textoError:=__ ("No fue posible eliminar una o más sesiones.\rPor favor intente nuevamente más tarde.")
					End if 
			End case 
	End case 
	
	If ($b_enTransaccion)
		If ($l_asignacionValida=1)
			VALIDATE TRANSACTION:C240
		Else 
			CANCEL TRANSACTION:C241
		End if 
	End if 
	
End if 

OK:=$l_asignacionValida
$0:=$t_TextoError