Case of 
	: (Form event:C388=On Load:K2:1)
		vtACT_FirmaProt:="p.p. "+<>gCustom
		If (Not:C34(vb_RecordInInputForm))
			READ ONLY:C145([Personas:7])
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Documentos_de_Pago:176]ID_Apoderado:2)
		End if 
		vtACT_ApoderadoProt:=[Personas:7]Apellidos_y_nombres:30
		vtACT_INApdoProt:=[Personas:7]RUT:6
End case 