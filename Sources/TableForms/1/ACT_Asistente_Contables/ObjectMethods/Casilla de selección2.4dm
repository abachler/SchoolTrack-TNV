If ((cbFacturacion=1) | (cbRecaudacion=1))
	_O_ENABLE BUTTON:C192(bNext)
Else 
	_O_DISABLE BUTTON:C193(bNext)
End if 
IT_SetButtonState ((Self:C308->=1);->ro1;->ro2;->ro3;->cbResumidoR)