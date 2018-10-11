//%attributes = {}
  //ADTcdd_SaveMetaDataValues

AL_ExitCell (xALP_MetaDataValues)
$arr1:=Get pointer:C304("atADT_MetaDataName"+String:C10(vlADT_PrevTabMeta))
$arr2:=Get pointer:C304("atADT_MetaDataType"+String:C10(vlADT_PrevTabMeta))
$arr3:=Get pointer:C304("atADT_MetaDataValue"+String:C10(vlADT_PrevTabMeta))
$arr4:=Get pointer:C304("alADT_MetaDataRecNums"+String:C10(vlADT_PrevTabMeta))
$arr5:=Get pointer:C304("aIDDefs"+String:C10(vlADT_PrevTabMeta))
$arr6:=Get pointer:C304("alADT_MetaDataTypeLong"+String:C10(vlADT_PrevTabMeta))
COPY ARRAY:C226(atADT_MetaDataName;$arr1->)
COPY ARRAY:C226(atADT_MetaDataType;$arr2->)
COPY ARRAY:C226(atADT_MetaDataValue;$arr3->)
COPY ARRAY:C226(alADT_MetaDataRecNums;$arr4->)
COPY ARRAY:C226(aIDDefs;$arr5->)
COPY ARRAY:C226(alADT_MetaDataTypeLong;$arr6->)
For ($j;1;5)
	$arr1:=Get pointer:C304("atADT_MetaDataName"+String:C10($j))
	$arr2:=Get pointer:C304("atADT_MetaDataType"+String:C10($j))
	$arr3:=Get pointer:C304("atADT_MetaDataValue"+String:C10($j))
	$arr4:=Get pointer:C304("alADT_MetaDataRecNums"+String:C10($j))
	$arr5:=Get pointer:C304("aIDDefs"+String:C10($j))
	$arr6:=Get pointer:C304("alADT_MetaDataTypeLong"+String:C10($j))
	For ($i;1;Size of array:C274($arr1->))
		If ($arr3->{$i}#"")
			If ($arr4->{$i}=-1)
				CREATE RECORD:C68([xxADT_MetaDataValues:80])
				[xxADT_MetaDataValues:80]ID:3:=SQ_SeqNumber (->[xxADT_MetaDataValues:80]ID:3)
				[xxADT_MetaDataValues:80]ID_Candidato:4:=[ADT_Candidatos:49]Candidato_numero:1
				[xxADT_MetaDataValues:80]ID_Definition:1:=$arr5->{$i}
				[xxADT_MetaDataValues:80]Value:2:=$arr3->{$i}
				SAVE RECORD:C53([xxADT_MetaDataValues:80])
			Else 
				READ WRITE:C146([xxADT_MetaDataValues:80])
				GOTO RECORD:C242([xxADT_MetaDataValues:80];$arr4->{$i})
				[xxADT_MetaDataValues:80]Value:2:=$arr3->{$i}
				SAVE RECORD:C53([xxADT_MetaDataValues:80])
			End if 
			KRL_UnloadReadOnly (->[xxADT_MetaDataValues:80])
		Else 
			If ($arr4->{$i}=-1)
				
			Else 
				READ WRITE:C146([xxADT_MetaDataValues:80])
				GOTO RECORD:C242([xxADT_MetaDataValues:80];$arr4->{$i})
				DELETE RECORD:C58([xxADT_MetaDataValues:80])
			End if 
		End if 
	End for 
End for 