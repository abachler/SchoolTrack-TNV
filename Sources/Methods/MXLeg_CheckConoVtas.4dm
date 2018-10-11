//%attributes = {}
  //MXLeg_checkConoVtas
  // Verifica si en la preferencia "ConodeVentasFechaGen" tiene la fecha de hoy para generar el cono de ventas
C_TEXT:C284($vt_DatePref;$vt_DateWS;$vt_msg;$vt_statusCono;$vt_erorWS)
$vt_msg:=""
$vt_statusCono:=PREF_fGet (-555;"ConodeVentasStatus")

If ($vt_statusCono="Auto@")
	C_DATE:C307($vd_DatePref;$vd_DateWS)
	
	$vt_DateWS:=WS_Call_ObtenerFechaFotoMXCDV (->$vt_erorWS)
	$vt_DatePref:=PREF_fGet (-555;"ConodeVentasFechaGen")
	
	If ($vt_erorWS#"")
		$vt_msg:=$vt_erorWS+"\r"
	End if 
	
	$vl_aa:=Num:C11(Substring:C12($vt_DateWS;1;4))
	$vl_mm:=Num:C11(Substring:C12($vt_DateWS;6;2))
	$vl_dd:=Num:C11(Substring:C12($vt_DateWS;9;2))
	$vd_DateWS:=DT_GetDateFromDayMonthYear ($vl_dd;$vl_mm;$vl_aa)
	
	$vl_aa:=Num:C11(Substring:C12($vt_DatePref;1;4))
	$vl_mm:=Num:C11(Substring:C12($vt_DatePref;6;2))
	$vl_dd:=Num:C11(Substring:C12($vt_DatePref;9;2))
	$vd_DatePref:=DT_GetDateFromDayMonthYear ($vl_dd;$vl_mm;$vl_aa)
	
	If ($vd_DateWS>$vd_DatePref)
		PREF_Set (-555;"ConodeVentasFechaGen";$vt_DateWS)
		$vt_msg:="La fecha para la generación ha cambiado de "+$vt_datePref+" a "+$vt_dateWS+"\r"
	End if 
	
	$vt_DatePref:=PREF_fGet (-555;"ConodeVentasFechaGen")
	
	If ($vt_DatePref=Substring:C12(String:C10(Current date:C33(*)-1;8);1;10))
		MXLEG_ConoVtaXML ($vt_DatePref)
		$vt_msg:=$vt_msg+" Cono de ventas "+$vt_DatePref+" generado."
	End if 
	
	
End if 

$0:=$vt_msg