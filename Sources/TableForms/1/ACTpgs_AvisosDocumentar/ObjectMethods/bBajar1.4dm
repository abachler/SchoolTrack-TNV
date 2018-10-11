AL_UpdateArrays (ALP_CargosXPagar;0)
$temp0:=alACT_CIdsAvisos{line}
$temp1:=adACT_CFechaEmision{line}
$temp2:=adACT_CFechaVencimiento{line}
$temp3:=atACT_CAlumno{line}
$temp4:=atACT_CGlosa{line}
$temp5:=arACT_CMontoNeto{line}
$temp6:=arACT_CIntereses{line}
$temp7:=arACT_CSaldo{line}
$temp8:=alACT_RecNumsCargos{line}
$temp9:=alACT_CRefs{line}
$temp10:=alACT_CIDCtaCte{line}
$temp11:=asACT_Marcas{line}
$temp12:=arACT_MontoMoneda{line}
$temp13:=atACT_MonedaCargo{line}
$temp14:=atACT_MonedaSimbolo{line}
$temp16:=arACT_MontoPagado{line}
$temp17:=alACT_CIdsCargos{line}
$temp18:=alACT_CIdDctoCargo{line}
$temp19:=arACT_MontoIVA{line}
$temp20:=arACT_CMontoAfecto{line}
$temp21:=alACT_CidCargoGenInt{line}

alACT_CIdsAvisos{line}:=alACT_CIdsAvisos{line+1}
adACT_CFechaEmision{line}:=adACT_CFechaEmision{line+1}
adACT_CFechaVencimiento{line}:=adACT_CFechaVencimiento{line+1}
atACT_CAlumno{line}:=atACT_CAlumno{line+1}
atACT_CGlosa{line}:=atACT_CGlosa{line+1}
arACT_CMontoNeto{line}:=arACT_CMontoNeto{line+1}
arACT_CIntereses{line}:=arACT_CIntereses{line+1}
arACT_CSaldo{line}:=arACT_CSaldo{line+1}
alACT_RecNumsCargos{line}:=alACT_RecNumsCargos{line+1}
alACT_CRefs{line}:=alACT_CRefs{line+1}
alACT_CIDCtaCte{line}:=alACT_CIDCtaCte{line+1}
asACT_Marcas{line}:=asACT_Marcas{line+1}
arACT_MontoMoneda{line}:=arACT_MontoMoneda{line+1}
atACT_MonedaCargo{line}:=atACT_MonedaCargo{line+1}
atACT_MonedaSimbolo{line}:=atACT_MonedaSimbolo{line+1}
arACT_MontoPagado{line}:=arACT_MontoPagado{line+1}
alACT_CIdsCargos{line}:=alACT_CIdsCargos{line+1}
alACT_CIdDctoCargo{line}:=alACT_CIdDctoCargo{line+1}
arACT_MontoIVA{line}:=arACT_MontoIVA{line+1}
arACT_CMontoAfecto{line}:=arACT_CMontoAfecto{line+1}
alACT_CidCargoGenInt{line}:=alACT_CidCargoGenInt{line+1}

alACT_CIdsAvisos{line+1}:=$temp0
adACT_CFechaEmision{line+1}:=$temp1
adACT_CFechaVencimiento{line+1}:=$temp2
atACT_CAlumno{line+1}:=$temp3
atACT_CGlosa{line+1}:=$temp4
arACT_CMontoNeto{line+1}:=$temp5
arACT_CIntereses{line+1}:=$temp6
arACT_CSaldo{line+1}:=$temp7
alACT_RecNumsCargos{line+1}:=$temp8
alACT_CRefs{line+1}:=$temp9
alACT_CIDCtaCte{line+1}:=$temp10
asACT_Marcas{line+1}:=$temp11
arACT_MontoMoneda{line+1}:=$temp12
atACT_MonedaCargo{line+1}:=$temp13
atACT_MonedaSimbolo{line+1}:=$temp14
arACT_MontoPagado{line+1}:=$temp16
alACT_CIdsCargos{line+1}:=$temp17
alACT_CIdDctoCargo{line+1}:=$temp18
arACT_MontoIVA{line+1}:=$temp19
arACT_CMontoAfecto{line+1}:=$temp20
alACT_CidCargoGenInt{line+1}:=$temp21
AL_UpdateArrays (ALP_CargosXPagar;-2)
AL_SetLine (ALP_CargosXPagar;line+1)
line:=AL_GetLine (ALP_CargosXPagar)
If ((line=0) | (line=1))
	_O_DISABLE BUTTON:C193(bSubirC)
Else 
	_O_ENABLE BUTTON:C192(bSubirC)
End if 
If ((line=0) | (line=Size of array:C274(adACT_CFechaEmision)))
	_O_DISABLE BUTTON:C193(bBajarC)
Else 
	_O_ENABLE BUTTON:C192(bBajarC)
End if 
ACTpgs_OrdenaCargosAviso (vl_lineaAviso)