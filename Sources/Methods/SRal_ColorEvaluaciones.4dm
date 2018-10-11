//%attributes = {}
  // SRal_ColorEvaluaciones()
  // Por: Alberto Bachler K.: 14-08-15, 16:04:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_color;$y_objeto)
C_TEXT:C284($t_nombreVariable;$t_tipoObjeto)

$y_objeto:=SR_GetVariableFieldInfo (->$t_nombreVariable;->$t_tipoObjeto)

Case of 
	: (($t_tipoObjeto="Var") | ($t_tipoObjeto="variable"))
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_PromedioG";"vs_TextColorG")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_NotaFinalG";"vs_TextColorFinalG")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_NotaFinalOficialG";"vs_TextColorFinalOficialG")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_EvaluacionOficial";"vs_TextColorFinalOficialG")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_NotaOficial";"vs_TextColorFinalOficialG")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_PuntosOficial";"vs_TextColorFinalOficialG")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_SimbolosOficial";"vs_TextColorFinalOficialG")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_PorcentajeOficial";"vs_TextColorFinalOficialG")
		
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_Evaluacion";"vs_TextColor")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_Nota";"vs_TextColor")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_Puntos";"vs_TextColor")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_simbolos";"vs_TextColor")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vr_Porcentaje";"vs_TextColor")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_Indicador";"vs_TextColor")
		
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_EvaluacionMinSubject";"vs_MinSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_NotaMinSubject";"vs_MinSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_PuntosMinSubject";"vs_MinSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vr_PorcentajesMinSubject";"vs_MinSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_SimbolosMinSubject";"vs_MinSubject_Color")
		
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_EvaluacionMaxSubject";"vs_MaxSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_NotaMaxSubject";"vs_MaxSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_PuntosMaxSubject";"vs_MaxSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vr_PorcentajesMaxSubject";"vs_MaxSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_SimbolosMaxSubject";"vs_MaxSubject_Color")
		
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_EvaluacionAvgSubject";"vs_AvgSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_NotaAvgSubject";"vs_AvgSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_PuntosAvgSubject";"vs_AvgSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vr_PorcentajesAvgSubject";"vs_AvgSubject_Color")
		$t_nombreVariable:=Replace string:C233($t_nombreVariable;"vs_SimbolosAvgSubject";"vs_AvgSubject_Color")
		
		$y_objeto:=Get pointer:C304($t_nombreVariable)
		If ((Not:C34(Is nil pointer:C315($y_objeto)) & (Not:C34(Undefined:C82($y_objeto->)))))
			SR_SetColor ($y_objeto->;"White")
		End if 
		
	: ($t_tipoObjeto="field")
		
		If ((Not:C34(Is nil pointer:C315($y_objeto)) & (Not:C34(Undefined:C82($y_objeto->)))))  //MONO Ticket 182430
			Case of 
				: ($y_objeto->=-10)
					SR_SetColor ("White";"White")
				: ($y_objeto-><vrNTA_MinimoEscalaReferencia)
					SR_SetColor ("Black";"White")
				: ($y_objeto-><rPctMinimum)
					SR_SetColor ("Red";"White")
				Else 
					SR_SetColor ("Blue";"White")
			End case 
			
		End if 
End case 


