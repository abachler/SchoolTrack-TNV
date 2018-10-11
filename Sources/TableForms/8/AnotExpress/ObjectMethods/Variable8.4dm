  // [Alumnos_Conducta].AnotExpress.Variable8()
  // Por: Alberto Bachler K.: 08-05-14, 11:42:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_filaSeleccionada)


Case of 
	: (alproEvt=1)
		GOTO OBJECT:C206(*;"anotacion.alumno")
		  //$l_filaSeleccionada:=AL_GetLine (Self->)
		  //(OBJECT Get pointer(Object named;"idAlumno"))->:=alSTRal_NumeroAlumno{$l_filaSeleccionada}
		  //(OBJECT Get pointer(Object named;"idProfesor"))->:=alSTRal_NoProfesorAnot{$l_filaSeleccionada}
		  //(OBJECT Get pointer(Object named;"anotacion.alumno"))->:=atSTRal_NombreAlumno{$l_filaSeleccionada}
		  //(OBJECT Get pointer(Object named;"anotacion.motivo"))->:=atSTRal_MotivoAnotacion{$l_filaSeleccionada}
		  //(OBJECT Get pointer(Object named;"anotacion.profesor"))->:=atSTRal_NombreProfesorAnot{$l_filaSeleccionada}
		  //(OBJECT Get pointer(Object named;"anotacion.observaciones"))->:=atSTRal_NotasAnotacion{$l_filaSeleccionada}
		  //(OBJECT Get pointer(Object named;"puntos.anotacion"))->:=alSTRal_PuntosAnotacion
		  //(OBJECT Get pointer(Object named;"categoria.anotacion"))->:=atSTRal_CategoriaAnotacion{$l_filaSeleccionada}
		  //(OBJECT Get pointer(Object named;"tipo.anotacion"))->:=atSTRal_TipoAnotacion{$l_filaSeleccionada}
		
	: (Form event:C388=On Getting Focus:K2:7)
		GOTO OBJECT:C206(*;"anotacion.alumno")
		
End case 

