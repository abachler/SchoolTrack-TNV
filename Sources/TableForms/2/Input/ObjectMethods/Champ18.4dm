TRACE:C157
Case of 
	: (Form event:C388=On Data Change:K2:15)
		
		C_DATE:C307($fechaIngreso)
		$fechaIngreso:=[Alumnos:2]Fecha_de_Ingreso:41
		
		  //16-05-2011 AS. se valida que el año de la fecha ingresada sea menor o igual al año de la base.
		
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		
		$year:=Year of:C25(adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)})
		
		If (Year of:C25($fechaIngreso)>$year)
			CD_Dlog (0;__ ("Año de ingreso mayor que el año actual, favor modificar"))
			[Alumnos:2]Fecha_de_Ingreso:41:=!00-00-00!
		Else 
			If ($fechaIngreso>[Alumnos:2]Fecha_de_retiro:42) & ([Alumnos:2]Fecha_de_retiro:42#!00-00-00!)
				STRal_ValidaInfoConductual ([Alumnos:2]numero:1;$fechaIngreso;True:C214)  //20120713 ASM . para eliminar información conductual.
			Else 
				If ($fechaIngreso>Old:C35([Alumnos:2]Fecha_de_Ingreso:41))
					STRal_ValidaInfoConductual ([Alumnos:2]numero:1;$fechaIngreso;False:C215)  //20120713 ASM . para eliminar información conductual.
				End if 
			End if 
			[Alumnos:2]Fecha_de_Ingreso:41:=$fechaIngreso
		End if 
		
End case 