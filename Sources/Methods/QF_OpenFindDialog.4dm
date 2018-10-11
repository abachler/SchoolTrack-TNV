//%attributes = {}
  //QF_OpenFindDialog

C_LONGINT:C283($tableNumber;$s)

vb_ClairvoyanceON:=False:C215

_O_ARRAY STRING:C218(35;aQsFields;0)
ARRAY POINTER:C280(aQsPtr;0)
_O_ARRAY STRING:C218(4;aQsRels;0)
_O_ARRAY STRING:C218(11;aQSList;0)

QRY_LoadOperatorsArray 


$fields:=Size of array:C274(alVS_QFSourceTableNumber)
If ($fields>0)
	
	USR_RegisterUserEvent (UE_Find;vlBWR_SelectedTableRef)
	
	
	ARRAY TEXT:C222(atVS_QFAssociatedList;$fields)
	For ($i;1;$fields)
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=alVS_QFSourceTableNumber{$i};*)
		QUERY:C277([xShell_Fields:52]; & [xShell_Fields:52]NumeroCampo:2=alVS_QFSourceFieldNumber{$i})
		atVS_QFAssociatedList{$i}:=[xShell_Fields:52]ListaDeValoresAsociados:11
	End for 
	
	
	READ ONLY:C145(yBWR_currentTable->)
	$trapped:=dhQF_OpenFindDialog 
	If (Not:C34($trapped))
		QF_DisplayDialog 
	End if 
	
	
	If (ok=1)
		CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
	End if 
Else 
	CD_Dlog (0;__ ("No existen campos definidos para búsquedas rápidas."))
End if 
