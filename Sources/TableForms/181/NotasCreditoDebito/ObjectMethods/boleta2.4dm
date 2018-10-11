If (Form event:C388=On Data Change:K2:15)
	$date:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(Self:C308->;1;2));Num:C11(Substring:C12(Self:C308->;3;2));Num:C11(Substring:C12(Self:C308->;5)))
	$StringFecha:=String:C10($date)
	$FechaFecha:=Date:C102(DT_StrDateIsOK ($StringFecha))
	
	C_BOOLEAN:C305($mesAbierto)
	$mesAbierto:=ACTcm_IsMonthOpenFromDate ($FechaFecha)
	If (Not:C34($mesAbierto))
		Self:C308->:=String:C10(vd_fechaDcto)
		CD_Dlog (0;__ ("La fecha ingresada corresponde a un período cerrado."))
	Else 
		
		If ($FechaFecha=!00-00-00!)
			Self:C308->:=""
			GOTO OBJECT:C206(Self:C308->)
		Else 
			Self:C308->:=$StringFecha
		End if 
		vd_fechaDcto:=$FechaFecha
		
	End if 
	
End if 