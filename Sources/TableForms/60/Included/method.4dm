If (_O_During:C30)
	[BBL_Prestamos:60]Duración:6:=Current date:C33(*)-[BBL_Prestamos:60]Desde:3+1
	If ((Current date:C33>[BBL_Prestamos:60]Hasta:4) & ([BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!))
		OBJECT SET COLOR:C271([BBL_Prestamos:60]Desde:3;-3)
		OBJECT SET COLOR:C271([BBL_Prestamos:60]Hasta:4;-3)
		OBJECT SET COLOR:C271([BBL_Prestamos:60]Fecha_de_devolución:5;-3)
		OBJECT SET COLOR:C271([BBL_Prestamos:60]Duración:6;-3)
		OBJECT SET COLOR:C271([BBL_Lectores:72]NombreCompleto:3;-3)
		OBJECT SET COLOR:C271([BBL_Lectores:72]Grupo:2;-3)
	Else 
		OBJECT SET COLOR:C271([BBL_Prestamos:60]Desde:3;-15)
		OBJECT SET COLOR:C271([BBL_Prestamos:60]Hasta:4;-15)
		OBJECT SET COLOR:C271([BBL_Prestamos:60]Fecha_de_devolución:5;-15)
		OBJECT SET COLOR:C271([BBL_Prestamos:60]Duración:6;-15)
		OBJECT SET COLOR:C271([BBL_Lectores:72]NombreCompleto:3;-15)
		OBJECT SET COLOR:C271([BBL_Lectores:72]Grupo:2;-15)
	End if 
End if 