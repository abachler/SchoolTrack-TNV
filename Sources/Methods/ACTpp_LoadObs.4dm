//%attributes = {}
  //ACTpp_LoadObs
C_LONGINT:C283($vl_num_tabla)
$vl_num_tabla:=Table:C252(->[Personas:7])
ACTobs_OpcionesObservaciones ("CargaRegistros";->$vl_num_tabla;->[Personas:7]No:1)

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
ARRAY LONGINT:C221(alACT_IDObsApdo;0)
ARRAY TEXT:C222(atACT_ObservacionApdo;0)
ARRAY DATE:C224(adACT_FechaObsApdo;0)
SELECTION TO ARRAY:C260([ACT_Cuentas_Observaciones:102]ID:1;alACT_IDObsApdo;[ACT_Cuentas_Observaciones:102]Observacion:4;atACT_ObservacionApdo;[ACT_Cuentas_Observaciones:102]Fecha:3;adACT_FechaObsApdo)
SORT ARRAY:C229(adACT_FechaObsApdo;atACT_ObservacionApdo;alACT_IDObsApdo;<)
_O_DISABLE BUTTON:C193(bDelObs)