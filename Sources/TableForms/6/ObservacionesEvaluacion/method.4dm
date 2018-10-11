Spell_CheckSpelling 
Case of 
	: (Form event:C388=On Load:K2:1)
		$format:=OBJECT Get format:C894(bAddObservacion)
		$format:=Substring:C12($format;1;Length:C16($format)-3)
		$format:=$format+"0;0"
		OBJECT SET FORMAT:C236(bAddObservacion;$format)
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Alternative Click:K2:36))
		C_LONGINT:C283($sublist)
		C_TEXT:C284($itemText)
		GET LIST ITEM:C378(hl_Observaciones;*;$itemRef;$itemText;$sublist)
		$parentRef:=List item parent:C633(hl_Observaciones;$itemRef)
		$format:=OBJECT Get format:C894(bAddObservacion)
		$format:=Substring:C12($format;1;Length:C16($format)-3)
		If (($itemRef<0) | ($parentRef<0))
			$format:=$format+"2;0"
		Else 
			$format:=$format+"0;0"
		End if 
		OBJECT SET FORMAT:C236(bAddObservacion;$format)
		
	: (Form event:C388=On Close Box:K2:21)
		LIST TO BLOB:C556(hl_observaciones;[xxSTR_Niveles:6]ObservacionesEvaluacion:22)
		SAVE RECORD:C53([xxSTR_Niveles:6])
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 