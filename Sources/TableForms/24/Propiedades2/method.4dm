Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY INTEGER:C220(ai_YearDC;0)
		_O_ARRAY STRING:C218(31;as_NombreYearDC;0)
		ARRAY DATE:C224(ad_InicioDC;0)
		ARRAY DATE:C224(ad_TerminoDC;0)
		ARRAY LONGINT:C221(al_RecNumDC;0)
		ARRAY BOOLEAN:C223(ab_ModificadoDC;0)
		
		SELECTION TO ARRAY:C260([xxSTR_DatosDeCierre:24]Year:1;ai_YearDC;[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5;as_NombreYearDC;[xxSTR_DatosDeCierre:24]FechaInicio:6;ad_InicioDC;[xxSTR_DatosDeCierre:24]FechaTermino:7;ad_TerminoDC)
		LONGINT ARRAY FROM SELECTION:C647([xxSTR_DatosDeCierre:24];al_RecNumDC)
		
		ARRAY BOOLEAN:C223(ab_ModificadoDC;Size of array:C274(ai_YearDC))
	: (Form event:C388=On Close Box:K2:21)
		If (Find in array:C230(ab_ModificadoDC;True:C214)#-1)
			$r:=CD_Dlog (0;__ ("Usted ha realizado modificaciones. ¿Desea guardarlas?");"";__ ("Si");__ ("No"))
			If ($r=1)
				ACCEPT:C269
			Else 
				CANCEL:C270
			End if 
		Else 
			CANCEL:C270
		End if 
End case 