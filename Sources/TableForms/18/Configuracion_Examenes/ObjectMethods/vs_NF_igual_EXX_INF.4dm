  // [Asignaturas].Configuracion_Examenes.resultadoFijoEXX_NF_SiInferior()
  // 
  //
  // creado por: Alberto Bachler Klein: 07-12-15, 19:16:35
  // -----------------------------------------------------------

$l_usarTablaConversion:=iconversiontable
$y_CalificacionLiteral:=OBJECT Get pointer:C1124(Object current:K67:2)
  //$b_calificacionValida:=EV2_validaCalificacion ($y_CalificacionLiteral->;$y_CalificacionLiteral;->vs_NF_igual_EXX_INF)
$b_calificacionValida:=EV2_validaCalificacion ($y_CalificacionLiteral->;$y_CalificacionLiteral;->vr_NF_igual_EXX_INF)  //ASM 20151215 
iconversiontable:=$l_usarTablaConversion
$y_CalificacionLiteral->:=Choose:C955(vr_NF_igual_EXX_INF>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_NF_igual_EXX_INF);"")

