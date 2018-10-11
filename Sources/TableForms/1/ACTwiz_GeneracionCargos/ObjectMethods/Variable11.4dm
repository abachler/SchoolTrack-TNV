Case of 
	: (vi_PageNumber=1)
		vi_PageNumber:=2
	: (vi_PageNumber=2)
		Case of 
			: (b1=1)
				vi_PageNumber:=5
			: (b2=1)
				vi_PageNumber:=3
			: (b3=1)
				vi_PageNumber:=4
		End case 
	: (vi_PageNumber=3)
		If (vsACT_SelectedItemName="")
			CD_Dlog (0;__ ("Por favor seleccione el item del cargo que desea generar."))
		Else 
			vi_PageNumber:=5
		End if 
	: (vi_PageNumber=4)
		Case of 
			: (vsACT_Glosa="")
				CD_Dlog (0;__ ("Por favor indique una glosa para el cargo a generar."))
			: (vrACT_monto=0)
				CD_Dlog (0;__ ("Por favor indique el monto del cargo a generar."))
			Else 
				vi_PageNumber:=5
		End case 
	: (vi_PageNumber=5)
		Case of 
			: (vs1="")
				CD_Dlog (0;__ ("Por favor indique el período para el cargo a generar."))
			: (viACT_DiaGeneracion=0)
				CD_Dlog (0;__ ("Por favor indique el el día para la fecha de generación."))
				  //: (viACT_DiaVencimiento2=0)
				  //cd_Dlog (0;"Por favor indique el el día para la fecha de vencimiento.")
			: ((vdACT_AñoAviso)<(Year of:C25(Current date:C33(*))-2))
				$resp:=CD_Dlog (0;__ ("Está generando cargos desde el año ")+String:C10(vdACT_AñoAviso)+__ (".\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
				If ($resp=2)
					GOTO OBJECT:C206(vdACT_AñoAviso)
				Else 
					If ((vdACT_AñoAviso2)>(Year of:C25(Current date:C33(*))+2))
						$resp:=CD_Dlog (0;__ ("Está generando cargos hasta el año ")+String:C10(vdACT_AñoAviso2)+__ (".\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
						If ($resp=2)
							GOTO OBJECT:C206(vdACT_AñoAviso2)
						Else 
							vi_PageNumber:=6
						End if 
					Else 
						vi_PageNumber:=6
					End if 
				End if 
			: ((vdACT_AñoAviso2)>(Year of:C25(Current date:C33(*))+2))
				$resp:=CD_Dlog (0;__ ("Está generando cargos hasta el año ")+String:C10(vdACT_AñoAviso2)+__ (".\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
				If ($resp=2)
					GOTO OBJECT:C206(vdACT_AñoAviso2)
				Else 
					vi_PageNumber:=6
				End if 
				
			Else 
				vi_PageNumber:=6
		End case 
		
		  // Modificado por: Saul Ponce (05-09-2018) Ticket Nº 216060, Notificar al usuario sobre los periodos cerrados 
		C_TEXT:C284($t_msj)
		C_OBJECT:C1216($ob_lockedMonth)
		$ob_lockedMonth:=ACT_verificaPeriodo ("verificaLapso";->vs1;->vdACT_AñoAviso;->vs2;->vdACT_AñoAviso2)  // valida meses cerrados
		$t_msj:=OB Get:C1224($ob_lockedMonth;"mensaje")
		If (Not:C34(Num:C11($t_msj)=0))
			C_TEXT:C284($t_periodos)
			ARRAY TEXT:C222($at_cerrados;0)
			OB GET ARRAY:C1229($ob_lockedMonth;"periodos";$at_cerrados)
			If (Size of array:C274($at_cerrados)>0)
				If (Size of array:C274($at_cerrados)=1)
					$t_msj:=__ ("El periodo ^0, se encuentra bloqueado.";$at_cerrados{1})+".\r\r"+__ ("No se emitirán cargos para este periodo.")
				Else 
					$t_periodos:=AT_array2text (->$at_cerrados;"; ")
					$t_msj:=__ ("Los periodos: ^0, se encuentran bloqueados.";$t_periodos)+".\r\r"+__ ("No se emitirán cargos para estos periodos.")
				End if 
				CD_Dlog (0;$t_msj)
			End if 
		End if 
		
		
	: (vi_PageNumber=6)
		If (f3=1)
			$resp:=CD_Dlog (0;__ ("Se generarán cargos para todas las cuentas activas. ¿Desea Continuar?");__ ("");__ ("No");__ ("Si"))
			If ($resp=2)
				vi_PageNumber:=7
			Else 
				vi_PageNumber:=6
			End if 
		Else 
			vi_PageNumber:=7
		End if 
End case 
_O_ENABLE BUTTON:C192(bPrev)
FORM GOTO PAGE:C247(vi_PageNumber)
POST KEY:C465(Character code:C91("+");256)