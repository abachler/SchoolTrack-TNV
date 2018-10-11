Case of 
	: (Form event:C388=On Losing Focus:K2:8)
		$date:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(Self:C308->;1;2));Num:C11(Substring:C12(Self:C308->;3;2));Num:C11(Substring:C12(Self:C308->;5)))
		$StringFecha:=String:C10($date)
		$FechaFecha:=Date:C102(DT_StrDateIsOK ($StringFecha))
		If ($FechaFecha=!00-00-00!)
			Self:C308->:=""
			GOTO OBJECT:C206(Self:C308->)
		Else 
			Self:C308->:=$StringFecha
		End if 
		vdACTcfg_Fecha:=$FechaFecha
		
	: (Form event:C388=On Data Change:K2:15)
		ACTcfg_ItemsMatricula ("CambioFecha")
		
End case 