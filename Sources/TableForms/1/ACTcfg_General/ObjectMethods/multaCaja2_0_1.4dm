Case of 
	: (Form event:C388=On Losing Focus:K2:8)
		$StringFecha:=String:C10(vdACT_FechaRXC)
		$FechaFecha:=Date:C102(DT_StrDateIsOK ($StringFecha))
		If ($FechaFecha=!00-00-00!)
			vdACT_FechaRXC:=!00-00-00!
			GOTO OBJECT:C206(Self:C308->)
		End if 
		
End case 