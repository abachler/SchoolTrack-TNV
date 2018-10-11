vl_TipoInformeTT:=3
  //Botones radiales de seleccion de registros de rutas
IT_SetButtonState (True:C214;->lr1;->lr2)
lr1:=1
lr2:=0

  //Seleccion de Curso para Informe de alumnos por curso
IT_SetButtonState (False:C215;-><>aCursos)

  //Seleccion de fechas para el informe Asistencia Ruta
IT_SetEnterable (False:C215;0;->sWeek;->dDate1;->dDate2;->vtNombreRuta;->vtSentido)
IT_SetButtonState (False:C215;->sWeek;-><>aWeeks;->atRuta;->atSentido)
