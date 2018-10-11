Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		$Fechafecha:=DT_PopCalendar 
		If (OK=1)
			If ($Fechafecha<=Current date:C33(*))
				$r:=DateIsValid ($Fechafecha)
				If (Not:C34($r))
					dDate:=!00-00-00!
					GOTO OBJECT:C206(dDate)
				Else 
					dDate:=$Fechafecha
				End if 
			Else 
				Self:C308->:=!00-00-00!
				dTo:=dFrom
				$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar una anotación anticipadamente."))
			End if 
			
			If ((<>aCursos{0}="") | (dDate=!00-00-00!))
				OBJECT SET ENTERABLE:C238(sName;False:C215)
			Else 
				OBJECT SET ENTERABLE:C238(sName;True:C214)
			End if 
		End if 
		
		
	: (Form event:C388=On Data Change:K2:15)
		$b_fechaEsValida:=DateIsValid (Self:C308->)
		If (dDate<=Current date:C33(*))
			If (Not:C34($b_fechaEsValida))
				Self:C308->:=!00-00-00!
				GOTO OBJECT:C206(Self:C308->)
			End if 
		Else 
			Self:C308->:=!00-00-00!
			GOTO OBJECT:C206(Self:C308->)
			HIGHLIGHT TEXT:C210(Self:C308->;1;80)
			$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar una anotación anticipadamente."))
		End if 
End case 