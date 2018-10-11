//%attributes = {}
  //AL_RelateSelection

C_POINTER:C301($1;$2)
$yfield:=$1
$ytable:=Table:C252(Table:C252($yField))

ARRAY LONGINT:C221($aIdAlumnos;0)
If (Count parameters:C259=2)
	COPY ARRAY:C226($2->;$aIdAlumnos)
Else 
	SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIdAlumnos)
End if 

QRY_QueryWithArray ($yField;->$aIdAlumnos)
CREATE SET:C116($ytable->;"positive_Ids")

AT_NegativeNumericArray (->$aIdAlumnos)
QRY_QueryWithArray ($yField;->$aIdAlumnos)
CREATE SET:C116($ytable->;"negative_Ids")

UNION:C120("positive_Ids";"negative_Ids";"all_Ids")

USE SET:C118("all_Ids")

SET_ClearSets ("positive_Ids";"negative_Ids";"all_Ids")