  //$percent:=NTA_StringValue2Percent (Self->)
$nValue:=Num:C11(Self:C308->)
Case of 
	: (iEvaluationMode=Notas)
		Case of 
			: (($nValue<rGradesFrom) & (Self:C308->#""))
				Self:C308->:=""
				CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String:C10(rGradesFrom)+__ (" a ")+String:C10(rGradesTo))
			: ($nValue>rGradesTo)
				Self:C308->:=""
				CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String:C10(rGradesFrom)+__ (" a ")+String:C10(rGradesTo))
			Else 
				$percent:=NTA_StringValue2Percent (Self:C308->)
				Self:C308->:=NTA_PercentValue2StringValue ($percent)
		End case 
	: (iEvaluationMode=Puntos)
		Case of 
			: (($nValue<rPointsFrom) & (Self:C308->#""))
				Self:C308->:=""
				CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String:C10(rPointsFrom)+__ (" a ")+String:C10(rPointsTo))
			: ($nValue>rPointsTo)
				Self:C308->:=""
				CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String:C10(rPointsFrom)+__ (" a ")+String:C10(rPointsTo))
			Else 
				$percent:=NTA_StringValue2Percent (Self:C308->)
				Self:C308->:=NTA_PercentValue2StringValue ($percent)
		End case 
		
	: (iEvaluationMode=Porcentaje)
		Case of 
			: (($nValue<0) & (Self:C308->#""))
				Self:C308->:=""
				CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String:C10(rPointsFrom)+__ (" a ")+String:C10(rPointsTo))
			: ($nValue>100)
				Self:C308->:=""
				CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String:C10(rPointsFrom)+__ (" a ")+String:C10(rPointsTo))
			Else 
				$percent:=NTA_StringValue2Percent (Self:C308->)
				Self:C308->:=String:C10(Num:C11(Self:C308->);vs_percentFormat)
		End case 
		
		
	: (iEvaluationMode=Simbolos)
		$el:=Find in array:C230(aSymbol;Self:C308->)
		If ($el<0)
			Self:C308->:=""
			CD_Dlog (0;__ ("Símbolo no definido. No puede ser aceptado como indicador."))
		Else 
			
		End if 
		
End case 


