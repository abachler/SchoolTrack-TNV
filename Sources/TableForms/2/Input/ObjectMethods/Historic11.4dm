  //AS 18/01/2012 Se realiza validación para el cambio de situacion final del alumnos.
  //If ([Alumnos]Nivel_Número>[Alumnos_SintesisAnual]NumeroNivel)
  //CD_Dlog (0;__ ("No puede modificar este atributo ya que el alumnno se encuentra en un nivel superior. Utilice la herramienta  de reorganización de cursos."))
  //[Alumnos_SintesisAnual]SituacionFinal:=Old([Alumnos_SintesisAnual]SituacionFinal)
  //Else 
  //If ([Alumnos]Nivel_Número=[Alumnos_SintesisAnual]NumeroNivel)
  //If ([Alumnos_SintesisAnual]SituacionFinal="R")
  //[Alumnos_SintesisAnual]Promovido:=False
  //Else 
  //[Alumnos_SintesisAnual]Promovido:=True
  //End if 
  //SAVE RECORD([Alumnos_SintesisAnual])
  //End if 
  //End if 

  //20131104 ASM Para validar.
AL_EditHistorico_OM ("SetPromocion")
