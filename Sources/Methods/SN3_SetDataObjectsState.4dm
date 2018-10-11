//%attributes = {}
  //SN3_SetDataObjectsState

If (vlSN3_CurrDataType>=10000)
	$found:=Find in array:C230(aDataRefs;vlSN3_CurrDataType)
	If (cb_PublicarDato=1)
		_O_ENABLE BUTTON:C192(*;aObjectNames{$found}+"@")
	Else 
		  //SN3_SetDataObjectsState
		
		If (vlSN3_CurrDataType>=10000)
			$found:=Find in array:C230(aDataRefs;vlSN3_CurrDataType)
			If (cb_PublicarDato=1)
				_O_ENABLE BUTTON:C192(*;aObjectNames{$found}+"@")
			Else 
				_O_DISABLE BUTTON:C193(*;aObjectNames{$found}+"@")
			End if 
		End if 
		SN3_SetPubInterfaceObjects 
		
	End if 
End if 
SN3_SetPubInterfaceObjects 

