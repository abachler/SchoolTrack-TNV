  // [Asignaturas].Configuracion_Examenes.resultadoFijoEX_NF_SiSuperior1()
  // 
  //
  // creado por: Alberto Bachler Klein: 07-12-15, 19:06:16
  // -----------------------------------------------------------



$l_usarTablaConversion:=iconversiontable
$y_CalificacionLiteral:=OBJECT Get pointer:C1124(Object current:K67:2)
$b_calificacionValida:=EV2_validaCalificacion ($y_CalificacionLiteral->;$y_CalificacionLiteral;->vr_NF_igual_EX_SUP)
iconversiontable:=$l_usarTablaConversion
$y_CalificacionLiteral->:=Choose:C955(vr_NF_igual_EX_SUP>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_NF_igual_EX_SUP);"")

