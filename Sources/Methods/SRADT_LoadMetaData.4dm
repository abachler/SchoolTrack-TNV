//%attributes = {}
  //SRADT_LoadMetaData

C_POINTER:C301($arr1;$arr2;$arr3;$arr4;$arr5;$arr6)
C_LONGINT:C283($i;$j;$pos)


ARRAY TEXT:C222(atADT_MetaDataName1;0)
ARRAY TEXT:C222(atADT_MetaDataType1;0)
ARRAY TEXT:C222(atADT_MetaDataValue1;0)
ARRAY LONGINT:C221(alADT_MetaDataTypeLong1;0)
ARRAY LONGINT:C221(aIDDefs1;0)

ARRAY TEXT:C222(atADT_MetaDataName2;0)
ARRAY TEXT:C222(atADT_MetaDataType2;0)
ARRAY TEXT:C222(atADT_MetaDataValue2;0)
ARRAY LONGINT:C221(alADT_MetaDataTypeLong2;0)
ARRAY LONGINT:C221(aIDDefs2;0)

ARRAY TEXT:C222(atADT_MetaDataName3;0)
ARRAY TEXT:C222(atADT_MetaDataType3;0)
ARRAY TEXT:C222(atADT_MetaDataValue3;0)
ARRAY LONGINT:C221(alADT_MetaDataTypeLong3;0)
ARRAY LONGINT:C221(aIDDefs3;0)

ARRAY TEXT:C222(atADT_MetaDataName4;0)
ARRAY TEXT:C222(atADT_MetaDataType4;0)
ARRAY TEXT:C222(atADT_MetaDataValue4;0)
ARRAY LONGINT:C221(alADT_MetaDataTypeLong4;0)
ARRAY LONGINT:C221(aIDDefs4;0)

ARRAY TEXT:C222(atADT_MetaDataName5;0)
ARRAY TEXT:C222(atADT_MetaDataType5;0)
ARRAY TEXT:C222(atADT_MetaDataValue5;0)
ARRAY LONGINT:C221(alADT_MetaDataTypeLong5;0)
ARRAY LONGINT:C221(aIDDefs5;0)

For ($i;1;5)
	$arr1:=Get pointer:C304("atADT_MetaDataName"+String:C10($i))
	$arr2:=Get pointer:C304("atADT_MetaDataType"+String:C10($i))
	$arr3:=Get pointer:C304("atADT_MetaDataValue"+String:C10($i))
	$arr5:=Get pointer:C304("aIDDefs"+String:C10($i))
	$arr6:=Get pointer:C304("alADT_MetaDataTypeLong"+String:C10($i))
	READ ONLY:C145([xxADT_MetaDataDefinition:79])
	QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Category:4=$i)
	ORDER BY:C49([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Posicion:8;>)
	SELECTION TO ARRAY:C260([xxADT_MetaDataDefinition:79]Name:2;$arr1->;[xxADT_MetaDataDefinition:79]Tipo:3;$arr6->;[xxADT_MetaDataDefinition:79]ID:1;$arr5->)
	AT_RedimArrays (Size of array:C274($arr1->);$arr3;$arr2)
	For ($j;1;Size of array:C274($arr1->))
		Case of 
			: ($arr6->{$j}=Is text:K8:3)
				$arr2->{$j}:="Texto"
			: ($arr6->{$j}=Is date:K8:7)
				$arr2->{$j}:="Fecha"
			: ($arr6->{$j}=Is longint:K8:6)
				$arr2->{$j}:="Entero"
			: ($arr6->{$j}=Is real:K8:4)
				$arr2->{$j}:="Real"
			Else 
				$arr2->{$j}:="Indefinido"
		End case 
	End for 
	READ ONLY:C145([xxADT_MetaDataValues:80])
	QUERY:C277([xxADT_MetaDataValues:80];[xxADT_MetaDataValues:80]ID_Candidato:4=[ADT_Candidatos:49]Candidato_numero:1)
	FIRST RECORD:C50([xxADT_MetaDataValues:80])
	While (Not:C34(End selection:C36([xxADT_MetaDataValues:80])))
		$pos:=Find in array:C230($arr5->;[xxADT_MetaDataValues:80]ID_Definition:1)
		If ($pos#-1)
			$arr3->{$pos}:=[xxADT_MetaDataValues:80]Value:2
		End if 
		NEXT RECORD:C51([xxADT_MetaDataValues:80])
	End while 
End for 