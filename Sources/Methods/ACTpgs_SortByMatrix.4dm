//%attributes = {}
  //ACTpgs_SortByMatrix

ARRAY LONGINT:C221($alACT_IDItemCargo;Size of array:C274(alACT_RecNumsNormales))
ARRAY LONGINT:C221($alACT_IDCta;Size of array:C274(alACT_RecNumsNormales))
ARRAY LONGINT:C221(alACT_IDMatriz;Size of array:C274(alACT_RecNumsNormales))
ARRAY LONGINT:C221($alTempPos;Size of array:C274(alACT_RecNumsNormales))
ARRAY LONGINT:C221(aTempID;Size of array:C274(alACT_RecNumsNormales))

For ($i;1;Size of array:C274($1->))
	GOTO RECORD:C242([ACT_Cargos:173];alACT_RecNumsCargos{$1->{$i}})
	$alACT_IDItemCargo{$i}:=[ACT_Cargos:173]Ref_Item:16
	$alACT_IDCta{$i}:=[ACT_Cargos:173]ID_CuentaCorriente:2
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$alACT_IDCta{$i})
	alACT_IDMatriz{$i}:=[ACT_CuentasCorrientes:175]ID_Matriz:7
	UNLOAD RECORD:C212([ACT_Cargos:173])
	UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
End for 

AT_DistinctsArrayValues (->alACT_IDMatriz)
$p:=1
$tempID:=0
For ($i;1;Size of array:C274(alACT_IDMatriz))
	ACTcfg_loadMatrixItems (alACT_IDMatriz{$i})
	For ($j;1;Size of array:C274(alACT_IdItemMatriz))
		$tempID:=$tempID+1
		For ($k;1;Size of array:C274(alACT_RecNumsNormales))
			If ($alACT_IDItemCargo{$k}=alACT_IdItemMatriz{$j})
				$alTempPos{$p}:=$1->{$k}
				aTempID{$p}:=$tempID
				$p:=$p+1
				$alACT_IDItemCargo{$k}:=-999
			End if 
		End for 
	End for 
End for 

COPY ARRAY:C226($alTempPos;alACT_PosinArraysResto4)
AT_Initialize (->alACT_IDMatriz)
ARRAY REAL:C219(arACT_TempSaldos;Size of array:C274(alACT_PosinArraysResto4))
ARRAY DATE:C224(adACT_TempEmision;Size of array:C274(alACT_PosinArraysResto4))

For ($i;1;Size of array:C274(alACT_PosinArraysResto4))
	arACT_TempSaldos{$i}:=arACT_CSaldo{alACT_PosinArraysResto4{$i}}
	adACT_TempEmision{$i}:=adACT_CFechaEmision{alACT_PosinArraysResto4{$i}}
End for 

ARRAY POINTER:C280($apACT_SortPointers;4)
ARRAY LONGINT:C221($alACT_SortOrder;4)

$apACT_SortPointers{1}:=->adACT_TempEmision
$apACT_SortPointers{2}:=->aTempID
$apACT_SortPointers{3}:=->arACT_TempSaldos
$apACT_SortPointers{4}:=->alACT_PosinArraysResto4

$alACT_SortOrder{1}:=1
$alACT_SortOrder{2}:=1
$alACT_SortOrder{3}:=1
$alACT_SortOrder{4}:=0

MULTI SORT ARRAY:C718($apACT_SortPointers;$alACT_SortOrder)