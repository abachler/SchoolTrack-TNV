$row:=AL_GetLine (xALP_WizDocTrib)
If ($row>0)
	If (abACT_WDTNulas{$row}=False:C215)
		abACT_WDTNulas{$row}:=True:C214
		atACT_WDTEstado{$row}:="Nula"
		AT_Insert (1;1;->alACT_WDTAnular)
		alACT_WDTAnular{1}:=alACT_WDTRecNums{$row}
		ACTbol_WDTAnalize 
		_O_DISABLE BUTTON:C193(bAnular)
		_O_DISABLE BUTTON:C193(bDelWBol)
		modBol:=True:C214
	End if 
End if 