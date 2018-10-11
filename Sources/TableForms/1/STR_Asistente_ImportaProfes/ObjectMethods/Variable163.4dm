vL_RecordLine:=vL_RecordLine+1

AL_UpdateArrays (xALP_RecordData;0)
$ref:=Open document:C264(document)
RECEIVE PACKET:C104($ref;$Header;"\r")
For ($i;1;vL_RecordLine)
	RECEIVE PACKET:C104($ref;$text;"\r")
End for 
CLOSE DOCUMENT:C267($ref)
ARRAY TEXT:C222(aRecordLine;0)
ARRAY LONGINT:C221(aRecordLineElement;0)
ARRAY TEXT:C222(aText1;0)
AT_Text2Array (->aRecordLine;$header;"\t")
AT_Text2Array (->aText1;$text;"\t")

ARRAY TEXT:C222(aText1;Size of array:C274(aRecordLine))
ARRAY LONGINT:C221(aRecordLineElement;Size of array:C274(aRecordLine))
For ($i;1;Size of array:C274(aRecordLine))
	If (viIOstr_PlatFormSource=3)
		aRecordLine{$i}:=ST_ConvertText (ST_GetCleanString (aRecordLine{$i}+":"+aText1{$i});"Win";"Mac")
	Else 
		aRecordLine{$i}:=aRecordLine{$i}+":"+aText1{$i}
	End if 
	aRecordLineElement{$i}:=$i
End for 


For ($i;Size of array:C274(aRecordLine);1;-1)
	If (aRecordLine{$i}=":")
		DELETE FROM ARRAY:C228(aRecordLineElement;$i)
		DELETE FROM ARRAY:C228(aRecordLine;$i)
	End if 
End for 
AL_UpdateArrays (xALP_RecordData;Size of array:C274(aRecordLine))

If (vl_recordLine=2)
	_O_DISABLE BUTTON:C193(bPreviousLine)
Else 
	_O_ENABLE BUTTON:C192(bPreviousLine)
End if 

vt_recordNum:="Registro N° "+String:C10(vL_RecordLine-1)