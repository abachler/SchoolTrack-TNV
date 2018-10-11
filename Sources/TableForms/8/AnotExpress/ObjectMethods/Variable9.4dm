  // [Alumnos_Conducta].AnotExpress.Variable9()
  // Por: Alberto Bachler K.: 08-05-14, 11:46:17
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_alumno:=OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.alumno")
$y_idAlumno:=OBJECT Get pointer:C1124(Object named:K67:5;"idAlumno")
$y_fecha:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha")
$y_motivo:=OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.motivo")
$y_categoria:=OBJECT Get pointer:C1124(Object named:K67:5;"categoria.anotacion")
$y_IdProfesor:=OBJECT Get pointer:C1124(Object named:K67:5;"idProfesor")
$y_Asignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.asignatura")
$y_profesor:=OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.profesor")
$y_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.observaciones")
$y_tipoAnotacion:=OBJECT Get pointer:C1124(Object named:K67:5;"tipo.anotacion")
$y_puntosAnotacion:=OBJECT Get pointer:C1124(Object named:K67:5;"puntos.anotacion")

$b_registroValido:=($y_idAlumno->>0)\
 & ($y_IdProfesor->>0)\
 & ($y_motivo->#"")\
 & ($y_categoria->#"")\
 & ($y_fecha->#!00-00-00!)


If ($b_registroValido)
	  //$l_filaSeleccionada:=AL_GetLine (xALP_Anot)
	
	  //AL_UpdateArrays (xALP_Anot;0)
	  //If ($l_filaSeleccionada<=0)
	$l_filaSeleccionada:=Size of array:C274(atSTRal_NombreAlumno)+1
	AT_Insert ($l_filaSeleccionada;1;->atSTRal_NombreAlumno;->adSTRal_FechaAnotacion;->atSTRal_NombreProfesorAnot;->atSTRal_MotivoAnotacion;->alSTRal_NoProfesorAnot;->atSTRal_NotasAnotacion;->atSTRal_CategoriaAnotacion;->alSTRal_PuntosAnotacion;->alSTRal_NumeroAlumno;->atSTRal_TipoAnotacion;->atSTRal_AsignaturaAnot)  //MONO Ticket 180570
	  //End if 
	
	atSTRal_NombreAlumno{$l_filaSeleccionada}:=$y_alumno->
	adSTRal_FechaAnotacion{$l_filaSeleccionada}:=$y_fecha->
	atSTRal_MotivoAnotacion{$l_filaSeleccionada}:=$y_motivo->
	atSTRal_AsignaturaAnot{$l_filaSeleccionada}:=$y_Asignatura->  //MONO Ticket 180570
	alSTRal_NumeroAlumno{$l_filaSeleccionada}:=$y_idAlumno->
	alSTRal_NoProfesorAnot{$l_filaSeleccionada}:=$y_IdProfesor->
	atSTRal_NombreProfesorAnot{$l_filaSeleccionada}:=$y_profesor->
	atSTRal_NotasAnotacion{$l_filaSeleccionada}:=$y_observaciones->
	atSTRal_CategoriaAnotacion{$l_filaSeleccionada}:=$y_categoria->
	atSTRal_TipoAnotacion{$l_filaSeleccionada}:=$y_tipoAnotacion->
	alSTRal_PuntosAnotacion{$l_filaSeleccionada}:=$y_puntosAnotacion->
	
	
	AL_UpdateArrays (xALP_Anot;Size of array:C274(atSTRal_NombreAlumno))
	
	$y_alumno->:=""
	$y_idAlumno->:=0
	
	GOTO OBJECT:C206(*;"anotacion.alumno")
	AL_SetLine (xALP_Anot;0)
	
	For ($i;1;Size of array:C274(atSTRal_NombreAlumno))
		Case of 
			: (atSTRal_TipoAnotacion{$i}="-")
				AL_SetRowColor (xALP_Anot;$i;"Red")
			: (atSTRal_TipoAnotacion{$i}="=")
				AL_SetRowColor (xALP_Anot;$i;"Blue")
			: (atSTRal_TipoAnotacion{$i}="+")
				AL_SetRowColor (xALP_Anot;$i;"Green")
		End case 
	End for 
End if 
