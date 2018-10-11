//%attributes = {}
  //BWR_DeclareArrays

If (Count parameters:C259=1)  //23/08
	$size:=$1
Else 
	$size:=0
End if 

ARRAY LONGINT:C221(alBWR_recordNumber;$size)  //hold record numbers

ARRAY TEXT:C222(atBWR_array1;$size)  //texts
ARRAY TEXT:C222(atBWR_array2;$size)
ARRAY TEXT:C222(atBWR_array3;$size)
ARRAY TEXT:C222(atBWR_array4;$size)
ARRAY TEXT:C222(atBWR_array5;$size)
ARRAY TEXT:C222(atBWR_array6;$size)
ARRAY TEXT:C222(atBWR_array7;$size)
ARRAY TEXT:C222(atBWR_array8;$size)
ARRAY TEXT:C222(atBWR_array9;$size)
ARRAY TEXT:C222(atBWR_array10;$size)

ARRAY DATE:C224(adBWR_array1;$size)  //dates
ARRAY DATE:C224(adBWR_array2;$size)
ARRAY DATE:C224(adBWR_array3;$size)
ARRAY DATE:C224(adBWR_array4;$size)
ARRAY DATE:C224(adBWR_array5;$size)
ARRAY DATE:C224(adBWR_array6;$size)
ARRAY DATE:C224(adBWR_array7;$size)
ARRAY DATE:C224(adBWR_array8;$size)
ARRAY DATE:C224(adBWR_array9;$size)
ARRAY DATE:C224(adBWR_array10;$size)

ARRAY LONGINT:C221(alBWR_array1;$size)  //longint
ARRAY LONGINT:C221(alBWR_array2;$size)
ARRAY LONGINT:C221(alBWR_array3;$size)
ARRAY LONGINT:C221(alBWR_array4;$size)
ARRAY LONGINT:C221(alBWR_array5;$size)
ARRAY LONGINT:C221(alBWR_array6;$size)
ARRAY LONGINT:C221(alBWR_array7;$size)
ARRAY LONGINT:C221(alBWR_array8;$size)
ARRAY LONGINT:C221(alBWR_array9;$size)
ARRAY LONGINT:C221(alBWR_array10;$size)

ARRAY INTEGER:C220(aiBWR_array1;$size)  //integer
ARRAY INTEGER:C220(aiBWR_array2;$size)
ARRAY INTEGER:C220(aiBWR_array3;$size)
ARRAY INTEGER:C220(aiBWR_array4;$size)
ARRAY INTEGER:C220(aiBWR_array5;$size)
ARRAY INTEGER:C220(aiBWR_array6;$size)
ARRAY INTEGER:C220(aiBWR_array7;$size)
ARRAY INTEGER:C220(aiBWR_array8;$size)
ARRAY INTEGER:C220(aiBWR_array9;$size)
ARRAY INTEGER:C220(aiBWR_array10;$size)

ARRAY REAL:C219(arBWR_array1;$size)  //real
ARRAY REAL:C219(arBWR_array2;$size)
ARRAY REAL:C219(arBWR_array3;$size)
ARRAY REAL:C219(arBWR_array4;$size)
ARRAY REAL:C219(arBWR_array5;$size)
ARRAY REAL:C219(arBWR_array6;$size)
ARRAY REAL:C219(arBWR_array7;$size)
ARRAY REAL:C219(arBWR_array8;$size)
ARRAY REAL:C219(arBWR_array9;$size)
ARRAY REAL:C219(arBWR_array10;$size)

_O_ARRAY STRING:C218(80;asBWR_array1;$size)  //string
_O_ARRAY STRING:C218(80;asBWR_array2;$size)
_O_ARRAY STRING:C218(80;asBWR_array3;$size)
_O_ARRAY STRING:C218(80;asBWR_array4;$size)
_O_ARRAY STRING:C218(80;asBWR_array5;$size)
_O_ARRAY STRING:C218(80;asBWR_array6;$size)
_O_ARRAY STRING:C218(80;asBWR_array7;$size)
_O_ARRAY STRING:C218(80;asBWR_array8;$size)
_O_ARRAY STRING:C218(80;asBWR_array9;$size)
_O_ARRAY STRING:C218(80;asBWR_array10;$size)

ARRAY BOOLEAN:C223(abBWR_array1;$size)  //boolean
ARRAY BOOLEAN:C223(abBWR_array2;$size)
ARRAY BOOLEAN:C223(abBWR_array3;$size)
ARRAY BOOLEAN:C223(abBWR_array4;$size)
ARRAY BOOLEAN:C223(abBWR_array5;$size)
ARRAY BOOLEAN:C223(abBWR_array6;$size)
ARRAY BOOLEAN:C223(abBWR_array7;$size)
ARRAY BOOLEAN:C223(abBWR_array8;$size)
ARRAY BOOLEAN:C223(abBWR_array9;$size)
ARRAY BOOLEAN:C223(abBWR_array10;$size)


ARRAY LONGINT:C221(abrSelect;0)