AL_UpdateArrays (xALP_RecordData;0)

If (viIOstr_PlatFormSource=3)
	USE CHARACTER SET:C205("windows-1252";1)
Else 
	USE CHARACTER SET:C205("MacRoman";1)
End if 

$ref:=Open document:C264(document)
RECEIVE PACKET:C104($ref;$Header;"\r")
RECEIVE PACKET:C104($ref;$text;"\r")
CLOSE DOCUMENT:C267($ref)
ARRAY TEXT:C222(aRecordLine;0)
ARRAY LONGINT:C221(aRecordLineElement;0)
ARRAY TEXT:C222(aText1;0)
AT_Text2Array (->aRecordLine;$header;"\t")
AT_Text2Array (->aText1;$text;"\t")
TRACE:C157
ARRAY TEXT:C222(aText1;Size of array:C274(aRecordLine))
ARRAY LONGINT:C221(aRecordLineElement;Size of array:C274(aRecordLine))
For ($i;1;Size of array:C274(aRecordLine))
	aRecordLine{$i}:=aRecordLine{$i}+":"+aText1{$i}
	aRecordLineElement{$i}:=$i
End for 


For ($i;Size of array:C274(aRecordLine);1;-1)
	If (aRecordLine{$i}=":")
		DELETE FROM ARRAY:C228(aRecordLineElement;$i)
		DELETE FROM ARRAY:C228(aRecordLine;$i)
	End if 
End for 

COPY ARRAY:C226(aRecordLine;aRecordHeader)
For ($i;Size of array:C274(aRecordLine);1;-1)
	aRecordHeader{$i}:=Substring:C12(aRecordHeader{$i};1;Position:C15(":";aRecordHeader{$i})-1)
End for 
For ($i;Size of array:C274(aRecordFieldNames);1;-1)
	$el:=Find in array:C230(aRecordHeader;aRecordFieldNames{$i})
	If ($el>0)
		aSourceDataName{$i}:=aRecordLine{$el}
		aSourceDataElement{$i}:=aRecordLineElement{$el}
	End if 
End for 


AL_UpdateArrays (xALP_RecordData;Size of array:C274(aRecordLine))

OK:=1
If (ok=1)
	vL_RecordLine:=2
	If (vL_RecordLine=2)
		_O_DISABLE BUTTON:C193(bPreviousLine)
	End if 
	FORM NEXT PAGE:C248
End if 

vi_PageNumber:=FORM Get current page:C276+1

