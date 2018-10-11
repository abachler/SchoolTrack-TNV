viACT_cuentas5:=0
Case of 
	: (f1=1)
		viACT_cuentas4:=viACT_cuentas1
		OBJECT SET COLOR:C271(viACT_cuentas4;-3)
		OBJECT SET COLOR:C271(viACT_cuentas5;-12)
	: (f2=1)
		viACT_cuentas4:=viACT_cuentas2
		OBJECT SET COLOR:C271(viACT_cuentas4;-3)
		OBJECT SET COLOR:C271(viACT_cuentas5;-12)
	: (f3=1)
		viACT_cuentas4:=viACT_cuentas3
		OBJECT SET COLOR:C271(viACT_cuentas4;-3)
		OBJECT SET COLOR:C271(viACT_cuentas5;-12)
End case 
_O_DISABLE BUTTON:C193(bMatrizaReemplazar)
OBJECT SET COLOR:C271(*;"Reemplazo@";-61966)
If ((viACT_cuentas4=0) & (r1=1))
	_O_DISABLE BUTTON:C193(bNext)
Else 
	_O_ENABLE BUTTON:C192(bNext)
End if 