//%attributes = {}
  // PF_RegistraFallecimiento()
  // Por: Alberto Bachler K.: 26-03-14, 21:38:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_transaccionOK)
_O_C_INTEGER:C282($i_alumnos;$i_asignaturas)
C_LONGINT:C283($l_opcionUsuario)
C_TEXT:C284($t_contenidoTexto;$t_descripcion;$t_Encabezado;$t_uuid)

ARRAY LONGINT:C221($al_cero;0)
ARRAY TEXT:C222($at_alumnos;0)
ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_cursoAlumnos;0)
ARRAY TEXT:C222($at_cursoAsignatura;0)
ARRAY TEXT:C222($at_tareas;0)
ARRAY TEXT:C222($at_Titulos;0)
ARRAY TEXT:C222($at_vacio;0)



If ([Profesores:4]Estado_civil:18=__ ("Fallecido(a)"))
	If (USR_checkRights ("D";->[Profesores:4]))
		CREATE EMPTY SET:C140([Asignaturas:18];"$profesoresFirmantes")
		CREATE EMPTY SET:C140([Asignaturas:18];"$profesoresTitulares")
		
		START TRANSACTION:C239
		
		SET QUERY AND LOCK:C661(True:C214)
		READ WRITE:C146([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=[Profesores:4]Numero:1)
		$b_transaccionOK:=(OK=1)
		If (Records in selection:C76([Cursos:3])#0)
			APPEND TO ARRAY:C911($at_tareas;__ ("Asignar profesor jefe en ")+[Cursos:3]Curso:1)
		End if 
		
		
		If ($b_transaccionOK)
			READ WRITE:C146([Asignaturas:18])
			QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
			$b_transaccionOK:=(OK=1)
			CREATE SET:C116([Asignaturas:18];"$profesoresTitulares")
			ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]denominacion_interna:16;>)
			SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$at_asignaturas;[Asignaturas:18]Curso:5;$at_cursoAsignatura)
			For ($i_asignaturas;1;Size of array:C274($at_asignaturas))
				APPEND TO ARRAY:C911($at_tareas;__ ("Asignar profesor de asignatura en ")+$at_asignaturas{$i_asignaturas}+", "+$at_cursoAsignatura{$i_asignaturas})
			End for 
		End if 
		
		If ($b_transaccionOK)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33=[Profesores:4]Numero:1)
			$b_transaccionOK:=(OK=1)
			CREATE SET:C116([Asignaturas:18];"$profesoresFirmantes")
			ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]denominacion_interna:16;>)
			SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$at_asignaturas;[Asignaturas:18]Curso:5;$at_cursoAsignatura)
			For ($i_asignaturas;1;Size of array:C274($at_asignaturas))
				APPEND TO ARRAY:C911($at_tareas;__ ("Asignar profesor firmante en ")+$at_asignaturas{$i_asignaturas}+", "+$at_cursoAsignatura{$i_asignaturas})
			End for 
		End if 
		
		If ($b_transaccionOK)
			READ WRITE:C146([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=[Profesores:4]Numero:1)
			$b_transaccionOK:=(OK=1)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_alumnos;[Alumnos:2]curso:20;$at_cursoAlumnos)
			For ($i_alumnos;1;Size of array:C274($at_alumnos))
				APPEND TO ARRAY:C911($at_tareas;__ ("Asignar tutor a ")+$at_alumnos{$i_alumnos}+", "+$at_cursoAlumnos{$i_alumnos})
			End for 
		End if 
		
		
		If ($b_transaccionOK)
			$l_opcionUsuario:=ModernUI_Notificacion (__ ("Registro de fallecimiento");__ ("¿Está seguro que desea registrar el fallecimiento de ")+[Profesores:4]Nombre_comun:21+"?";__ ("Cancelar");__ ("Aceptar"))
			If ($l_opcionUsuario=2)
				  // retiro al profesor fallecido como profesor jefe
				[Cursos:3]Numero_del_profesor_jefe:2:=0
				SAVE RECORD:C53([Cursos:3])
				KRL_UnloadReadOnly (->[Cursos:3])
				
				  // retiro al profesor fallecido como profesor titular de asignaturas
				USE SET:C118("$profesoresTitulares")
				AT_Initialize (->$at_vacio;->$al_cero)
				AT_RedimArrays (Records in set:C195("$profesoresTitulares");->$at_vacio;->$al_cero)
				ARRAY TO SELECTION:C261($at_vacio;[Asignaturas:18]profesor_nombre:13;$al_cero;[Asignaturas:18]profesor_numero:4)
				
				  // retiro al profesor fallecido como profesor firmante de asignaturas
				USE SET:C118("$profesoresFirmantes")
				AT_Initialize (->$at_vacio;->$al_cero)
				AT_RedimArrays (Records in set:C195("$profesoresFirmantes");->$at_vacio;->$al_cero)
				ARRAY TO SELECTION:C261($at_vacio;[Asignaturas:18]profesor_firmante_Nombre:34;$al_cero;[Asignaturas:18]profesor_firmante_numero:33)
				
				  // retiro al profesor fallecido de las tutorias que tenía asignadas
				AT_Initialize (->$at_vacio;->$al_cero)
				AT_RedimArrays (Records in selection:C76([Alumnos:2]);->$at_vacio;->$al_cero)
				ARRAY TO SELECTION:C261($at_vacio;[Alumnos:2]Tutor_Nombre:38;$al_cero;[Alumnos:2]Tutor_numero:36)
			End if 
			
			KRL_UnloadReadOnly (->[Cursos:3];->[Asignaturas:18];->[Alumnos:2])
			
			[Profesores:4]Inactivo:62:=True:C214
			[Profesores:4]Fallecido:70:=True:C214
			LOG_RegisterEvt (__ ("Registro del fallecimiento del profesor ")+[Profesores:4]Apellidos_y_nombres:28)
			VALIDATE TRANSACTION:C240
			
			If (Size of array:C274($at_tareas)>0)
				ARRAY TEXT:C222($at_Titulos;0)
				APPEND TO ARRAY:C911($at_Titulos;"Tarea Pendiente")
				
				$t_Encabezado:="Se registró el fallecimiento del profesor "+[Profesores:4]Apellidos_y_nombres:28
				$t_descripcion:=[Profesores:4]Apellidos_y_nombres:28+__ (" tenía asignada alguna jefatura de curso, era profesor de asignatura o tutor de uno o mas alumnos.")+"\r"
				$t_descripcion:=$t_descripcion+__ ("Es necesario asignar otro profesor jefe, profesor de asignatura o tutorías.")+"\r"
				$t_descripcion:=$t_descripcion+__ ("En la lista mas abajo se muestran las tareas que deben ser realizadas en SchoolTrack como consecuencia del fallecimiento del profesor.")
				$t_contenidoTexto:=""
				
				$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
				NTC_Mensaje_Arreglos ($t_uuid;->$at_Titulos;->$at_tareas)
			End if 
			
		Else 
			[Profesores:4]Fallecido:70:=Old:C35([Profesores:4]Fallecido:70)
			[Profesores:4]Estado_civil:18:=Old:C35([Profesores:4]Estado_civil:18)
			ModernUI_Notificacion (__ ("No es posible registrar el fallecimiento en este momento ya que algunos registros de asignaturas, cursos o alumnos relacionados con este profesor están siendo editados por otro usuario.\rPor favor intente nuevamente en otro momento."))
			CANCEL TRANSACTION:C241
		End if 
		SET QUERY AND LOCK:C661(False:C215)
		KRL_UnloadReadOnly (->[Cursos:3];->[Alumnos:2];->[Asignaturas:18])
	Else 
		[Profesores:4]Fallecido:70:=Old:C35([Profesores:4]Fallecido:70)
		[Profesores:4]Estado_civil:18:=Old:C35([Profesores:4]Estado_civil:18)
		USR_ALERT_UserHasNoRights (3)
	End if 
Else 
	[Profesores:4]Fallecido:70:=Old:C35([Profesores:4]Fallecido:70)
	[Profesores:4]Estado_civil:18:=Old:C35([Profesores:4]Estado_civil:18)
End if 


