If (Self:C308->>0)
	[Alumnos:2]Comuna:14:=Self:C308->{Self:C308->}
	Case of 
		: (<>vtXS_CountryCode="cl")
			READ ONLY:C145([xxSTR_Comunas:94])
			QUERY:C277([xxSTR_Comunas:94];[xxSTR_Comunas:94]Nombre_comuna:7=[Alumnos:2]Comuna:14;*)
			QUERY:C277([xxSTR_Comunas:94]; & [xxSTR_Comunas:94]Pais:10=<>gPais)
			If (Records in selection:C76([xxSTR_Comunas:94])>0)
				[Alumnos:2]Codigo_Comuna:79:=[xxSTR_Comunas:94]Code_comuna:4
			Else 
				CD_Dlog (0;[Alumnos:2]Comuna:14+__ (" no es una comuna oficial en ")+<>gPais+__ ("."))
			End if 
		Else 
			  //nada
	End case 
End if 