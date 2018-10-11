  //$y_OcultarEnNominas:=OBJECT Get pointer(Object named;"$cb_ocultarEnNominas")
  //If (<>vtXS_CountryCode="cl")
  //OBJECT SET ENABLED(*;"$cb_ocultarEnNominas";False)
  //If ([Alumnos]Fecha_de_retiro>=DT_GetDateFromDayMonthYear (1;5;<>gYear))
  //$y_OcultarEnNominas->:=0
  //Else 
  //$y_OcultarEnNominas->:=1
  //End if 
  //End if 