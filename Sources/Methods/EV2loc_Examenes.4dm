//%attributes = {}
  //  //EV2loc_Examenes
  //
  //Case of 
  //: (<>vtXS_CountryCode="ar")
  //Case of 
  //: ((<>gCustom="@St. Hilda's College@") | (<>gRolBD="10008"))
  //If ([Alumnos_Calificaciones]ExamenAnual_Real>=40)
  //[Alumnos_Calificaciones]EvaluacionFinal_Real:=[Alumnos_Calificaciones]ExamenAnual_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_RealNoAprox:=[Alumnos_Calificaciones]ExamenAnual_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_Nota:=[Alumnos_Calificaciones]ExamenAnual_Nota
  //[Alumnos_Calificaciones]EvaluacionFinal_Puntos:=[Alumnos_Calificaciones]ExamenAnual_Puntos
  //[Alumnos_Calificaciones]EvaluacionFinal_Literal:=[Alumnos_Calificaciones]ExamenAnual_Literal
  //[Alumnos_Calificaciones]EvaluacionFinal_Simbolo:=[Alumnos_Calificaciones]ExamenAnual_Simbolo
  //End if 
  //If ([Alumnos_Calificaciones]ExamenAnual_Real>=40)
  //If ([Alumnos_Calificaciones]ExamenExtra_Real<0)
  //[Alumnos_Calificaciones]EvaluacionFinal_Real:=[Alumnos_Calificaciones]ExamenAnual_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_RealNoAprox:=[Alumnos_Calificaciones]ExamenAnual_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_Nota:=[Alumnos_Calificaciones]ExamenAnual_Nota
  //[Alumnos_Calificaciones]EvaluacionFinal_Puntos:=[Alumnos_Calificaciones]ExamenAnual_Puntos
  //[Alumnos_Calificaciones]EvaluacionFinal_Literal:=[Alumnos_Calificaciones]ExamenAnual_Literal
  //[Alumnos_Calificaciones]EvaluacionFinal_Simbolo:=[Alumnos_Calificaciones]ExamenAnual_Simbolo
  //End if 
  //End if 
  //
  //: ((<>gRegion="Capital Federal") | (<>gRegion="Districto Federal"))
  //  //Chance de EXAMEN MONO TICKET 112576
  //If (([Alumnos_Calificaciones]Reprobada) & ([Alumnos_Calificaciones]ExamenAnual_Real>=60))
  //If ([Alumnos_Calificaciones]ExamenExtra_Real<0)
  //[Alumnos_Calificaciones]EvaluacionFinal_Real:=[Alumnos_Calificaciones]ExamenAnual_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_RealNoAprox:=[Alumnos_Calificaciones]ExamenAnual_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_Nota:=[Alumnos_Calificaciones]ExamenAnual_Nota
  //[Alumnos_Calificaciones]EvaluacionFinal_Puntos:=[Alumnos_Calificaciones]ExamenAnual_Puntos
  //[Alumnos_Calificaciones]EvaluacionFinal_Literal:=[Alumnos_Calificaciones]ExamenAnual_Literal
  //[Alumnos_Calificaciones]EvaluacionFinal_Simbolo:=[Alumnos_Calificaciones]ExamenAnual_Simbolo
  //End if 
  //End if 
  //
  //If (([Alumnos_Calificaciones]Reprobada) & ([Alumnos_Calificaciones]ExamenExtra_Real>=60))
  //[Alumnos_Calificaciones]EvaluacionFinal_Real:=[Alumnos_Calificaciones]ExamenExtra_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_RealNoAprox:=[Alumnos_Calificaciones]ExamenExtra_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_Nota:=[Alumnos_Calificaciones]ExamenExtra_Nota
  //[Alumnos_Calificaciones]EvaluacionFinal_Puntos:=[Alumnos_Calificaciones]ExamenExtra_Puntos
  //[Alumnos_Calificaciones]EvaluacionFinal_Literal:=[Alumnos_Calificaciones]ExamenExtra_Literal
  //[Alumnos_Calificaciones]EvaluacionFinal_Simbolo:=[Alumnos_Calificaciones]ExamenExtra_Simbolo
  //End if 
  //
  //Else 
  //
  //  //MONO: ticket 112576 - Chance de EXAMEN
  //If ([Alumnos_Calificaciones]ExamenAnual_Real>=40)
  //If ([Alumnos_Calificaciones]ExamenExtra_Real<0)
  //[Alumnos_Calificaciones]EvaluacionFinal_Real:=[Alumnos_Calificaciones]ExamenAnual_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_RealNoAprox:=[Alumnos_Calificaciones]ExamenAnual_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_Nota:=[Alumnos_Calificaciones]ExamenAnual_Nota
  //[Alumnos_Calificaciones]EvaluacionFinal_Puntos:=[Alumnos_Calificaciones]ExamenAnual_Puntos
  //[Alumnos_Calificaciones]EvaluacionFinal_Literal:=[Alumnos_Calificaciones]ExamenAnual_Literal
  //[Alumnos_Calificaciones]EvaluacionFinal_Simbolo:=[Alumnos_Calificaciones]ExamenAnual_Simbolo
  //End if 
  //End if 
  //
  //If (([Alumnos_Calificaciones]Reprobada) & ([Alumnos_Calificaciones]ExamenExtra_Real>=40))
  //[Alumnos_Calificaciones]EvaluacionFinal_Real:=[Alumnos_Calificaciones]ExamenExtra_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_RealNoAprox:=[Alumnos_Calificaciones]ExamenExtra_Real
  //[Alumnos_Calificaciones]EvaluacionFinal_Nota:=[Alumnos_Calificaciones]ExamenExtra_Nota
  //[Alumnos_Calificaciones]EvaluacionFinal_Puntos:=[Alumnos_Calificaciones]ExamenExtra_Puntos
  //[Alumnos_Calificaciones]EvaluacionFinal_Literal:=[Alumnos_Calificaciones]ExamenExtra_Literal
  //[Alumnos_Calificaciones]EvaluacionFinal_Simbolo:=[Alumnos_Calificaciones]ExamenExtra_Simbolo
  //End if 
  //
  //End case 
  //
  //
  //End case 
