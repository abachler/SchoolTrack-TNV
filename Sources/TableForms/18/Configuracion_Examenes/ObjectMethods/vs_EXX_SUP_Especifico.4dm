  // [Asignaturas].Configuracion_Examenes.EXX_PondVariable12()
  // 
  //
  // creado por: Alberto Bachler Klein: 07-12-15, 19:10:02
  // -----------------------------------------------------------


$l_usarTablaConversion:=iconversiontable
$y_CalificacionLiteral:=OBJECT Get pointer:C1124(Object current:K67:2)
$b_calificacionValida:=EV2_validaCalificacion ($y_CalificacionLiteral->;$y_CalificacionLiteral;->vr_EXX_SUP_Especifico)
iconversiontable:=$l_usarTablaConversion
$y_CalificacionLiteral->:=Choose:C955(vr_EXX_SUP_Especifico>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_EXX_SUP_Especifico);"")

