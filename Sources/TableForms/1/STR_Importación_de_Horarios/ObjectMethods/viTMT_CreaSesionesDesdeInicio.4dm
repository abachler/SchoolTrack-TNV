If (Self:C308->=0)
	  //$msg:="Las nuevas asignaciones de horario solo serán válidas a contar de esta fecha y no"+" desde el inicio del año escolar.\r\r¿Está usted seguro(a) que es lo que desea hace"+"r?"
	$result:=CD_Dlog (0;__ ("Las nuevas asignaciones de horario solo serán válidas a contar de esta fecha y no desde el inicio del año escolar.\r\r¿Está usted seguro(a) que es lo que desea hacer?");__ ("");__ ("Si");__ ("No, no es lo que quiero hacer"))
	If ($result=2)
		Self:C308->:=1
	End if 
End if 