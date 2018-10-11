Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_TEXT:C284($fieldName)
		GET LIST ITEM:C378(hl_Campos;*;vl_LastMetaDataRecNum;$fieldName)
		KRL_GotoRecord (->[xxSTR_MetadatosLocales:141];vl_LastMetaDataRecNum;True:C214)
		MDATA_ObjectHandler 
		
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($vpSrcObj;$vlSrcElem;$vlPID)
		$vlDstElem:=Drop position:C608
		If ($vlDstElem#$vlSrcElem)
			GET LIST ITEM:C378(Self:C308->;$vlSrcElem;$itemRef;$itemText)
			DELETE FROM LIST:C624(Self:C308->;$itemRef)
			If ($vlDstElem=-1)
				APPEND TO LIST:C376(Self:C308->;$itemText;$itemRef)
				$vlDstElem:=Count list items:C380(Self:C308->)
			Else 
				SELECT LIST ITEMS BY POSITION:C381(Self:C308->;$vlDstElem)
				INSERT IN LIST:C625(Self:C308->;*;$itemText;$itemRef)
			End if 
			_O_REDRAW LIST:C382(Self:C308->)
			
			For ($i;1;Count list items:C380(Self:C308->))
				GET LIST ITEM:C378(hl_Campos;$i;$itemRef;$fieldName)
				KRL_GotoRecord (->[xxSTR_MetadatosLocales:141];$itemRef;True:C214)
				If (OK=1)
					[xxSTR_MetadatosLocales:141]Orden:11:=$i
					SAVE RECORD:C53([xxSTR_MetadatosLocales:141])
				End if 
			End for 
			
			SELECT LIST ITEMS BY POSITION:C381(Self:C308->;$vlDstElem)
			GET LIST ITEM:C378(hl_Campos;$i;$itemRef;$fieldName)
			KRL_GotoRecord (->[xxSTR_MetadatosLocales:141];$itemRef;True:C214)
			MDATA_ObjectHandler 
			
		End if 
End case 


