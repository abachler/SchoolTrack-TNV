AL_ExitCell (xALP_CsdList2)

vi_metodo:=1
vt_textMsg:=__ ("Usted modificó las propiedades de evaluación. Los resultados de los alumnos en esta asignatura seran calculados en otro proceso una vez que usted la libere.")
vbRecalcPromedios:=True:C214
  // Ticket 175179
  //APPEND TO ARRAY(atSTR_EventLog;"Atributo \"Promediar Resultados calculados sin aproximación \" activado")