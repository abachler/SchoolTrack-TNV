  // [Alumnos_Conducta].AnotExpress.anotacion.alumno()
  // Por: Alberto Bachler K.: 08-05-14, 11:03:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_alumno:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_idAlumno:=OBJECT Get pointer:C1124(Object named:K67:5;"idAlumno")
$y_fecha:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha")
$y_curso:=OBJECT Get pointer:C1124(Object named:K67:5;"curso")

If (($y_curso->="") | ($y_fecha->=!00-00-00!))
	CD_Dlog (0;__ ("Por favor seleccione el curso e ingrese la fecha antes de registrar la anotación."))
	$y_idAlumno->:=0
	$y_alumno->:=""
Else 
	  //USE SET("$alumnosDelCurso")
	If (Records in set:C195("$alumnosDelCurso")#0)
		USE SET:C118("$alumnosDelCurso")
	Else 
		$y_curso:=OBJECT Get pointer:C1124(Object named:K67:5;"curso")
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20;=;$y_curso->)
		CREATE SET:C116([Alumnos:2];"$alumnosDelCurso")
	End if 
	
	$l_numeroDeLista:=Num:C11($y_alumno->)
	If ($l_numeroDeLista>0)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]no_de_lista:53=$l_numeroDeLista)
	Else 
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Apellido_paterno:3;=;$y_alumno->+"@")
	End if 
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
	QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="En trámite";*)
	QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="Oyente")
	
	Case of 
		: (Records in selection:C76([Alumnos:2])=0)
			$y_idAlumno->:=0
			$y_alumno->:=""
			
		: (Records in selection:C76([Alumnos:2])=1)
			$y_alumno->:=[Alumnos:2]apellidos_y_nombres:40
			$y_idAlumno->:=[Alumnos:2]numero:1
			
		: (Records in selection:C76([Alumnos:2])>1)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_nombresAlumnos;[Alumnos:2]numero:1;$al_idAlumnos)
			$t_textoEditado:=$y_alumno->+"@"
			$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_nombresAlumnos;->$t_textoEditado;OBJECT Get name:C1087(Object current:K67:2))
			If ($l_itemSeleccionado>0)
				$y_alumno->:=$at_nombresAlumnos{$l_itemSeleccionado}
				$y_idAlumno->:=$al_idAlumnos{$l_itemSeleccionado}
			Else 
				$y_idAlumno->:=0
				$y_alumno->:=""
			End if 
	End case 
	
	
	If ($y_alumno->#"")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_inasistencias)
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4;=;$y_idAlumno->)
		QUERY SELECTION:C341([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1;=;$y_fecha->)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		Case of 
			: ($l_inasistencias>0)
				$t_mensaje:=__ ("^0 está registrado como inasistente el ^1.\rNo es posible registrar una anotación en esta fecha.")
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";[Alumnos:2]apellidos_y_nombres:40)
				$t_mensaje:=Replace string:C233($t_mensaje;"^1";String:C10($y_fecha->;Internal date short special:K1:4))
				CD_Dlog (0;$t_mensaje)
				$y_idAlumno->:=0
				$y_alumno->:=""
				
			: ([Alumnos:2]Fecha_de_Ingreso:41>$y_fecha->)
				$t_mensaje:=__ ("^0 es alumno regular desde el ^1.\rNo es posible registrar una anotación antes de esa fecha.")
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";[Alumnos:2]apellidos_y_nombres:40)
				$t_mensaje:=Replace string:C233($t_mensaje;"^1";String:C10([Alumnos:2]Fecha_de_Ingreso:41;Internal date short special:K1:4))
				CD_Dlog (0;$t_mensaje)
				$y_idAlumno->:=0
				$y_alumno->:=""
		End case 
	End if 
End if 

If ($y_alumno->="")
	GOTO OBJECT:C206(*;"anotacion.alumno")
End if 




