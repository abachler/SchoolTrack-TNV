  //
  //  //trace 
  //Case of 
  //: (lastCdcta=5)
  //$textPtr:=->atSTRal_NombreProfesorAnot
  //$idProfPtr:=->alSTRal_NoProfesorAnot
  //: (lastCdcta=7)
  //$textPtr:=-><>aCdtaText3
  //$idProfPtr:=-><>aCdtaLong1
  //: (lastCdcta=8)
  //$textPtr:=-><>aCdtaText3
  //$idProfPtr:=-><>aCdtaLong1
  //End case 
  //
  //If ($TextPtr->{vrow}#"")
  //READ ONLY([Profesores])
  //QUERY([Profesores];[Profesores]Apellido_paterno=($textPtr->{vrow}+"@");*)
  //QUERY([Profesores]; & ;[Profesores]Inactivo=False)
  //Case of 
  //: (Records in selection([Profesores])=0)
  //CD_Dlog (0;__ ("Profesor inexistente."))
  //$textPtr->{vrow}:=""
  //$IdProfPtr->{vrow}:=0
  //AL_GotoCell (xALP_ConductaAlumnos;vCol;vrow)
  //: (Records in selection([Profesores])=1)
  //$textPtr->{vrow}:=[Profesores]Nombre_comun
  //$IdProfPtr->{vrow}:=[Profesores]Numero
  //AL_UpdateArrays (xALP_ConductaAlumnos;-1)
  //: (Records in selection([Profesores])>1)
  //SELECTION TO ARRAY([Profesores]Nombre_comun;<>aGenNme;[Profesores]Numero;<>aGenId)
  //ARRAY POINTER(<>aChoicePtrs;2)
  //<>aChoicePtrs{1}:=-><>aGenNme
  //<>aChoicePtrs{2}:=-><>aGenID
  //TBL_ShowChoiceList (1)
  //If ((ok=1) & (choiceIdx>0))
  //$textPtr->{vrow}:=<>aChoicePtrs{1}->{choiceIdx}
  //$idProfPtr->{vrow}:=<>aChoicePtrs{2}->{choiceIdx}
  //AL_UpdateArrays (xALP_ConductaAlumnos;-1)
  //AL_GotoCell (xALP_ConductaAlumnos;vCol+1;vrow)
  //AL_SetCellHigh (xALP_ConductaAlumnos;1;80)
  //Else 
  //$textPtr->{vrow}:=""
  //$idProfPtr->{vrow}:=0
  //AL_UpdateArrays (xALP_ConductaAlumnos;-1)
  //AL_GotoCell (xALP_ConductaAlumnos;vCol;vrow)
  //AL_SetCellHigh (xALP_ConductaAlumnos;1;1)
  //End if 
  //End case 
  //Case of 
  //: (lastCdcta=5)
  //If ((adSTRal_FechaAnotacion{vRow}#!00/00/0000!) & (atSTRal_MotivoAnotacion{vRow}#"") & (alSTRal_NoProfesorAnot{vRow}#0))
  //READ WRITE([Alumnos_Anotaciones])
  //GOTO RECORD([Alumnos_Anotaciones];<>aCdtaRecNo{vrow})
  //[Alumnos_Anotaciones]Fecha:=adSTRal_FechaAnotacion{vRow}
  //[Alumnos_Anotaciones]Motivo:=atSTRal_MotivoAnotacion{vRow}
  //[Alumnos_Anotaciones]Observaciones:=atSTRal_NotasAnotacion{vRow}
  //[Alumnos_Anotaciones]Profesor_Numero:=alSTRal_NoProfesorAnot{vRow}
  //SAVE RECORD([Alumnos_Anotaciones])
  //UNLOAD RECORD([Alumnos_Anotaciones])
  //READ ONLY([Alumnos_Anotaciones])
  //End if 
  //: (lastCdcta=7)
  //If ((<>aCdtaDate{vRow}#!00/00/0000!) & (<>aCdtaText1{vRow}#"") & (<>aCdtaLong1{vRow}#0) & (<>aCdtaNum1{vRow}>0))
  //READ WRITE([Alumnos_Castigos])
  //GOTO RECORD([Alumnos_Castigos];<>aCdtaRecNo{vrow})
  //[Alumnos_Castigos]Fecha:=<>aCdtaDate{vRow}
  //[Alumnos_Castigos]Motivo:=<>aCdtaText1{vRow}
  //[Alumnos_Castigos]Observaciones:=<>aCdtaText2{vRow}
  //[Alumnos_Castigos]Profesor_Numero:=<>aCdtaLong1{vRow}
  //[Alumnos_Castigos]Horas_de_castigo:=<>aCdtaNum1{vRow}
  //[Alumnos_Castigos]Castigo_cumplido:=<>aCdtaBool{vRow}
  //SAVE RECORD([Alumnos_Castigos])
  //UNLOAD RECORD([Alumnos_Castigos])
  //READ ONLY([Alumnos_Castigos])
  //End if 
  //: (lastCdcta=8)
  //TRACE
  //If ((<>aCdtaDate{vRow}#!00/00/0000!) & (<>aCdtaDate2{vRow}#!00/00/0000!) & (<>aCdtaText1{vRow}#"") & (<>aCdtaLong1{vRow}#0))
  //READ WRITE([Alumnos_Suspensiones])
  //GOTO RECORD([Alumnos_Suspensiones];<>aCdtaRecNo{vrow})
  //[Alumnos_Suspensiones]Desde:=<>aCdtaDate{vRow}
  //[Alumnos_Suspensiones]Hasta:=<>aCdtaDate2{vRow}
  //[Alumnos_Suspensiones]Motivo:=<>aCdtaText1{vRow}
  //[Alumnos_Suspensiones]Observaciones:=<>aCdtaText2{vRow}
  //[Alumnos_Suspensiones]Profesor_Numero:=<>aCdtaLong1{vRow}
  //[Alumnos_Suspensiones]Días_de_suspensión:=[Alumnos_Suspensiones]Hasta-[Alumnos_Suspensiones]Desde+1
  //SAVE RECORD([Alumnos_Suspensiones])
  //UNLOAD RECORD([Alumnos_Suspensiones])
  //READ ONLY([Alumnos_Suspensiones])
  //End if 
  //End case 
  //End if 

  //se crea metodo AL_actualizadatos
  //ticket 161577 