//%attributes = {}
  // QR_ValidaExpresionEnScript()
  // Por: Alberto Bachler K.: 19-08-15, 11:10:01
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($t_objeto)


If (False:C215)
	C_TEXT:C284(QR_ValidaExpresionEnScript ;$0)
	C_TEXT:C284(QR_ValidaExpresionEnScript ;$1)
End if 

$t_objeto:=$1

Case of 
	: ($t_objeto="@KRL_KRL_KRL_KRL_@")
		$t_objeto:=Replace string:C233($t_objeto;"KRL_KRL_KRL_KRL_";"KRL_")
		
	: ($t_objeto="@KRL_KRL_KRL_@")
		$t_objeto:=Replace string:C233($t_objeto;"KRL_KRL_KRL_";"KRL_")
		
	: ($t_objeto="@KRL_KRL_@")
		$t_objeto:=Replace string:C233($t_objeto;"KRL_KRL_";"KRL_")
		
	: ($t_objeto="@<>agDebP@")
		$t_objeto:=Replace string:C233($t_objeto;"<>agDebP";"adSTR_Periodos_Desde")
		
	: ($t_objeto="@<>aGfinP@")
		$t_objeto:=Replace string:C233($t_objeto;"<>aGfinP";"adSTR_Periodos_Hasta")
		
	: ($t_objeto="@old@")
		$t_objeto:=Replace string:C233($t_objeto;"old";"New")
		
	: ($t_objeto="@dt_DayNameFromDate@")
		$t_objeto:=Replace string:C233($t_objeto;"dt_DayNameFromDate";"dt_GetDayNameFromDate")
		
	: ($t_objeto="@dt_DayNameFromDate@")
		$t_objeto:=Replace string:C233($t_objeto;"dt_getSpainDate";"DT_Date2SpanishString")
		
	: ($t_objeto="@QR_StudentAverage@")
		$t_objeto:=Replace string:C233($t_objeto;"QR_StudentAverage";"AL_PromedioNotas")
		
	: ($t_objeto="@QR_StudentPreviousAverages@")
		$t_objeto:=Replace string:C233($t_objeto;"QR_StudentPreviousAverages";"AL_PromedioNotasHistoricas")
		
	: ($t_objeto="@QRf_ConvierteEvaluacion@")
		$t_objeto:=Replace string:C233($t_objeto;"QRf_ConvierteEvaluacion";"_ConvierteEvaluacion")
		
	: ($t_objeto="@QRf_Nota@")
		$t_objeto:=Replace string:C233($t_objeto;"QRf_Nota";"_Evaluacion_a_Nota")
		
	: ($t_objeto="@QRf_puntos@")
		$t_objeto:=Replace string:C233($t_objeto;"QRf_puntos";"_Evaluacion_a_Puntos")
		
	: ($t_objeto="@QRf_Simbolos@")
		$t_objeto:=Replace string:C233($t_objeto;"QRf_Simbolos";"_Evaluacion_a_Simbolos")
		
	: ($t_objeto="@QRf_Porcentaje@")
		$t_objeto:=Replace string:C233($t_objeto;"QRf_Porcentaje";"_Evaluación_a_Porcentajes")
		
	: ($t_objeto="@QRf_PromedioUchile@")
		$t_objeto:=Replace string:C233($t_objeto;"QRf_PromedioUchile";"AL_PromedioUChile_cl")
		
	: ($t_objeto="@ReturnAge@")
		$t_objeto:=Replace string:C233($t_objeto;"ReturnAge";"_Edad")
		
	: ($t_objeto="@Sru_ResizeTextObject@")
		$t_objeto:=Replace string:C233($t_objeto;"Sru_ResizeTextObject";"SR_ResizeTextObject")
		
	: ($t_objeto="@SR_LogoColegio@")
		$t_objeto:=Replace string:C233($t_objeto;"SR_LogoColegio";"_LogoInstitucion")
		
	: ($t_objeto="@RF_CampoPropio@")
		$t_objeto:=Replace string:C233($t_objeto;"RF_CampoPropio";"_CampoPropio")
		
	: ($t_objeto="@QRf_CampoPropio@")
		$t_objeto:=Replace string:C233($t_objeto;"QRf_CampoPropio";"_CampoPropio")
		
	: ($t_objeto="@q_CampoPropio@")
		$t_objeto:=Replace string:C233($t_objeto;"q_CampoPropio";"_CampoPropio")
		
	: ($t_objeto="@RFReparticion@")
		$t_objeto:=Replace string:C233($t_objeto;"RFReparticion";"_DistribucionNotas")
		
	: ($t_objeto="@dt_GetSpainDate@")
		$t_objeto:=Replace string:C233($t_objeto;"dt_GetSpainDate";"DT_Date2SpanishString")
		
	: (($t_objeto="@RelateSelection@") & ($t_objeto#"@KRL_RelateSelection@"))
		$t_objeto:=Replace string:C233($t_objeto;"RelateSelection";"KRL_RelateSelection")
		
	: (($t_objeto="@<>aPeriodos@") | ($t_objeto="@aPeriodos@"))
		$t_objeto:=Replace string:C233($t_objeto;"<>aPeriodos";"atSTR_Periodos_Nombre")
		$t_objeto:=Replace string:C233($t_objeto;"aPeriodos";"atSTR_Periodos_Nombre")
		
	: ($t_objeto="@Delete selection([Alumnos_InformeDeNotas])@")
		$t_objeto:=Replace string:C233($t_objeto;"Delete selection([Alumnos_InformeDeNotas])";"")
		
	: ($t_objeto="@QR_ChoosePeriod@")
		$t_objeto:=Replace string:C233($t_objeto;"QR_ChoosePeriod";"_SeleccionaPeriodo")
End case 

$0:=$t_objeto