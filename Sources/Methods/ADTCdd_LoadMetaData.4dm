//%attributes = {}
  //ADTCdd_LoadMetaData

$category:=$1

AL_RemoveArrays (xALP_MetaDataValues;1;390)

If ($category=0)
	ARRAY TEXT:C222(atADT_MetaDataName1;0)
	ARRAY TEXT:C222(atADT_MetaDataType1;0)
	ARRAY TEXT:C222(atADT_MetaDataValue1;0)
	ARRAY LONGINT:C221(alADT_MetaDataRecNums1;0)
	ARRAY LONGINT:C221(aIDDefs1;0)
	ARRAY LONGINT:C221(alADT_MetaDataTypeLong1;0)
	
	ARRAY TEXT:C222(atADT_MetaDataName2;0)
	ARRAY TEXT:C222(atADT_MetaDataType2;0)
	ARRAY TEXT:C222(atADT_MetaDataValue2;0)
	ARRAY LONGINT:C221(alADT_MetaDataRecNums2;0)
	ARRAY LONGINT:C221(aIDDefs2;0)
	ARRAY LONGINT:C221(alADT_MetaDataTypeLong2;0)
	
	ARRAY TEXT:C222(atADT_MetaDataName3;0)
	ARRAY TEXT:C222(atADT_MetaDataType3;0)
	ARRAY TEXT:C222(atADT_MetaDataValue3;0)
	ARRAY LONGINT:C221(alADT_MetaDataRecNums3;0)
	ARRAY LONGINT:C221(aIDDefs3;0)
	ARRAY LONGINT:C221(alADT_MetaDataTypeLong3;0)
	
	ARRAY TEXT:C222(atADT_MetaDataName4;0)
	ARRAY TEXT:C222(atADT_MetaDataType4;0)
	ARRAY TEXT:C222(atADT_MetaDataValue4;0)
	ARRAY LONGINT:C221(alADT_MetaDataRecNums4;0)
	ARRAY LONGINT:C221(aIDDefs4;0)
	ARRAY LONGINT:C221(alADT_MetaDataTypeLong4;0)
	
	ARRAY TEXT:C222(atADT_MetaDataName5;0)
	ARRAY TEXT:C222(atADT_MetaDataType5;0)
	ARRAY TEXT:C222(atADT_MetaDataValue5;0)
	ARRAY LONGINT:C221(alADT_MetaDataRecNums5;0)
	ARRAY LONGINT:C221(aIDDefs5;0)
	ARRAY LONGINT:C221(alADT_MetaDataTypeLong5;0)
	
	ARRAY TEXT:C222(atADT_MetaDataName;0)
	ARRAY TEXT:C222(atADT_MetaDataType;0)
	ARRAY TEXT:C222(atADT_MetaDataValue;0)
	ARRAY LONGINT:C221(alADT_MetaDataRecNums;0)
	ARRAY LONGINT:C221(aIDDefs;0)
	ARRAY LONGINT:C221(alADT_MetaDataTypeLong;0)
	For ($i;1;5)
		$arr1:=Get pointer:C304("atADT_MetaDataName"+String:C10($i))
		$arr2:=Get pointer:C304("atADT_MetaDataType"+String:C10($i))
		$arr3:=Get pointer:C304("atADT_MetaDataValue"+String:C10($i))
		$arr4:=Get pointer:C304("alADT_MetaDataRecNums"+String:C10($i))
		$arr5:=Get pointer:C304("aIDDefs"+String:C10($i))
		$arr6:=Get pointer:C304("alADT_MetaDataTypeLong"+String:C10($i))
		READ ONLY:C145([xxADT_MetaDataDefinition:79])
		QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Category:4=$i)
		ORDER BY:C49([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Posicion:8;>)
		SELECTION TO ARRAY:C260([xxADT_MetaDataDefinition:79]Name:2;$arr1->;[xxADT_MetaDataDefinition:79]ID:1;$arr5->;[xxADT_MetaDataDefinition:79]Tipo:3;$arr6->)
		AT_RedimArrays (Size of array:C274($arr1->);$arr3;$arr4;$arr2)
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
			$arr4->{$j}:=-1
		End for 
		READ ONLY:C145([xxADT_MetaDataValues:80])
		QUERY:C277([xxADT_MetaDataValues:80];[xxADT_MetaDataValues:80]ID_Candidato:4=[ADT_Candidatos:49]Candidato_numero:1)
		FIRST RECORD:C50([xxADT_MetaDataValues:80])
		While (Not:C34(End selection:C36([xxADT_MetaDataValues:80])))
			$pos:=Find in array:C230($arr5->;[xxADT_MetaDataValues:80]ID_Definition:1)
			If ($pos#-1)
				$arr3->{$pos}:=[xxADT_MetaDataValues:80]Value:2
				$arr4->{$pos}:=Record number:C243([xxADT_MetaDataValues:80])
			End if 
			NEXT RECORD:C51([xxADT_MetaDataValues:80])
		End while 
	End for 
	COPY ARRAY:C226(atADT_MetaDataName2;atADT_MetaDataName)
	COPY ARRAY:C226(atADT_MetaDataType2;atADT_MetaDataType)
	COPY ARRAY:C226(atADT_MetaDataValue2;atADT_MetaDataValue)
	COPY ARRAY:C226(alADT_MetaDataRecNums2;alADT_MetaDataRecNums)
	COPY ARRAY:C226(aIDDefs2;aIDDefs)
	COPY ARRAY:C226(alADT_MetaDataTypeLong2;alADT_MetaDataTypeLong)
	$arrPtr:=->atADT_MetaDataName2
Else 
	$arr1:=Get pointer:C304("atADT_MetaDataName"+String:C10($category))
	$arr2:=Get pointer:C304("atADT_MetaDataType"+String:C10($category))
	$arr3:=Get pointer:C304("atADT_MetaDataValue"+String:C10($category))
	$arr4:=Get pointer:C304("alADT_MetaDataRecNums"+String:C10($category))
	$arr5:=Get pointer:C304("aIDDefs"+String:C10($category))
	$arr6:=Get pointer:C304("alADT_MetaDataTypeLong"+String:C10($category))
	COPY ARRAY:C226($arr1->;atADT_MetaDataName)
	COPY ARRAY:C226($arr2->;atADT_MetaDataType)
	COPY ARRAY:C226($arr3->;atADT_MetaDataValue)
	COPY ARRAY:C226($arr4->;alADT_MetaDataRecNums)
	COPY ARRAY:C226($arr5->;aIDDefs)
	COPY ARRAY:C226($arr6->;alADT_MetaDataTypeLong)
	$arrPtr:=$arr1
End if 

IT_SetButtonState ((Size of array:C274($arrPtr->)>0);->bDelMetaValue)

$err:=ALP_DefaultColSettings (xALP_MetaDataValues;1;"atADT_MetaDataName";__ ("Campo");160)
$err:=ALP_DefaultColSettings (xALP_MetaDataValues;2;"atADT_MetaDataType";__ ("Tipo");60)
If ([ADT_Candidatos:49]Transf_ST:68)
	$enterable:=0
Else 
	$enterable:=1
End if 
$err:=ALP_DefaultColSettings (xALP_MetaDataValues;3;"atADT_MetaDataValue";__ ("Valor");165;"";0;0;$enterable)
$err:=ALP_DefaultColSettings (xALP_MetaDataValues;4;"aIDDefs";"")
$err:=ALP_DefaultColSettings (xALP_MetaDataValues;5;"alADT_MetaDataTypeLong";"")
$err:=ALP_DefaultColSettings (xALP_MetaDataValues;6;"alADT_MetaDataRecNums";"")

ALP_SetDefaultAppareance (xALP_MetaDataValues;9;3;6;1;8)

AL_SetColOpts (xALP_MetaDataValues;0;1;0;3;0)
  //AL_SetColLock (xALP_MetaDataValues;2) no se por que pero la columna que queda marcada es la 1 
AL_SetRowOpts (xALP_MetaDataValues;0;1;0;0;1;0)
AL_SetCellOpts (xALP_MetaDataValues;0;1;1)
AL_SetMiscOpts (xALP_MetaDataValues;0;0;"\\";0;1)
AL_SetMainCalls (xALP_MetaDataValues;"";"")
AL_SetCallbacks (xALP_MetaDataValues;"";"xALCB_ADT_EX_MetaData")
AL_SetScroll (xALP_MetaDataValues;0;-3)
AL_SetEntryOpts (xALP_MetaDataValues;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_MetaDataValues;0;30;0)