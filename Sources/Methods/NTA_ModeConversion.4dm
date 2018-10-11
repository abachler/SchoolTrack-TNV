//%attributes = {}
  //NTA_ModeConversion


$l_modoOrigen:=$1
$l_modoDestino:=$2
vi_lastGradeView:=$l_modoDestino


Case of 
	: ($l_modoDestino=Notas)
		vlNTA_DecimalesParciales:=iGradesDec
		vlNTA_DecimalesPP:=iGradesDecPP
		vlNTA_DecimalesPF:=iGradesDecPF
		vlNTA_DecimalesNF:=iGradesDecNF
		vlNTA_DecimalesNO:=iGradesDecNO
		
	: ($l_modoDestino=Puntos)
		vlNTA_DecimalesParciales:=iPointsDec
		vlNTA_DecimalesPP:=iPointsDecPP
		vlNTA_DecimalesPF:=iPointsDecPF
		vlNTA_DecimalesNF:=iPointsDecNF
		vlNTA_DecimalesNO:=iPointsDecNO
		
	: ($l_modoDestino=Porcentaje)
		vlNTA_DecimalesParciales:=1
		vlNTA_DecimalesPP:=1
		vlNTA_DecimalesPF:=1
		vlNTA_DecimalesNF:=1
		vlNTA_DecimalesNO:=1
		
End case 


$l_arreglos:=Size of array:C274(aNtaRealArrPointers)
For ($i;1;$l_arreglos)
	AT_ResizeArrays (aNtaStrArrPointers{$i};Size of array:C274(aNtaRealArrPointers{$i}->))
	$y_arregloReales:=aNtaRealArrPointers{$i}
	$y_arregloLiterales:=aNtaStrArrPointers{$i}
	If (aNtaArrNames{$i}#"aNtaOF")
		For ($j;1;Size of array:C274($y_arregloReales->))
			Case of 
				: ((iEvaluationMode=Notas) & ($l_modoDestino=Simbolos))
					$r_evaluacion:=EV2_Real_a_Nota ($y_arregloReales->{$j})
					$y_arregloLiterales->{$j}:=EV2_Nota_a_Simbolo ($r_evaluacion)
				: ((iEvaluationMode=Puntos) & ($l_modoDestino=Simbolos))
					$r_evaluacion:=EV2_Real_a_Puntos ($y_arregloReales->{$j})
					$y_arregloLiterales->{$j}:=EV2_Puntos_a_Simbolo ($r_evaluacion)
				Else 
					$y_arregloLiterales->{$j}:=EV2_Real_a_Literal ($y_arregloReales->{$j};$l_modoDestino;vlNTA_DecimalesParciales)
			End case 
		End for 
	End if 
End for 


If ($l_modoDestino#$l_modoOrigen)
	Case of 
		: ($l_modoDestino=Notas)
			$t_formato:="####0"+<>tXS_RS_DecimalSeparator+("0"*iGradesDecPF)
			For ($i;1;Size of array:C274(aNtaPTC_Literal))
				aNtaPTC_Literal{$i}:=String:C10(aNtaPTC_Nota{$i};$t_formato)
			End for 
		: ($l_modoDestino=Puntos)
			$t_formato:="####0"+<>tXS_RS_DecimalSeparator+("0"*iPointsDecPF)
			For ($i;1;Size of array:C274(aNtaPTC_Literal))
				aNtaPTC_Literal{$i}:=String:C10(aNtaPTC_Puntos{$i};$t_formato)
			End for 
		: ($l_modoDestino=Porcentaje)
			$t_formato:="##0"+<>tXS_RS_DecimalSeparator+"0"
			For ($i;1;Size of array:C274(aNtaPTC_Literal))
				aNtaPTC_Literal{$i}:=String:C10(Round:C94(aNtaPTC_Real{$i};1);$t_formato)
			End for 
		: ($l_modoDestino=Simbolos)
			For ($i;1;Size of array:C274(aNtaPTC_Literal))
				aNtaPTC_Literal{$i}:=aNtaPTC_simbolos{$i}
			End for 
	End case 
End if 

