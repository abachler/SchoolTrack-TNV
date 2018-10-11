$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vdACTcr_fechaEmision:=$Fechafecha
Else 
	vdACTcr_fechaEmision:=!00-00-00!
End if 
vtACTcr_fechaEmision:=String:C10(Year of:C25(vdACTcr_fechaEmision);"0000")+"-"+String:C10(Month of:C24(vdACTcr_fechaEmision);"00")+"-"+String:C10(Day of:C23(vdACTcr_fechaEmision);"00")