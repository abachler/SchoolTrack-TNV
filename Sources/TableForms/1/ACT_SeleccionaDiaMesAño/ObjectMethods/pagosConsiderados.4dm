If (vbACT_MostrarFechaCorte)
	If (Self:C308->=1)
		OBJECT SET VISIBLE:C603(*;"pagosConsideradosF_@";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"pagosConsideradosF_@";False:C215)
	End if 
End if 