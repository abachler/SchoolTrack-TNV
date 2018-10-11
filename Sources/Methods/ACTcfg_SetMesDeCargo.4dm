//%attributes = {}
  //ACTcfg_SetMesDeCargo

If (Not:C34([xxACT_Items:179]VentaRapida:3))
	$pointer:=$1
	RESOLVE POINTER:C394($pointer;$varName;$table;$field)
	$month:=Num:C11(Substring:C12($varName;5))
	ACTcfg_OpcionesItems ("AsignaMes";->$month)
Else 
	[xxACT_Items:179]Meses_de_cargo:9:=0
	ACTcfg_OpcionesItems ("ColoreaMeses")
	ACTcfg_OpcionesItems ("MuestraAlerta")
End if 