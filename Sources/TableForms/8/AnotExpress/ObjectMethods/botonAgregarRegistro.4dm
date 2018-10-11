  // [Alumnos_Conducta].AnotExpress.botonAgregarRegistro()
  // Por: Alberto Bachler K.: 08-05-14, 19:09:22
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$y_fecha:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha")
$y_Curso:=OBJECT Get pointer:C1124(Object named:K67:5;"curso")

If (($y_curso->#"") & ($y_fecha->#!00-00-00!))
	
	$y_listaAlumno:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.alumno")
	$y_listaFuncionario:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.funcionario")
	$y_listaMotivo:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.motivo")
	$y_listaObservacion:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.observacion")
	$y_listaFecha:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.fecha")
	$y_listaIdAlumno:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.idAlumno")
	$y_listaIdProfesor:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.idProfesor")
	$y_listaTipoAnotacion:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.tipoAnotacion")
	$y_listaCategoriaAnotacion:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.categoriaAnotacion")
	$y_listaPuntajeAnotacion:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.puntajeAnotacion")
	
	$l_ultimaFila:=Size of array:C274($y_listaAlumno->)
	If ($l_ultimaFila>0)
		
		  // verifico que la información para registrar la anotación esté completa
		$b_registroValido:=($y_listaIdAlumno->{$l_ultimaFila}#0)\
			 & ($y_listaIdProfesor->{$l_ultimaFila}#0)\
			 & ($y_listaFecha->{$l_ultimaFila}#!00-00-00!)\
			 & ($y_listaMotivo->{$l_ultimaFila}#"")\
			
		If ($b_registroValido)
			APPEND TO ARRAY:C911($y_listaAlumno->;"")
			APPEND TO ARRAY:C911($y_listaFuncionario->;$y_listaFuncionario->{$l_ultimaFila})
			APPEND TO ARRAY:C911($y_listaMotivo->;$y_listaMotivo->{$l_ultimaFila})
			APPEND TO ARRAY:C911($y_listaObservacion->;$y_listaObservacion->{$l_ultimaFila})
			APPEND TO ARRAY:C911($y_listaFecha->;$y_listaFecha->{$l_ultimaFila})
			APPEND TO ARRAY:C911($y_listaIdAlumno->;0)
			APPEND TO ARRAY:C911($y_listaIdProfesor->;$y_listaIdProfesor->{$l_ultimaFila})
			APPEND TO ARRAY:C911($y_listaTipoAnotacion->;$y_listaTipoAnotacion->{$l_ultimaFila})
			APPEND TO ARRAY:C911($y_listaCategoriaAnotacion->;$y_listaCategoriaAnotacion->{$l_ultimaFila})
			APPEND TO ARRAY:C911($y_listaPuntajeAnotacion->;$y_listaPuntajeAnotacion->{$l_ultimaFila})
			
			EDIT ITEM:C870($y_listaAlumno->;$l_ultimaFila+1)
			
		Else 
			ModernUI_Notificacion (__ ("Registro de anotación incompleto");__ ("Debe registrar el nombre del alumno, del profesor o funcionario, el motivo de la anotación y la fecha."))
		End if 
		
		
	Else 
		AT_Insert (1;1;$y_listaAlumno;$y_listaFuncionario;$y_listaMotivo;$y_listaObservacion;$y_listaFecha;\
			$y_listaIdAlumno;$y_listaIdProfesor;$y_listaTipoAnotacion;$y_listaCategoriaAnotacion;$y_listaPuntajeAnotacion)
		$y_listaFecha->{1}:=$y_fecha->
		EDIT ITEM:C870($y_listaAlumno->;1)
	End if 
	
Else 
	ModernUI_Notificacion (__ ("Registro de anotaciones");__ ("Por favor seleccione un curso e indique la fecha antes de crear un registro de anotaciones.");"OK")
End if 
