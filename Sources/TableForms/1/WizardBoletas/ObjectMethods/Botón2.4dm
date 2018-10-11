$proc:=IT_UThermometer (1;0;__ ("Rellenando vacíos en la numeración...");-1)
$p:=0
While ($p<=(Size of array:C274(alACT_WDTNumero)-2))
	$p:=$p+1
	If (alACT_WDTNumero{$p}#(alACT_WDTNumero{$p+1}-1))
		If (alACT_WDTNumero{$p}#alACT_WDTNumero{$p+1})
			modbol:=True:C214
			AT_Insert ($p+1;1;->alACT_WDTNumero;->atACT_WDTApdo;->atACT_WDTEstado;->adACT_WDTFecha;->arACT_WDTAfecto;->arACT_WDTIVA;->arACT_WDTTotal;->abACT_WDTNulas;->alACT_WDTRecNums;->asACT_WDT_Duplis;->asACT_WDT_Dates;->asACT_WDT_Sincro;->abACT_WDTModificada)
			alACT_WDTNumero{$p+1}:=alACT_WDTNumero{$p}+1
			atACT_WDTApdo{$p+1}:=""
			atACT_WDTEstado{$p+1}:="Nula"
			adACT_WDTFecha{$p+1}:=adACT_WDTFecha{$p}
			arACT_WDTAfecto{$p+1}:=0
			arACT_WDTIVA{$p+1}:=0
			arACT_WDTTotal{$p+1}:=0
			abACT_WDTNulas{$p+1}:=True:C214
			alACT_WDTRecNums{$p+1}:=MAXLONG:K35:2*-1
			asACT_WDT_Duplis{$p+1}:=""
			asACT_WDT_Dates{$p+1}:=""
			asACT_WDT_Sincro{$p+1}:=""
			$p:=$p-1
		End if 
	End if 
End while 
IT_UThermometer (-2;$proc)
ACTbol_WDTAnalize 