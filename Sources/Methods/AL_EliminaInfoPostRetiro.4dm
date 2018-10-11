//%attributes = {}
  // AL_EliminaInfoPostRetiro()
  // Por: Alberto Bachler K.: 16-06-14, 15:37:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_continuar)
C_LONGINT:C283($l_accion;$l_registros)
C_TEXT:C284($t_mensaje)


PUSH RECORD:C176([Alumnos:2])

QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1>=[Alumnos:2]Fecha_de_retiro:42)
CREATE SET:C116([Alumnos_Inasistencias:10];"inasistencias")

QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4>=[Alumnos:2]Fecha_de_retiro:42)
CREATE SET:C116([Asignaturas_Inasistencias:125];"inasistenciasHoras")

QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2>=[Alumnos:2]Fecha_de_retiro:42)
CREATE SET:C116([Alumnos_Atrasos:55];"atrasos")

QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Fecha:1>=[Alumnos:2]Fecha_de_retiro:42)
CREATE SET:C116([Alumnos_Anotaciones:11];"anotaciones")

QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Alumno_Numero:8=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Fecha:9>=[Alumnos:2]Fecha_de_retiro:42)
CREATE SET:C116([Alumnos_Castigos:9];"castigos")

QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Alumno_Numero:7=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Suspensiones:12]; & ;[Alumnos_Suspensiones:12]Desde:5>=[Alumnos:2]Fecha_de_retiro:42)
CREATE SET:C116([Alumnos_Suspensiones:12];"suspensiones")

$l_registros:=$l_registros+Records in set:C195("inasistencias")
$l_registros:=$l_registros+Records in set:C195("inasistenciasHoras")
$l_registros:=$l_registros+Records in set:C195("anotaciones")
$l_registros:=$l_registros+Records in set:C195("atrasos")
$l_registros:=$l_registros+Records in set:C195("castigos")
$l_registros:=$l_registros+Records in set:C195("suspensiones")

If ($l_registros>0)
	$t_mensaje:=__ ("El alumno que desea retirar o promover anticipadamente tiene información conductual, inasistencias o atrasos registrados en fechas posteriores ^0.\r")
	$t_mensaje:=$t_mensaje+__ ("Las informaciones registradas con posterioridad a esa fecha serán eliminadas.\r\r")
	$t_mensaje:=$t_mensaje+__ ("¿Desea continuar con esta operación?")
	$t_mensaje:=Replace string:C233($t_mensaje;"^0";String:C10([Alumnos:2]Fecha_de_retiro:42;System date short:K1:1))
	$l_accion:=ModernUI_Notificacion (__ ("Cambio de estado de alumno");$t_mensaje;"Continuar";"Cancelar")
	If ($l_accion=1)
		START TRANSACTION:C239
		USE SET:C118("inasistencias")
		OK:=KRL_DeleteSelection (->[Alumnos_Inasistencias:10])
		If (OK=1)
			USE SET:C118("atrasos")
			OK:=KRL_DeleteSelection (->[Alumnos_Atrasos:55])
		End if 
		If (OK=1)
			USE SET:C118("inasistenciasHoras")
			OK:=KRL_DeleteSelection (->[Asignaturas_Inasistencias:125])
		End if 
		If (OK=1)
			USE SET:C118("castigos")
			OK:=KRL_DeleteSelection (->[Alumnos_Castigos:9])
		End if 
		If (OK=1)
			USE SET:C118("anotaciones")
			OK:=KRL_DeleteSelection (->[Alumnos_Anotaciones:11])
		End if 
		If (OK=1)
			USE SET:C118("suspensiones")
			OK:=KRL_DeleteSelection (->[Alumnos_Suspensiones:12])
		End if 
		
		If (OK=1)
			VALIDATE TRANSACTION:C240
			$b_continuar:=True:C214
			LOG_RegisterEvt ("Eliminación de "+String:C10($l_registros)+" para el alumno "+[Alumnos:2]apellidos_y_nombres:40+", en información conductual (inasistencias, atrasos, anotaciones, etc..) por retiro desde "+String:C10([Alumnos:2]Fecha_de_retiro:42))
		Else 
			$t_mensaje:=__ ("No fue posible eliminar la información posterior a la fecha de retiro o promoción anticipada.\r")
			$t_mensaje:=$t_mensaje+__ ("No es posible continuar con esta operación en este momento.\rPor favor inténtelo nuevamente más tarde")
			$l_accion:=ModernUI_Notificacion (__ ("Retiro de alumno");$t_mensaje;"Aceptar")
			$b_continuar:=False:C215
			CANCEL TRANSACTION:C241
		End if 
	End if 
	
Else 
	$b_continuar:=True:C214
End if 

POP RECORD:C177([Alumnos:2])

$0:=$b_continuar

SET_ClearSets ("inasistencias";"inasistenciasHoras";"anotaciones";"atrasos";"castigos";"suspensiones")