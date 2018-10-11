

$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	
	C_BOOLEAN:C305($mesAbierto)
	$mesAbierto:=ACTcm_IsMonthOpenFromDate ($Fechafecha)
	If (Not:C34($mesAbierto))
		
		vd_fechaDcto:=vd_fechaDctoOrg
		vt_fechaDcto:=String:C10(vd_fechaDcto)
		
		CD_Dlog (0;__ ("La fecha ingresada corresponde a un período cerrado."))
		
	Else 
		vt_fechaDcto:=$fecha
		vd_fechaDcto:=$Fechafecha
		
	End if 
	
Else 
	vt_fechaDcto:=dt_GetNullDateString 
	vd_fechaDcto:=!00-00-00!
End if 

