Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vTitulo:="Resultados de la Pre Importación de archivo tipo "+vTipoUniv
		C_LONGINT:C283($Error)
		
		$error:=ALP_DefaultColSettings (xALP_Rechazados;1;"at_rutExApdoPAC";__ ("RUT Ex PAC");100;"")
		$error:=ALP_DefaultColSettings (xALP_Rechazados;2;"at_nombreExApdoPAC";"Nombre Ex PAC";150;"")
		ALP_SetDefaultAppareance (xALP_Rechazados;9;1;6;1;8)
		AL_SetMiscOpts (xALP_Rechazados;1;0;"\\";0;1)
		AL_SetColOpts (xALP_Rechazados;1;1;1;0;0)
		AL_SetRowOpts (xALP_Rechazados;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_Rechazados;0;1;1)
		AL_SetMainCalls (xALP_Rechazados;"";"")
		AL_SetCallbacks (xALP_Rechazados;"";"")
		AL_SetScroll (xALP_Rechazados;0;-3)
		AL_SetEntryOpts (xALP_Rechazados;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_Rechazados;0;30;0)
		
		$error:=ALP_DefaultColSettings (xALP_NoIdent;1;"at_rutNoIdentificados";__ ("Identificador");150;"")
		ALP_SetDefaultAppareance (xALP_NoIdent;9;1;6;1;8)
		AL_SetMiscOpts (xALP_NoIdent;1;0;"\\";0;1)
		AL_SetColOpts (xALP_NoIdent;1;1;1;0;0)
		AL_SetRowOpts (xALP_NoIdent;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_NoIdent;0;1;1)
		AL_SetMainCalls (xALP_NoIdent;"";"")
		AL_SetCallbacks (xALP_NoIdent;"";"")
		AL_SetScroll (xALP_NoIdent;0;-3)
		AL_SetEntryOpts (xALP_NoIdent;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_NoIdent;0;30;0)
		
		$error:=ALP_DefaultColSettings (xALP_MasdeUno;1;"at_rutMasDeUnaPersona";__ ("Identificador");150;"")
		ALP_SetDefaultAppareance (xALP_MasdeUno;9;1;6;1;8)
		AL_SetMiscOpts (xALP_MasdeUno;1;0;"\\";0;1)
		AL_SetColOpts (xALP_MasdeUno;1;1;1;0;0)
		AL_SetRowOpts (xALP_MasdeUno;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_MasdeUno;0;1;1)
		AL_SetMainCalls (xALP_MasdeUno;"";"")
		AL_SetCallbacks (xALP_MasdeUno;"";"")
		AL_SetScroll (xALP_MasdeUno;0;-3)
		AL_SetEntryOpts (xALP_MasdeUno;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_MasdeUno;0;30;0)
		
		$error:=ALP_DefaultColSettings (xALP_Invalidos;1;"at_rutInvalido";__ ("Identificador");150;"")
		ALP_SetDefaultAppareance (xALP_Invalidos;9;1;6;1;8)
		AL_SetMiscOpts (xALP_Invalidos;1;0;"\\";0;1)
		AL_SetColOpts (xALP_Invalidos;1;1;1;0;0)
		AL_SetRowOpts (xALP_Invalidos;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_Invalidos;0;1;1)
		AL_SetMainCalls (xALP_Invalidos;"";"")
		AL_SetCallbacks (xALP_Invalidos;"";"")
		AL_SetScroll (xALP_Invalidos;0;-3)
		AL_SetEntryOpts (xALP_Invalidos;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_Invalidos;0;30;0)
		
		$error:=ALP_DefaultColSettings (xALP_ApdoNoCta;1;"at_rutNoApoCta";__ ("Identificador");100;"")
		$error:=ALP_DefaultColSettings (xALP_ApdoNoCta;2;"at_nombreNoApoCta";__ ("Nombre");150;"")
		ALP_SetDefaultAppareance (xALP_ApdoNoCta;9;1;6;1;8)
		AL_SetMiscOpts (xALP_ApdoNoCta;1;0;"\\";0;1)
		AL_SetColOpts (xALP_ApdoNoCta;1;1;1;0;0)
		AL_SetRowOpts (xALP_ApdoNoCta;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_ApdoNoCta;0;1;1)
		AL_SetMainCalls (xALP_ApdoNoCta;"";"")
		AL_SetCallbacks (xALP_ApdoNoCta;"";"")
		AL_SetScroll (xALP_ApdoNoCta;0;-3)
		AL_SetEntryOpts (xALP_ApdoNoCta;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_ApdoNoCta;0;30;0)
		
		AL_SetLine (xALP_Rechazados;0)
		AL_SetLine (xALP_NoIdent;0)
		AL_SetLine (xALP_MasdeUno;0)
		AL_SetLine (xALP_Invalidos;0)
		AL_SetLine (xALP_ApdoNoCta;0)
		
		If (<>vtXS_CountryCode="cl")
			For ($i;1;Size of array:C274(at_rutExApdoPAC))  //da formato 
				at_rutExApdoPAC{$i}:=SR_FormatoRUT2 (at_rutExApdoPAC{$i})
			End for 
			
			For ($i;1;Size of array:C274(at_rutNoIdentificados))
				at_rutNoIdentificados{$i}:=SR_FormatoRUT2 (at_rutNoIdentificados{$i})
			End for 
			
			For ($i;1;Size of array:C274(at_rutMasDeUnaPersona))
				at_rutMasDeUnaPersona{$i}:=SR_FormatoRUT2 (at_rutMasDeUnaPersona{$i})
			End for 
			
			For ($i;1;Size of array:C274(at_rutNoApoCta))
				at_rutNoApoCta{$i}:=SR_FormatoRUT2 (at_rutNoApoCta{$i})
			End for 
			
			  //AL_SetFormat (xALP_Rechazados;1;"###.###.###-#";0;0;0;0)
			  //AL_SetFormat (xALP_NoIdent;1;"###.###.###-#";0;0;0;0)
			  //AL_SetFormat (xALP_MasdeUno;1;"###.###.###-#";0;0;0;0)
			  //AL_SetFormat (xALP_Invalidos;1;"###.###.###-#";0;0;0;0)
			  //AL_SetFormat (xALP_ApdoNoCta;1;"###.###.###-#";0;0;0;0)
		End if 
End case 
