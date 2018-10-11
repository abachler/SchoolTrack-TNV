  // [STR_Medicos].Input.retirar()
  // Por: Alberto Bachler K.: 27-06-14, 16:33:40
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		Case of 
			: (OBJECT Get enabled:C1079(*;OBJECT Get name:C1087(Object current:K67:2)))
				IT_MuestraTip (__ ("Eliminar el médico seleccionado"))
			: (Records in set:C195("seleccionMedico")=0)
				IT_MuestraTip (__ ("Eliminar el médico seleccionado")+" "+__ ("(inactivo porque no hay médico seleccionado)"))
			Else 
				IT_MuestraTip (__ ("Eliminar el médico seleccionado")+" "+__ ("(inactivo porque el médico está asignado a algún alumno)"))
		End case 
		
	: (Form event:C388=On Clicked:K2:4)
		CREATE SET:C116([STR_Medicos:89];"$temp")
		USE SET:C118("seleccionMedico")
		KRL_DeleteRecord (->[STR_Medicos:89])
		USE SET:C118("$temp")
		ORDER BY:C49([STR_Medicos:89];[STR_Medicos:89]Apellidos:7;>;[STR_Medicos:89]Nombres:1;>)
		
End case 
