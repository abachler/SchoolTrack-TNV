  // [Asignaturas].Configuracion_Examenes.resultadoFijoEX1()
  // 
  //
  // creado por: Alberto Bachler Klein: 07-12-15, 19:14:40
  // -----------------------------------------------------------

$l_usarTablaConversion:=iconversiontable
$y_CalificacionLiteral:=OBJECT Get pointer:C1124(Object current:K67:2)
$b_calificacionValida:=EV2_validaCalificacion ($y_CalificacionLiteral->;$y_CalificacionLiteral;->vr_CalificacionEXX)
iconversiontable:=$l_usarTablaConversion
$y_CalificacionLiteral->:=Choose:C955(vr_CalificacionEXX>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_CalificacionEXX);"")