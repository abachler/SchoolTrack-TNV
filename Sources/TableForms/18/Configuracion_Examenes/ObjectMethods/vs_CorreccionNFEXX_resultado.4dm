  // [Asignaturas].Configuracion_Examenes.CorreccionNFEXX_8()
  // 
  //
  // creado por: Alberto Bachler Klein: 07-12-15, 19:13:49
  // -----------------------------------------------------------



$l_usarTablaConversion:=iconversiontable
$y_CalificacionLiteral:=OBJECT Get pointer:C1124(Object current:K67:2)
$b_calificacionValida:=EV2_validaCalificacion ($y_CalificacionLiteral->;$y_CalificacionLiteral;->vr_CorreccionNFEXX_resultado)
iconversiontable:=$l_usarTablaConversion
$y_CalificacionLiteral->:=Choose:C955(vr_CorreccionNFEXX_resultado>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_CorreccionNFEXX_resultado);"")