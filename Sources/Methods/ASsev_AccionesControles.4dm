//%attributes = {}
  //
  //C_POINTER($objectPtr;$1)
  //
  //If (Count parameters=1)
  //$objectPtr:=$1
  //Else 
  //$objectPtr:=Focus object
  //End if 
  //Case of 
  //: ($objectPtr=(->cb_UsarControlesSA))
  //If (cb_UsarControlesSA=0)  //Sin controles
  //OBJECT SET VISIBLE(*;"controlesSA@";False)
  //OBJECT MOVE(xALP_SubEvals;13;67;850;658;*)
  //[xxSTR_Subasignaturas]ModoControles:=0
  //[xxSTR_Subasignaturas]PonderacionControlInferior:=0
  //[xxSTR_Subasignaturas]ValorControlSiInferior:=0
  //[xxSTR_Subasignaturas]ValorControlSiSuperior:=0
  //vr_CTRL_INF_PonderacionSA:=0
  //vr_CTRL_SUP_PonderacionSA:=0
  //vs_CTRL_INF_Especifico:=""
  //vs_CTRL_SUP_Especifico:=""
  //vb_WindowsExpanded:=False
  //GET PICTURE FROM LIBRARY(12979;vp_ExpandCollapse)
  //OBJECT SET VISIBLE(vp_ExpandCollapse;False)
  //Else 
  //If (Old([xxSTR_Subasignaturas]ModoControles)=0)
  //OBJECT SET VISIBLE(*;"controlesSA@";True)
  //OBJECT MOVE(xALP_SubEvals;13;240;850;658;*)
  //vb_WindowsExpanded:=True
  //GET PICTURE FROM LIBRARY(12980;vp_ExpandCollapse)
  //OBJECT SET VISIBLE(vp_ExpandCollapse;True)
  //End if 
  //[xxSTR_Subasignaturas]ModoControles:=0
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?+ 1
  //OBJECT SET ENABLED(*;"controlesSAV@";False)
  //OBJECT SET ENTERABLE(*;"controlesSAV@";False)
  //OBJECT SET ENTERABLE([xxSTR_Subasignaturas]PonderacionControlInferior;True)
  //OBJECT SET COLOR(*;"controlesSAV11";-(16*16)+9)
  //OBJECT SET COLOR(*;"controlesSAV21";-(16*16)+9)
  //c1_PonderacionConstanteSA:=1
  //c2_PonderacionVariableSA:=0
  //ASsev_AccionesControles (->c1_PonderacionConstanteSA)
  //End if 
  //REDRAW WINDOW
  //: ($objectPtr=(->c1_PonderacionConstanteSA))
  //[xxSTR_Subasignaturas]ModoControles:=0
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?+ 1
  //[xxSTR_Subasignaturas]ValorControlSiInferior:=0
  //[xxSTR_Subasignaturas]ValorControlSiSuperior:=0
  //vr_CTRL_INF_PonderacionSA:=0
  //vr_CTRL_SUP_PonderacionSA:=0
  //vs_CTRL_INF_Especifico:=""
  //vs_CTRL_SUP_Especifico:=""
  //OBJECT SET ENABLED(*;"controlesSAV@";False)
  //OBJECT SET ENTERABLE(*;"controlesSAV@";False)
  //OBJECT SET ENTERABLE([xxSTR_Subasignaturas]PonderacionControlInferior;True)
  //OBJECT SET COLOR(*;"controlesSAV11";-(16*16)+9)
  //OBJECT SET COLOR(*;"controlesSAV21";-(16*16)+9)
  //: ($objectPtr=(->[xxSTR_Subasignaturas]PonderacionControlInferior))
  //
  //: ($objectPtr=(->c2_PonderacionVariableSA))
  //OBJECT SET ENABLED(*;"controlesSAV@";True)
  //OBJECT SET ENTERABLE(*;"controlesSAV@";True)
  //OBJECT SET ENTERABLE([xxSTR_Subasignaturas]PonderacionControlInferior;False)
  //If (t4_CTRL_INF_EspecificoSA=1)
  //OBJECT SET COLOR(*;"controlesSAV11";-6)
  //Else 
  //OBJECT SET COLOR(*;"controlesSAV11";-(16*16)+9)
  //End if 
  //If (u4_CTRL_SUP_EspecificoSA=1)
  //OBJECT SET COLOR(*;"controlesSAV21";-6)
  //Else 
  //OBJECT SET COLOR(*;"controlesSAV21";-(16*16)+9)
  //End if 
  //Case of 
  //: (t1_CTRL_INF_PonderadoSA=1)
  //ASsev_AccionesControles (->t1_CTRL_INF_PonderadoSA)
  //: (t2_CTRL_INF_PromedioSA=1)
  //ASsev_AccionesControles (->t2_CTRL_INF_PromedioSA)
  //: (t3_CTRL_INF_ControlSA=1)
  //ASsev_AccionesControles (->t3_CTRL_INF_ControlSA)
  //: (t4_CTRL_INF_EspecificoSA=1)
  //ASsev_AccionesControles (->t4_CTRL_INF_EspecificoSA)
  //End case 
  //Case of 
  //: (u1_CTRL_SUP_PonderadoSA=1)
  //ASsev_AccionesControles (->u1_CTRL_SUP_PonderadoSA)
  //: (u2_CTRL_SUP_PromedioSA=1)
  //ASsev_AccionesControles (->u2_CTRL_SUP_PromedioSA)
  //: (u3_CTRL_SUP_ControlSA=1)
  //ASsev_AccionesControles (->u3_CTRL_SUP_ControlSA)
  //: (u4_CTRL_SUP_EspecificoSA=1)
  //ASsev_AccionesControles (->u4_CTRL_SUP_EspecificoSA)
  //End case 
  //: ($objectPtr=(->t1_CTRL_INF_PonderadoSA))
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 1
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 11  // ponderado
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 12  // igual a promedio final
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 13  // igual a examen
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 14  // igual a:
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?+ 11
  //If (([xxSTR_Subasignaturas]ModoControles ?? 14) & (Not(Old([xxSTR_Subasignaturas]ModoControles) ?? 14)))
  //[xxSTR_Subasignaturas]ValorControlSiInferior:=0
  //End if 
  //OBJECT SET ENTERABLE(vr_CTRL_INF_PonderacionSA;True)
  //OBJECT SET ENTERABLE([xxSTR_Subasignaturas]ValorControlSiInferior;False)
  //: ($objectPtr=(->vr_CTRL_INF_PonderacionSA))
  //[xxSTR_Subasignaturas]ValorControlSiInferior:=vr_CTRL_INF_PonderacionSA
  //: ($objectPtr=(->t2_CTRL_INF_PromedioSA))
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 1
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 11  // ponderado
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 12  // igual a promedio final
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 13  // igual a examen
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 14  // igual a:
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?+ 12
  //If (([xxSTR_Subasignaturas]ModoControles ?? 14) & (Not(Old([xxSTR_Subasignaturas]ModoControles) ?? 14)))
  //[xxSTR_Subasignaturas]ValorControlSiInferior:=0
  //End if 
  //OBJECT SET ENTERABLE(vr_CTRL_INF_PonderacionSA;False)
  //OBJECT SET ENTERABLE([xxSTR_Subasignaturas]ValorControlSiInferior;False)
  //OBJECT SET COLOR(*;"controlesSAV11";-(16*16)+9)
  //: ($objectPtr=(->t3_CTRL_INF_ControlSA))
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 1
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 11  // ponderado
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 12  // igual a promedio final
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 13  // igual a examen
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 14  // igual a:
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?+ 13
  //If (([xxSTR_Subasignaturas]ModoControles ?? 14) & (Not(Old([xxSTR_Subasignaturas]ModoControles) ?? 14)))
  //[xxSTR_Subasignaturas]ValorControlSiInferior:=0
  //End if 
  //OBJECT SET ENTERABLE(vr_CTRL_INF_PonderacionSA;False)
  //OBJECT SET ENTERABLE([xxSTR_Subasignaturas]ValorControlSiInferior;False)
  //OBJECT SET COLOR(*;"controlesSAV11";-(16*16)+9)
  //: ($objectPtr=(->t4_CTRL_INF_EspecificoSA))
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 1
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 11  // ponderado
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 12  // igual a promedio final
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 13  // igual a examen
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 14  // igual a:
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?+ 14
  //If (([xxSTR_Subasignaturas]ModoControles ?? 14) & (Not(Old([xxSTR_Subasignaturas]ModoControles) ?? 14)))
  //[xxSTR_Subasignaturas]ValorControlSiInferior:=0
  //End if 
  //OBJECT SET ENTERABLE(vr_CTRL_INF_PonderacionSA;False)
  //OBJECT SET ENTERABLE([xxSTR_Subasignaturas]ValorControlSiInferior;True)
  //OBJECT SET COLOR(*;"controlesSAV11";-6)
  //GOTO OBJECT(vs_CTRL_INF_Especifico)
  //: ($objectPtr=(->vs_CTRL_INF_Especifico))
  //$nValue:=Num(vs_CTRL_INF_Especifico)
  //Case of 
  //: (iEvaluationMode=Notas)
  //Case of 
  //: (($nValue<rGradesFrom) & (vs_CTRL_INF_Especifico#""))
  //vs_CTRL_INF_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rGradesFrom)+__ (" a ")+String(rGradesTo))
  //: ($nValue>rGradesTo)
  //vs_CTRL_INF_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rGradesFrom)+__ (" a ")+String(rGradesTo))
  //Else 
  //$percent:=NTA_StringValue2Percent (vs_CTRL_INF_Especifico)
  //vs_CTRL_INF_Especifico:=NTA_PercentValue2StringValue ($percent)
  //End case 
  //: (iEvaluationMode=Puntos)
  //Case of 
  //: (($nValue<rPointsFrom) & (vs_CTRL_INF_Especifico#""))
  //vs_CTRL_INF_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //: ($nValue>rPointsTo)
  //vs_CTRL_INF_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //Else 
  //$percent:=NTA_StringValue2Percent (vs_CTRL_INF_Especifico)
  //vs_CTRL_INF_Especifico:=NTA_PercentValue2StringValue ($percent)
  //End case 
  //: (iEvaluationMode=Porcentaje)
  //Case of 
  //: (($nValue<0) & (vs_CTRL_INF_Especifico#""))
  //vs_CTRL_INF_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //: ($nValue>100)
  //vs_CTRL_INF_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //Else 
  //$percent:=NTA_StringValue2Percent (vs_CTRL_INF_Especifico)
  //vs_CTRL_INF_Especifico:=String(Num(vs_CTRL_INF_Especifico);vs_percentFormat)
  //End case 
  //: (iEvaluationMode=Simbolos)
  //$el:=Find in array(aSymbol;vs_CTRL_INF_Especifico)
  //If ($el<0)
  //vs_CTRL_INF_Especifico:=""
  //CD_Dlog (0;__ ("Símbolo no definido. No puede ser aceptado como indicador."))
  //End if 
  //End case 
  //[xxSTR_Subasignaturas]ValorControlSiInferior:=NTA_StringValue2Percent (vs_CTRL_INF_Especifico)
  //: ($objectPtr=(->bCTRL_INFMinimo))
  //vs_CTRL_INF_Especifico:=NTA_PercentValue2StringValue (rPctMinimum)
  //[xxSTR_Subasignaturas]ValorControlSiInferior:=rPctMinimum
  //: ($objectPtr=(->u1_CTRL_SUP_PonderadoSA))
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 1
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 21
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 22
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 23
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 24
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?+ 21
  //If (([xxSTR_Subasignaturas]ModoControles ?? 24) & (Not(Old([xxSTR_Subasignaturas]ModoControles) ?? 24)))
  //[xxSTR_Subasignaturas]ValorControlSiSuperior:=0
  //End if 
  //OBJECT SET ENTERABLE(vr_CTRL_SUP_PonderacionSA;True)
  //OBJECT SET ENTERABLE([xxSTR_Subasignaturas]ValorControlSiSuperior;False)
  //OBJECT SET COLOR(*;"controlesSAV21";-(16*16)+9)
  //: ($objectPtr=(->vr_CTRL_SUP_PonderacionSA))
  //[xxSTR_Subasignaturas]ValorControlSiSuperior:=vr_CTRL_SUP_PonderacionSA
  //: ($objectPtr=(->u2_CTRL_SUP_PromedioSA))
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 1
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 21
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 22
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 23
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 24
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?+ 22
  //If (([xxSTR_Subasignaturas]ModoControles ?? 24) & (Not(Old([xxSTR_Subasignaturas]ModoControles) ?? 24)))
  //[xxSTR_Subasignaturas]ValorControlSiSuperior:=0
  //End if 
  //OBJECT SET ENTERABLE(vr_CTRL_SUP_PonderacionSA;False)
  //OBJECT SET ENTERABLE([xxSTR_Subasignaturas]ValorControlSiSuperior;False)
  //OBJECT SET COLOR(*;"controlesSAV21";-(16*16)+9)
  //: ($objectPtr=(->u3_CTRL_SUP_ControlSA))
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 1
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 21
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 22
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 23
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 24
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?+ 23
  //If (([xxSTR_Subasignaturas]ModoControles ?? 24) & (Not(Old([xxSTR_Subasignaturas]ModoControles) ?? 24)))
  //[xxSTR_Subasignaturas]ValorControlSiSuperior:=0
  //End if 
  //OBJECT SET ENTERABLE(vr_CTRL_SUP_PonderacionSA;False)
  //OBJECT SET ENTERABLE([xxSTR_Subasignaturas]ValorControlSiSuperior;False)
  //OBJECT SET COLOR(*;"controlesSAV21";-(16*16)+9)
  //: ($objectPtr=(->u4_CTRL_SUP_EspecificoSA))
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 1
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 21
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 22
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 23
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?- 24
  //[xxSTR_Subasignaturas]ModoControles:=[xxSTR_Subasignaturas]ModoControles ?+ 24
  //If (([xxSTR_Subasignaturas]ModoControles ?? 24) & (Not(Old([xxSTR_Subasignaturas]ModoControles) ?? 24)))
  //[xxSTR_Subasignaturas]ValorControlSiSuperior:=0
  //End if 
  //OBJECT SET ENTERABLE(vr_CTRL_SUP_PonderacionSA;False)
  //OBJECT SET ENTERABLE([xxSTR_Subasignaturas]ValorControlSiSuperior;True)
  //OBJECT SET COLOR(*;"controlesSAV21";-6)
  //GOTO OBJECT(vs_CTRL_SUP_Especifico)
  //: ($objectPtr=(->vs_CTRL_SUP_Especifico))
  //$nValue:=Num(vs_CTRL_SUP_Especifico)
  //Case of 
  //: (iEvaluationMode=Notas)
  //Case of 
  //: (($nValue<rGradesFrom) & (vs_CTRL_SUP_Especifico#""))
  //vs_CTRL_SUP_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rGradesFrom)+__ (" a ")+String(rGradesTo))
  //: ($nValue>rGradesTo)
  //vs_CTRL_SUP_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rGradesFrom)+__ (" a ")+String(rGradesTo))
  //Else 
  //$percent:=NTA_StringValue2Percent (vs_CTRL_SUP_Especifico)
  //vs_CTRL_SUP_Especifico:=NTA_PercentValue2StringValue ($percent)
  //End case 
  //: (iEvaluationMode=Puntos)
  //Case of 
  //: (($nValue<rPointsFrom) & (vs_CTRL_SUP_Especifico#""))
  //vs_CTRL_SUP_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //: ($nValue>rPointsTo)
  //vs_CTRL_SUP_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //Else 
  //$percent:=NTA_StringValue2Percent (vs_CTRL_SUP_Especifico)
  //vs_CTRL_SUP_Especifico:=NTA_PercentValue2StringValue ($percent)
  //End case 
  //: (iEvaluationMode=Porcentaje)
  //Case of 
  //: (($nValue<0) & (vs_CTRL_SUP_Especifico#""))
  //vs_CTRL_SUP_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //: ($nValue>100)
  //vs_CTRL_SUP_Especifico:=""
  //CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String(rPointsFrom)+__ (" a ")+String(rPointsTo))
  //Else 
  //$percent:=NTA_StringValue2Percent (vs_CTRL_SUP_Especifico)
  //vs_CTRL_SUP_Especifico:=String(Num(vs_CTRL_SUP_Especifico);vs_percentFormat)
  //End case 
  //: (iEvaluationMode=Simbolos)
  //$el:=Find in array(aSymbol;vs_CTRL_SUP_Especifico)
  //If ($el<0)
  //vs_CTRL_SUP_Especifico:=""
  //CD_Dlog (0;__ ("Símbolo no definido. No puede ser aceptado como indicador."))
  //End if 
  //End case 
  //[xxSTR_Subasignaturas]ValorControlSiSuperior:=NTA_StringValue2Percent (vs_CTRL_SUP_Especifico)
  //: ($objectPtr=(->bCTRL_SUPMinimo))
  //vs_CTRL_SUP_Especifico:=NTA_PercentValue2StringValue (rPctMinimum)
  //[xxSTR_Subasignaturas]ValorControlSiSuperior:=rPctMinimum
  //End case 
  //$oldMode:=Old([xxSTR_Subasignaturas]ModoControles)
  //$oldValorINF:=Old([xxSTR_Subasignaturas]ValorControlSiInferior)
  //$oldValorSUP:=Old([xxSTR_Subasignaturas]ValorControlSiSuperior)
  //$oldPondFija:=Old([xxSTR_Subasignaturas]PonderacionControlInferior)
  //SAVE RECORD([xxSTR_Subasignaturas])
  //If (([xxSTR_Subasignaturas]PonderacionControlInferior#$oldPondFija) | ([xxSTR_Subasignaturas]ModoControles#$oldMode) | ([xxSTR_Subasignaturas]ValorControlSiInferior#$oldValorINF) | ([xxSTR_Subasignaturas]ValorControlSiSuperior#$oldValorSUP))
  //If (([xxSTR_Subasignaturas]ModoControles=0) & ($oldMode>0))
  //AL_UpdateArrays (xALP_SubEvals;0)
  //$pos:=Find in array(aSubEvalControles;"@")
  //If ($pos>0)
  //OK:=CD_Dlog (0;__ ("Los controles registrados serán eliminados definitivamente. ¿Desea usted continuar?");__ ("");__ ("No");__ ("Si"))
  //If (ok=2)
  //ARRAY STRING(5;aSubEvalControles;0)
  //ARRAY STRING(5;aSubEvalControles;Size of array(aRealSubEvalP1))
  //ARRAY REAL(aRealSubEvalControles;0)
  //ARRAY REAL(aRealSubEvalControles;Size of array(aRealSubEvalP1))
  //ARRAY REAL(aRealSubEvalPresentacion;0)
  //ARRAY REAL(aRealSubEvalPresentacion;Size of array(aRealSubEvalP1))
  //ASsev_GuardaNomina (Record number([xxSTR_Subasignaturas]))
  //Else 
  //[xxSTR_Subasignaturas]ModoControles:=$oldMode
  //End if 
  //End if 
  //End if 
  //ASsev_LeePropiedadesControles2 
  //For ($i;1;Size of array(aSubEvalP1))
  //ASsev_Average ($i)
  //End for 
  //COPY ARRAY(aSubEvalID;aIdAlumnos_a_Recalcular)
  //ASsev_AreaSettings2 
  //AL_UpdateArrays (xALP_SubEvals;-2)
  //End if 