//%attributes = {}
  //PPsq_ApdosConDeuda

If (vsBWR_CurrentModule="AccountTrack")
	$procID:=IT_UThermometer (1;0;__ ("Buscando apoderados con deuda..."))
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Saldo_Ejercicio:21#0)
	ACT_relacionaCtasyApdos (1)
	IT_UThermometer (-2;$procID)
Else 
	CD_Dlog (0;__ ("Esta búsqueda sólo puede realizarse en el módulo AccountTrack."))
End if 