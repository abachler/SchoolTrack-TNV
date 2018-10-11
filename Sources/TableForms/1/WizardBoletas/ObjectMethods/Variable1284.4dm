$row:=AL_GetLine (xALP_wizDocTrib)
If ($row>0)
	AL_UpdateArrays (xALP_WizDocTrib;0)
	If (alACT_WDTRecNums{$row}>-1)
		AT_Insert (1;1;->alACT_WDTEliminar)
		alACT_WDTEliminar{1}:=alACT_WDTRecNums{$row}
	End if 
	AT_Delete ($row;1;->alACT_WDTNumero;->atACT_WDTApdo;->atACT_WDTEstado;->adACT_WDTFecha;->arACT_WDTAfecto;->arACT_WDTIVA;->arACT_WDTTotal;->abACT_WDTNulas;->alACT_WDTRecNums;->asACT_WDT_Duplis;->asACT_WDT_Dates;->asACT_WDT_Sincro;->abACT_WDTModificada)
	modbol:=True:C214
	If (Size of array:C274(alACT_WDTNumero)>0)
		ACTbol_WDTAnalize 
	End if 
	_O_DISABLE BUTTON:C193(bDelWBol)
	_O_DISABLE BUTTON:C193(bAnular)
End if 