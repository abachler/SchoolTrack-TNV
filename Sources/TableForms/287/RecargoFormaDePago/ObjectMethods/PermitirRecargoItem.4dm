If (Self:C308->=1)
	OBJECT SET ENTERABLE:C238(*;"MontoRecargo";True:C214)
	OBJECT SET ENTERABLE:C238(*;"CargoSeleccionado";True:C214)
	OBJECT SET ENTERABLE:C238(*;"Binvisible";True:C214)
	OBJECT SET ENABLED:C1123(*;"ItemSeleccionado";True:C214)
	OBJECT SET ENABLED:C1123(*;"MontoSeleccionado";True:C214)
	cs_ItemSeleccionado:=1
	cs_MontoSeleccionado:=0
Else 
	OBJECT SET ENTERABLE:C238(*;"MontoRecargo";False:C215)
	OBJECT SET ENTERABLE:C238(*;"CargoSeleccionado";False:C215)
	OBJECT SET ENTERABLE:C238(*;"Binvisible";False:C215)
	OBJECT SET ENABLED:C1123(*;"ItemSeleccionado";False:C215)
	OBJECT SET ENABLED:C1123(*;"MontoSeleccionado";False:C215)
	
	ACTfdp_OpcionesRecargos ("ReseteaValores")
	vl_IdItemSeleccionado:=0
End if 