C_POINTER:C301($srcObject)
C_LONGINT:C283($srcElement;$srcProcess)

Case of 
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Selection Change:K2:29))
		If (bSeleccionarTodas=1)
			For ($i;1;Size of array:C274(lb_asignaturasArea))
				lb_asignaturasArea{$i}:=True:C214
			End for 
		End if 
		
		If ((Find in array:C230(lb_AsignaturasArea;True:C214)>0) & ((r1_SoloSinAsignaciones*1)+(r2_CompletarAsignaciones*2)+(r3_ReemplazarNoEvaluadas*3)+(r4_ReemplazarEvaluadas*4)>0))
			_O_ENABLE BUTTON:C192(bAsign)
		Else 
			_O_DISABLE BUTTON:C193(bAsign)
		End if 
End case 