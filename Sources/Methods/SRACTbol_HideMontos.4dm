//%attributes = {}
  //SRACTbol_HideMontos

$r:=SR Get Object Properties (SRArea;SRObjectPrintRef;$objectName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
If ($objectName="vrACT_PagadoCargo@")
	$ObjectNum:=String:C10(Num:C11($objectName))
	$hider:=Get pointer:C304("vbACT_HideMonto"+$ObjectNum)
	If (Not:C34($hider->))
		SR_SetObjectColor ("white")
	End if 
Else 
	Case of 
		: ($objectName="vTotal@")
			$ObjectNum:=String:C10(Num:C11($objectName))
			$hider:=Get pointer:C304("vbACT_HideTotal"+$ObjectNum)
			If (Not:C34($hider->))
				SR_SetObjectColor ("white")
			End if 
		: ($objectName="vNeto@")
			$ObjectNum:=String:C10(Num:C11($objectName))
			$hider:=Get pointer:C304("vbACT_HideNeto"+$ObjectNum)
			If (Not:C34($hider->))
				SR_SetObjectColor ("white")
			End if 
		: ($objectName="vporcentajeIVA@")
			$ObjectNum:=String:C10(Num:C11($objectName))
			$hider:=Get pointer:C304("vbACT_HidePorcIVA"+$ObjectNum)
			If (Not:C34($hider->))
				SR_SetObjectColor ("white")
			End if 
		: ($objectName="vIVA@")
			$ObjectNum:=String:C10(Num:C11($objectName))
			$hider:=Get pointer:C304("vbACT_HideIVA"+$ObjectNum)
			If (Not:C34($hider->))
				SR_SetObjectColor ("white")
			End if 
	End case 
End if 