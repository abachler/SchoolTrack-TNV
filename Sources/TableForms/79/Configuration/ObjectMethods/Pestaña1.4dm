ADTcfg_LoadMetaDataDef (Selected list items:C379(Self:C308->))
If (Selected list items:C379(vl_TabMetaDatos)=1)
	If (Not:C34(Is compiled mode:C492))
		_O_ENABLE BUTTON:C192(bAddMetaData)
	Else 
		_O_DISABLE BUTTON:C193(bAddMetaData)
	End if 
Else 
	_O_ENABLE BUTTON:C192(bAddMetaData)
End if 