$line:=AL_GetLine (Self:C308->)
IT_SetButtonState (($line>0);->bDelEfemeride)

If (alProEvt=-5)
	AL_GetDrgArea (Self:C308->;$destinationArea)
	AL_GetDrgDstTyp (Self:C308->;$destinationType)
	AL_GetDrgSrcRow (Self:C308->;$selectedItemLine)
	AL_GetDrgDstRow (Self:C308->;$DestRow)
	If ($selectedItemLine>0)
		If ($destinationArea=Self:C308->)
			$temp1:=aIDs{$selectedItemLine}
			$temp2:=aRelMetaDef{$selectedItemLine}
			$temp3:=aIndexMeta{$selectedItemLine}
			If ($selectedItemLine>$DestRow)
				AL_UpdateArrays (Self:C308->;0)
				AT_Delete ($selectedItemLine;1;->aIDs;->aRelMetaDef;->aIndexMeta)
				AT_Insert ($DestRow;1;->aIDs;->aRelMetaDef;->aIndexMeta)
				aIDs{$DestRow}:=$temp1
				aRelMetaDef{$DestRow}:=$temp2
				aIndexMeta{$DestRow}:=$temp3
				AL_UpdateArrays (Self:C308->;-2)
			Else 
				If ($selectedItemLine<$DestRow)
					AL_UpdateArrays (Self:C308->;0)
					AT_Insert ($DestRow+1;1;->aIDs;->aRelMetaDef;->aIndexMeta)
					aIDs{$DestRow+1}:=$temp1
					aRelMetaDef{$DestRow+1}:=$temp2
					aIndexMeta{$DestRow+1}:=$temp3
					AT_Delete ($selectedItemLine;1;->aIDs;->aRelMetaDef;->aIndexMeta)
					AL_UpdateArrays (Self:C308->;-2)
				End if 
			End if 
		End if 
	End if 
End if 