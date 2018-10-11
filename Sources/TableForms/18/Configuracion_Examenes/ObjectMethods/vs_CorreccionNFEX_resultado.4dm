  // [Asignaturas].Configuracion_Examenes.resultadoFijoEX_NF_SiSuperior()
  // 
  //
  // creado por: Alberto Bachler Klein: 04-12-15, 09:36:08
  // -----------------------------------------------------------


$l_usarTablaConversion:=iconversiontable
$y_CalificacionLiteral:=OBJECT Get pointer:C1124(Object current:K67:2)
$b_calificacionValida:=EV2_validaCalificacion ($y_CalificacionLiteral->;$y_CalificacionLiteral;->vr_CorreccionNFEX_resultado)
iconversiontable:=$l_usarTablaConversion
$y_CalificacionLiteral->:=Choose:C955(vr_CorreccionNFEX_resultado>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_CorreccionNFEX_resultado);"")