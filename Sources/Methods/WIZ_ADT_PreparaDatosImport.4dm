//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 14-03-17, 10:48:22
  // ----------------------------------------------------
  // Método: WIZ_ADT_PreparaDatosImport
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

ARRAY TEXT:C222(aSourceDataName;0)
ARRAY LONGINT:C221(aSourceDataElement;0)

$rutaArchivo:=$1
USE CHARACTER SET:C205("UTF-8";1)

AT_RedimArrays (Size of array:C274(aRecordFieldNames);->aSourceDataName;->aSourceDataElement)

$ref:=Open document:C264($rutaArchivo;"";Read mode:K24:5)
RECEIVE PACKET:C104($ref;$Header;"\r")
RECEIVE PACKET:C104($ref;$text;"\r")
CLOSE DOCUMENT:C267($ref)
ARRAY TEXT:C222(aRecordLine;0)
ARRAY LONGINT:C221(aRecordLineElement;0)
ARRAY TEXT:C222(aText1;0)
AT_Text2Array (->aRecordLine;$header;"\t")
AT_Text2Array (->aText1;$text;"\t")

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
CLOSE DOCUMENT:C267($ref)
$0:=1
