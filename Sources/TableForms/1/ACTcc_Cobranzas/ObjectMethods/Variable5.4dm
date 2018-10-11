Case of 
	: (vi_PageNumber=1)
		vi_PageNumber:=2
	: (vi_PageNumber=2)
		If ((b1=1) | (b2=1))
			vi_PageNumber:=3
		Else 
			vi_PageNumber:=4
		End if 
	: (vi_PageNumber=3)
		$vb_continue:=True:C214
		Case of 
			: ((vdACT_DiaAviso>31) | (vdACT_DiaAviso<1) | (vdACT_DiaVctoAviso>31) | (vdACT_DiaVctoAviso<1))
				BEEP:C151
				If ((vdACT_DiaAviso>31) | (vdACT_DiaAviso<1))
					GOTO OBJECT:C206(vdACT_DiaAviso)
				Else 
					GOTO OBJECT:C206(vdACT_DiaVctoAviso)
				End if 
				$vb_continue:=False:C215
				
			: ((vdACT_AñoAviso)<(Year of:C25(Current date:C33(*))-2))
				$resp:=CD_Dlog (0;__ ("Está emitiendo avisos de cobranza desde el año ")+String:C10(vdACT_AñoAviso)+__ (".\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
				If ($resp=2)
					GOTO OBJECT:C206(vdACT_AñoAviso)
					$vb_continue:=False:C215
				Else 
					If ((vdACT_AñoAviso2)>(Year of:C25(Current date:C33(*))+2))
						$resp:=CD_Dlog (0;__ ("Está emitiendo avisos de cobranza hasta el año ")+String:C10(vdACT_AñoAviso2)+__ (".\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
						If ($resp=2)
							GOTO OBJECT:C206(vdACT_AñoAviso2)
							$vb_continue:=False:C215
						Else 
							vi_PageNumber:=5
						End if 
					Else 
						vi_PageNumber:=5
					End if 
				End if 
				
			: ((vdACT_AñoAviso2)>(Year of:C25(Current date:C33(*))+2))
				$resp:=CD_Dlog (0;__ ("Está emitiendo avisos de cobranza hasta el año ")+String:C10(vdACT_AñoAviso2)+__ (".\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
				If ($resp=2)
					GOTO OBJECT:C206(vdACT_AñoAviso2)
					$vb_continue:=False:C215
				Else 
					vi_PageNumber:=5
				End if 
				
			Else 
				vi_PageNumber:=5
		End case 
		If ($vb_continue)
			If ((b1=1) | (b3=1))
				vi_PageNumber:=4
			End if 
		End if 
		
		
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
					$t_msj:=__ ("El periodo ^0, se encuentra bloqueado.";$at_cerrados{1})+".\r\r"+__ ("No se generará aviso de cobranza para este periodo.")
				Else 
					$t_periodos:=AT_array2text (->$at_cerrados;"; ")
					$t_msj:=__ ("Los periodos: ^0, se encuentran bloqueados.";$t_periodos)+".\r\r"+__ ("No se generarán avisos de cobranza para estos periodos.")
				End if 
				CD_Dlog (0;$t_msj)
			End if 
		End if 
		
		
	: (vi_PageNumber=4)
		vi_PageNumber:=5
	: (vi_PageNumber=5)
		If (f3=1)
			$resp:=CD_Dlog (0;__ ("Se emitirán avisos de cobranza para todas las cuentas activas. ¿Desea Continuar?");__ ("");__ ("No");__ ("Si"))
			If ($resp=2)
				vi_PageNumber:=6
			Else 
				vi_PageNumber:=5
			End if 
		Else 
			vi_PageNumber:=6
		End if 
End case 
OBJECT SET ENABLED:C1123(bNext;True:C214)

FORM GOTO PAGE:C247(vi_PageNumber)
POST KEY:C465(Character code:C91("+");256)