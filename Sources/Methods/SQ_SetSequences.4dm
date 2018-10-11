//%attributes = {}
  //SQ_SetSequences

  //$pID:=IT_UThermometer (1;0;"Actualizando contadores...")
$m:=Milliseconds:C459
READ ONLY:C145([xShell_Fields:52])
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]AutomaticSequenceNumber:23=True:C214)
SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroTabla:1;$aTableNumbers;[xShell_Fields:52]NumeroCampo:2;$aFieldNumbers)
For ($i;1;Size of array:C274($aTableNumbers))
	If (Is table number valid:C999($aTableNumbers{$i}))
		SQ_getLastID (Field:C253($aTableNumbers{$i};$aFieldNumbers{$i}))
		SQ_getLastID (Field:C253($aTableNumbers{$i};$aFieldNumbers{$i});True:C214)
	End if 
End for 
SQ_getLastID (->[xxACT_MonedaParidad:147]ID:1)
SQ_getLastID (->[xShell_UserGroups:17]IDGroup:1)
SQ_getLastID (->[xShell_Users:47]No:1)
SQ_getLastID (->[xShell_Queries:53]No:1)
SQ_getLastID (->[xShell_Userfields:76]FieldID:7)
SQ_getLastID (->[xShell_Documents:91]DocID:9)
SQ_getLastID (->[xShell_Reports:54]ID:7)
SQ_getLastID (->[xShell_Fields:52]ID:24)
SQ_getLastID (->[xShell_MetodoActualizacion:252]id:1)  //20130520 RCH

dhSQ_SetSequences 
$m:=Milliseconds:C459-$m
  //TRACE
  //IT_UThermometer (-2;$pID)