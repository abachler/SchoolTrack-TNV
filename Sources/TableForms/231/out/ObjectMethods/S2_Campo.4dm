  // [Asignaturas_Consolidantes].out.S2_Campo()
  // Por: Alberto Bachler K.: 21-03-14, 10:40:27
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_ParentRecord:5)
$y_variable:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreHija")
$y_variable->:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5

