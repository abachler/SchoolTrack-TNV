//%attributes = {}
  //ACTcc_LoadObs
C_LONGINT:C283($vl_num_tabla)
$vl_num_tabla:=Table:C252(->[ACT_CuentasCorrientes:175])
ACTobs_OpcionesObservaciones ("CargaRegistros";->$vl_num_tabla;->[ACT_CuentasCorrientes:175]ID:1)

If (Count parameters:C259=2)
	$datefrom:=Date:C102($1)
	$dateTo:=Date:C102($2)
	Case of 
		: (($datefrom#!00-00-00!) & ($dateTo#!00-00-00!))
			QUERY SELECTION:C341([ACT_Cuentas_Observaciones:102];[ACT_Cuentas_Observaciones:102]Fecha:3>=$datefrom;*)
			QUERY SELECTION:C341([ACT_Cuentas_Observaciones:102]; & ;[ACT_Cuentas_Observaciones:102]Fecha:3<=$dateTo)
		: (($datefrom=!00-00-00!) & ($dateTo#!00-00-00!))
			QUERY SELECTION:C341([ACT_Cuentas_Observaciones:102];[ACT_Cuentas_Observaciones:102]Fecha:3<=$dateTo)
		: (($datefrom#!00-00-00!) & ($dateTo=!00-00-00!))
			QUERY SELECTION:C341([ACT_Cuentas_Observaciones:102];[ACT_Cuentas_Observaciones:102]Fecha:3>=$datefrom)
	End case 
End if 
ARRAY LONGINT:C221(alACT_IDObs;0)
ARRAY TEXT:C222(atACT_Observacion;0)
ARRAY DATE:C224(adACT_FechaObs;0)
SELECTION TO ARRAY:C260([ACT_Cuentas_Observaciones:102]ID:1;alACT_IDObs;[ACT_Cuentas_Observaciones:102]Observacion:4;atACT_Observacion;[ACT_Cuentas_Observaciones:102]Fecha:3;adACT_FechaObs)
SORT ARRAY:C229(adACT_FechaObs;atACT_Observacion;alACT_IDObs;<)
_O_DISABLE BUTTON:C193(bDelObs)