  // [Asignaturas].Configuracion_Examenes.CTRL_PondVariable12()
  // 
  //
  // creado por: Alberto Bachler Klein: 04-12-15, 09:47:38
  // -----------------------------------------------------------

$l_usarTablaConversion:=iconversiontable
$y_CalificacionLiteral:=OBJECT Get pointer:C1124(Object current:K67:2)
$b_calificacionValida:=EV2_validaCalificacion ($y_CalificacionLiteral->;$y_CalificacionLiteral;->vr_CTRL_SUP_Especifico)
iconversiontable:=$l_usarTablaConversion


  //  //$percent:=NTA_StringValue2Percent (Self->)
  //$nValue:=Num(Self->)
  //Case of 
  //: (iEvaluationMode=Notas)
  //Case of 
  //: (($nValue<rGradesFrom) & (Self->#""))
  //Self->:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rGradesFrom)+__ (" a ")+String(rGradesTo))
  //: ($nValue>rGradesTo)
  //Self->:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rGradesFrom)+__ (" a ")+String(rGradesTo))
  //Else 
  //$percent:=NTA_StringValue2Percent (Self->)
  //Self->:=NTA_PercentValue2StringValue ($percent)
  //End case 
  //: (iEvaluationMode=Puntos)
  //Case of 
  //: (($nValue<rPointsFrom) & (Self->#""))
  //Self->:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //: ($nValue>rPointsTo)
  //Self->:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //Else 
  //$percent:=NTA_StringValue2Percent (Self->)
  //Self->:=NTA_PercentValue2StringValue ($percent)
  //End case 
  //
  //: (iEvaluationMode=Porcentaje)
  //Case of 
  //: (($nValue<0) & (Self->#""))
  //Self->:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //: ($nValue>100)
  //Self->:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //Else 
  //$percent:=NTA_StringValue2Percent (Self->)
  //Self->:=String(Num(Self->);vs_percentFormat)
  //End case 
  //
  //
  //: (iEvaluationMode=Simbolos)
  //$el:=Find in array(aSymbol;Self->)
  //If ($el<0)
  //Self->:=""
  //CD_Dlog (0;__ ("Símbolo no definido. No puede ser aceptado como indicador."))
  //Else 
  //
  //End if 
  //
  //End case 
  //
  //
