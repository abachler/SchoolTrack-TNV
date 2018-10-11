//%attributes = {}
  //ACTvr_RecalcularVenta

vrACT_MontoExento:=0
vrACT_TotalAfecto:=0
For ($i;1;Size of array:C274(alACT_IDVVR))
	If (abACT_AfectoIVAVVR{$i})
		vrACT_TotalAfecto:=vrACT_TotalAfecto+arACT_TotalVVR{$i}
	Else 
		vrACT_MontoExento:=vrACT_MontoExento+arACT_TotalVVR{$i}
	End if 
End for 
vrACT_MontoAfecto:=Round:C94((vrACT_TotalAfecto/<>vrACT_FactorIVA);0)
vrACT_MontoIVA:=vrACT_TotalAfecto-vrACT_MontoAfecto
vrACT_MontoAPagar:=vrACT_MontoExento+vrACT_MontoAfecto+vrACT_MontoIVA
vrACT_MontoPago:=vrACT_MontoAPagar
IT_SetButtonState ((vrACT_MontoPago>0);->bFormasdePago;->bIngresarPago)