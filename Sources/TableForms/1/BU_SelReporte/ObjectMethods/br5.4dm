If (Self:C308->>0)
	vl_TipoInformeTT:=5
	  //Botones radiales de seleccion de registros de rutas
	lr1:=0
	lr2:=0
	IT_SetButtonState (False:C215;->lr1;->lr2)
	
	  //Seleccion de Curso para Informe de alumnos por curso
	IT_SetButtonState (False:C215;-><>aCursos)
	
	  //Seleccion de fechas para el informe Asistencia Ruta
	  //IT_SetEnterable (True;0;->vt_Fecha1;->vt_Fecha2)
	IT_SetButtonState (True:C214;->atRuta)
End if 