  // [Asignaturas].Configuracion_Examenes.resultadoFijoEXX_NF_SiSuperior()
  // 
  //
  // creado por: Alberto Bachler Klein: 07-12-15, 19:15:29
  // -----------------------------------------------------------


$l_usarTablaConversion:=iconversiontable
$y_CalificacionLiteral:=OBJECT Get pointer:C1124(Object current:K67:2)
$b_calificacionValida:=EV2_validaCalificacion ($y_CalificacionLiteral->;$y_CalificacionLiteral;->vr_NF_igual_EXX_SUP)
iconversiontable:=$l_usarTablaConversion
$y_CalificacionLiteral->:=Choose:C955(vr_NF_igual_EXX_SUP>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_NF_igual_EXX_SUP);"")  //ABC 188311 //01/09/2017

