//%attributes = {}
  // ASrs_EliminaSesiones()
  // Por: Alberto Bachler: 03/06/13, 12:48:50
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)

_O_C_INTEGER:C282($i_sesiones)
C_LONGINT:C283($l_procesoProgreso;$l_sesionEliminada)
C_POINTER:C301($y_RecNumSesiones_al)
C_TEXT:C284($t_actividades;$t_contenidos;$t_observaciones)

C_POINTER:C301($1)

C_BOOLEAN:C305($b_continuar)
C_DATE:C307($d_fechaSesion)
_O_C_INTEGER:C282($i_alumnos;$i_sesiones)
C_LONGINT:C283($l_inasistenciasEliminadas;$l_procesoProgreso;$l_sesionEliminada)
C_POINTER:C301($y_RecNumSesiones_al)
C_TEXT:C284($t_actividades;$t_contenidos;$t_observaciones)

ARRAY LONGINT:C221($al_IdAlumnosAusentesSesion;0)

If (False:C215)
	C_POINTER:C301(ASrs_EliminaSesiones ;$1)
End if 
$y_RecNumSesiones_al:=$1

  //Para cada sesión de clases a eliminar
$l_procesoProgreso:=IT_Progress (1;0;0;"Eliminado sesiones de clases...")
For ($i_sesiones;1;Size of array:C274($y_RecNumSesiones_al->))
	GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$y_RecNumSesiones_al->{$i_sesiones})
	$d_fechaSesion:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
	$l_procesoProgreso:=IT_Progress (0;$l_procesoProgreso;$i_sesiones/Size of array:C274($y_RecNumSesiones_al->);"Eliminado sesiones de clases...\r"+String:C10([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;System date long:K1:3))
	
	  // busco y elimino las inasistencias asociadas a la sesión
	
	$b_eliminarSesion:=True:C214
	ARRAY LONGINT:C221($al_IdAlumnosAusentesSesion;0)
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1;=;[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
	If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
		SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Alumno:2;$al_IdAlumnosAusentesSesion)
		$l_inasistenciasEliminadas:=KRL_DeleteSelection (->[Asignaturas_Inasistencias:125])
		If ($l_inasistenciasEliminadas=0)
			$b_eliminarSesion:=False:C215
		End if 
	End if 
	
	If ($b_eliminarSesion)
		If ([Asignaturas_RegistroSesiones:168]hasData:8)
			  // si hay información registrada en la sesión (actividades, contenidos u observaciones
			  // debo traspasar la información a la primera sesión del mismo día...
			
			  // conservo la información de la sesión a eliminar
			$t_actividades:=[Asignaturas_RegistroSesiones:168]Actividades:7
			$t_contenidos:=[Asignaturas_RegistroSesiones:168]Contenidos:6
			$t_observaciones:=[Asignaturas_RegistroSesiones:168]Observacion:12
			  // busco sesiones en la misma fecha
			READ WRITE:C146([Asignaturas_RegistroSesiones:168])
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]hasData:8=False:C215)
			If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
				  //me posiciono en la sesión más temprana en la la misma fecha
				ORDER BY:C49([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Hora:4;>)
				  // traspaso la información registrada en la sesión a eliminar
				[Asignaturas_RegistroSesiones:168]Actividades:7:=$t_actividades
				[Asignaturas_RegistroSesiones:168]Contenidos:6:=$t_contenidos
				[Asignaturas_RegistroSesiones:168]Observacion:12:=$t_observaciones
				SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
				GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$y_RecNumSesiones_al->{$i_sesiones})
			End if 
			  // elimino la sesión
			$l_sesionEliminada:=KRL_DeleteRecord (->[Asignaturas_RegistroSesiones:168];$y_RecNumSesiones_al->{$i_sesiones})
		Else 
			  //elimino la sesión
			$l_sesionEliminada:=KRL_DeleteRecord (->[Asignaturas_RegistroSesiones:168];$y_RecNumSesiones_al->{$i_sesiones})
		End if 
	End if 
	
	If ($l_sesionEliminada=1)
		  // para cada alumno en la sesión eliminada debo determinar si existía un registro de inasistencia por día 
		  // que producto de la eliminación de la sesión deba ser eliminado.
		For ($i_alumnos;1;Size of array:C274($al_IdAlumnosAusentesSesion))
			$l_resultado:=AL_InasistenciaDiariaPorHoras ($al_IdAlumnosAusentesSesion{$i_alumnos};$d_fechaSesion)
			If ($l_resultado=0)
				$l_sesionEliminada:=0
				$i_alumnos:=Size of array:C274($al_IdAlumnosAusentesSesion)
				$i_sesiones:=Size of array:C274($y_RecNumSesiones_al->)
			End if 
		End for 
	Else 
		$i_sesiones:=Size of array:C274($y_RecNumSesiones_al->)
	End if 
End for 

$l_procesoProgreso:=IT_Progress (-1;$l_procesoProgreso)

$0:=$l_sesionEliminada