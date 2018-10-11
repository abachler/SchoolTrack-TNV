$go:=True:C214
If (bc_SetProgTask=1)
	If (vdDate=Current date:C33(*))
		$timeStr:=String:C10(vHrs)+":"+String:C10(vMinutes)+":00"
		$time:=Time:C179($timeStr)
		If ($time<Current time:C178(*))
			CD_Dlog (0;__ ("No puede programar la emisión para una hora anterior a la actual."))
			vHrs:=TM_Get_Hours (Current time:C178(*))
			vMinutes:=TM_Get_Minutes (Current time:C178(*))
			$go:=False:C215
		End if 
	End if 
End if 
If ($go)
	If (vdACT_FechaAviso+viACT_DiaVencimiento<Current date:C33(*))
		$r:=CD_Dlog (0;__ ("De acuerdo con su configuración, algunos avisos se emitirán vencidos.");__ ("");__ ("Cambiar día de emisión");__ ("Continuar");__ ("Cancelar"))
		Case of 
			: ($r=1)
				vi_PageNumber:=3
				FORM GOTO PAGE:C247(vi_PageNumber)
				POST KEY:C465(Character code:C91("+");256)
				GOTO OBJECT:C206(vdACT_DiaAviso)
			: ($r=2)
				If ((b1=1) & (bc_SetProgTask=1))
					$s:=CD_Dlog (0;__ ("Sólo se puede programar la emisión de avisos de cobranza.\rLa impresión deberá ser realizada posteriormente en forma manual.");__ ("");__ ("Proseguir");__ ("Cancelar"))
					If ($s=1)
						b1:=0
						b2:=1
						ACCEPT:C269
					Else 
						CANCEL:C270
					End if 
				Else 
					ACCEPT:C269
				End if 
			: ($r=3)
				CANCEL:C270
		End case 
	Else 
		If ((b1=1) & (bc_SetProgTask=1))
			$s:=CD_Dlog (0;__ ("Sólo se puede programar la emisión de avisos de cobranza.\rLa impresión deberá ser realizada posteriormente en forma manual.");__ ("");__ ("Proseguir");__ ("Cancelar"))
			If ($s=1)
				b1:=0
				b2:=1
				ACCEPT:C269
			Else 
				CANCEL:C270
			End if 
		Else 
			ACCEPT:C269
		End if 
	End if 
End if 