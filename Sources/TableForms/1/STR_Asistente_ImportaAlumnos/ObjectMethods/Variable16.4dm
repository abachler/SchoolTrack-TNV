AL_UpdateArrays (xALP_FieldNames;0)
AL_UpdateArrays (xALP_RecordData;0)

AT_Initialize (->aSourceDataName;->aSourceDataElement)
AT_RedimArrays (Size of array:C274(aRecordFieldNames);->aSourceDataName;->aSourceDataElement)

If (viIOstr_PlatFormSource=4)  //20171122 RCH
	USE CHARACTER SET:C205("UTF-8";1)
Else 
	If (viIOstr_PlatFormSource=3)
		USE CHARACTER SET:C205("windows-1252";1)
	Else 
		USE CHARACTER SET:C205("MacRoman";1)
	End if 
End if 
$ref:=Open document:C264(vtIOstr_FilePath;"";Read mode:K24:5)

$delimiter:=ACTabc_DetectDelimiter (vtIOstr_FilePath)

RECEIVE PACKET:C104($ref;$Header;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
CLOSE DOCUMENT:C267($ref)
ARRAY TEXT:C222(aRecordLine;0)
ARRAY LONGINT:C221(aRecordLineElement;0)
ARRAY TEXT:C222(aText1;0)
AT_Text2Array (->aRecordLine;$header;"\t")
AT_Text2Array (->aText1;$text;"\t")

ARRAY TEXT:C222(aText1;Size of array:C274(aRecordLine))
ARRAY LONGINT:C221(aRecordLineElement;Size of array:C274(aRecordLine))
For ($i;1;Size of array:C274(aRecordLine))  //ABC // 20180315//TKT201105
	  //If ((aRecordLine{$i}="[Alumno]RUT") | (aRecordLine{$i}="[Alumno]DNI") | (aRecordLine{$i}="[Alumno]CURP") | (aRecordLine{$i}="[Alumno]CI"))
	  //aRecordLine{$i}:="[Alumno]Identificador Nacional"
	  //End if 
	  //20180618 ASM Ticket 207921
	Case of 
		: ((aRecordLine{$i}="[Alumno]RUT") | (aRecordLine{$i}="[Alumno]DNI") | (aRecordLine{$i}="[Alumno]CURP") | (aRecordLine{$i}="[Alumno]CI"))
			aRecordLine{$i}:="[Alumno]Identificador Nacional"
			
		: ((aRecordLine{$i}="[Padre]RUT") | (aRecordLine{$i}="[Padre]DNI") | (aRecordLine{$i}="[Padre]CURP") | (aRecordLine{$i}="[Padre]CI"))
			aRecordLine{$i}:="[Padre]Identificador Nacional"
			
		: ((aRecordLine{$i}="[Madre]RUT") | (aRecordLine{$i}="[Madre]DNI") | (aRecordLine{$i}="[Madre]CURP") | (aRecordLine{$i}="[Madre]CI"))
			aRecordLine{$i}:="[Madre]Identificador Nacional"
			
		: ((aRecordLine{$i}="[Apoderado_de_cuenta]RUT") | (aRecordLine{$i}="[Apoderado_de_cuenta]DNI") | (aRecordLine{$i}="[Apoderado_de_cuenta]CURP") | (aRecordLine{$i}="[Apoderado_de_cuenta]CI"))  //MONO 207921
			aRecordLine{$i}:="[Apoderado de cuenta]Identificador Nacional"
			
		: ((aRecordLine{$i}="[Apoderado de cuenta]RUT") | (aRecordLine{$i}="[Apoderado de cuenta]DNI") | (aRecordLine{$i}="[Apoderado de cuenta]CURP") | (aRecordLine{$i}="[Apoderado de cuenta]CI"))
			aRecordLine{$i}:="[Apoderado de cuenta]Identificador Nacional"
			
		: ((aRecordLine{$i}="[Apoderado_académico]RUT") | (aRecordLine{$i}="[Apoderado_académico]DNI") | (aRecordLine{$i}="[Apoderado_académico]CURP") | (aRecordLine{$i}="[Apoderado_académico]CI"))  //MONO 207921
			aRecordLine{$i}:="[Apoderado académico]Identificador Nacional"
			
		: ((aRecordLine{$i}="[Apoderado académico]RUT") | (aRecordLine{$i}="[Apoderado académico]DNI") | (aRecordLine{$i}="[Apoderado académico]CURP") | (aRecordLine{$i}="[Apoderado académico]CI"))
			aRecordLine{$i}:="[Apoderado académico]Identificador Nacional"
	End case 
	
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

AL_UpdateArrays (xALP_RecordData;-2)
AL_UpdateArrays (xALP_FieldNames;-2)

OK:=1

vL_RecordLine:=1
_O_DISABLE BUTTON:C193(bPreviousLine)
If (Size of array:C274(aText1)>0)  //Si hay datos en la primera linea despues del header...
	_O_ENABLE BUTTON:C192(bNextLine)
Else 
	_O_DISABLE BUTTON:C193(bNextLine)
End if 
FORM NEXT PAGE:C248

vt_recordNum:="Registro N° "+String:C10(vL_RecordLine)
vi_PageNumber:=FORM Get current page:C276+1

ARRAY INTEGER:C220(aInteger2D;2;0)
AL_SetCellColor (xALP_FieldNames;3;1;3;Size of array:C274(aRecordFieldNames);aInteger2D;"";0;"Light Gray";0)
AL_UpdateArrays (xALP_FieldNames;-1)