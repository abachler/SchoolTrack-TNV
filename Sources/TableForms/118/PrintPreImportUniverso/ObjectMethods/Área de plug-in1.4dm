Case of 
	: (Form event:C388=On Load:K2:1)
		$plErr:=PL_SetArraysNam (Self:C308->;1;5;"at_rutExApdoPAC";"at_nombreExApdoPAC";"aTelOf";"aTelDom";"aCel")
		If ($plErr=0)
			PL_SetHdrOpts (Self:C308->;2;0)
			PL_SetHeaders (Self:C308->;1;5;"RUT Ex PAC";"Nombre";"Tel. Oficina";"Tel. Domicilio";"Celular")
			PL_SetWidths (Self:C308->;1;5;60;130;85;60;60)
			If (<>vtXS_CountryCode="cl")
				PL_SetFormat (Self:C308->;1;"###.###.###-#";3;2)
			Else 
				PL_SetFormat (Self:C308->;1;"";3;2)
			End if 
			PL_SetHdrStyle (Self:C308->;0;"Tahoma";8;1)
			PL_SetStyle (Self:C308->;0;"Tahoma";8;0)
			PL_SetFrame (Self:C308->;1;"Black";"Black";0;1;"Black";"Black";0)
			PL_SetDividers (Self:C308->;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
		End if 
End case 