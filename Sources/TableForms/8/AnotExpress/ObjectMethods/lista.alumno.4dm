  // [Alumnos_Conducta].AnotExpress.lista.alumno()
  // Por: Alberto Bachler K.: 08-05-14, 18:34:34
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$y_fecha:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha")
$y_listaAlumno:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_listaIdAlumno:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.IdAlumno")
$l_fila:=$y_listaAlumno->


Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		
	: (Form event:C388=On Data Change:K2:15)
		$t_alumno:=$y_listaAlumno->{$l_fila}+"@"
		
		$l_numeroDeLista:=Num:C11($t_alumno)
		If ($l_numeroDeLista>0)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]no_de_lista:53=$l_numeroDeLista)
		Else 
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Apellido_paterno:3;=;$t_alumno)
		End if 
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
		QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="En trámite";*)
		QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="Oyente")
		
		Case of 
			: (Records in selection:C76([Alumnos:2])=0)
				$y_listaAlumno->{$l_fila}:=""
				$y_listaIdAlumno->{$l_fila}:=0
				
			: (Records in selection:C76([Alumnos:2])=1)
				$y_listaAlumno->{$l_fila}:=[Alumnos:2]apellidos_y_nombres:40
				$y_listaIdAlumno->{$l_fila}:=[Alumnos:2]numero:1
				
			: (Records in selection:C76([Alumnos:2])>1)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_nombresAlumnos;[Alumnos:2]numero:1;$al_idAlumnos)
				$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_nombresAlumnos;->$t_alumno)
				If ($l_itemSeleccionado>0)
					$y_listaAlumno->{$l_fila}:=$at_nombresAlumnos{$l_itemSeleccionado}
					$y_listaIdAlumno->{$l_fila}:=$al_idAlumnos{$l_itemSeleccionado}
				Else 
					$y_listaAlumno->{$l_fila}:=""
					$y_listaIdAlumno->{$l_fila}:=0
				End if 
		End case 
		
		If ($y_listaAlumno->{$l_fila}#"")
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_inasistencias)
			QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4;=;$y_listaIdAlumno->{$l_fila})
			QUERY SELECTION:C341([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1;=;$y_fecha->)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			Case of 
				: ($l_inasistencias>0)
					$t_mensaje:=__ ("^0 está registrado como inasistente el ^1\r.No es posible registrar una anotación en esta fecha.")
					$t_mensaje:=Replace string:C233($t_mensaje;"^0";[Alumnos:2]apellidos_y_nombres:40)
					$t_mensaje:=Replace string:C233($t_mensaje;"^1";String:C10($y_fecha->;Internal date short special:K1:4))
					CD_Dlog (0;$t_mensaje)
					$y_listaIdAlumno->{$l_fila}:=0
					$y_listaAlumno->{$l_fila}:=""
					
				: ([Alumnos:2]Fecha_de_Ingreso:41>$y_fecha->)
					$t_mensaje:=__ ("^0 es alumno regular desde el ^1\r.No es posible registrar una anotación antes de esa fecha.")
					$t_mensaje:=Replace string:C233($t_mensaje;"^0";[Alumnos:2]apellidos_y_nombres:40)
					$t_mensaje:=Replace string:C233($t_mensaje;"^1";String:C10([Alumnos:2]Fecha_de_Ingreso:41;Internal date short special:K1:4))
					CD_Dlog (0;$t_mensaje)
					$y_listaIdAlumno->{$l_fila}:=0
					$y_listaAlumno->{$l_fila}:=""
			End case 
		End if 
		
		If ($y_listaAlumno->{$l_fila}="")
			EDIT ITEM:C870(*;"lista.alumno";$l_fila)
		End if 
		
End case 



