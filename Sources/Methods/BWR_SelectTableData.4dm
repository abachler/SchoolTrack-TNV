//%attributes = {}
  //BWR_SelectTableData


MESSAGES OFF:C175
If (Shift down:C543)
	$r:=1
	
	If (Records in selection:C76(yBWR_currentTable->)>1000)
		$nf:=String:C10(Records in selection:C76(yBWR_currentTable->))
		$r:=CD_Dlog (2;__ ("Hay ")+$nf+__ (" registros en la tabla\r¿Desea Ud. realmente cargarlos todos?");__ ("");__ ("Si");__ ("No"))
		If ($r=1)
			READ ONLY:C145(yBWR_currentTable->)
			ALL RECORDS:C47(yBWR_currentTable->)
		End if 
	Else 
		READ ONLY:C145(yBWR_currentTable->)
		ALL RECORDS:C47(yBWR_currentTable->)
	End if 
	CREATE EMPTY SET:C140(yBWR_CurrentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
End if 
dhBWR_SpecialSearch 
If (Size of array:C274(alBWR_recordNumber)>0)
	AL_UpdateArrays (xALP_Browser;0)
End if 
BWR_DeclareArrays 
If (Records in set:C195("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))#0)
	BWR_LoadData 
Else 
	BWR_AutoLoad 
End if 


BWR_SetWindowTitle 
BWR_SetMenuBar 

BWR_SetInterfaceObjects 
AL_UpdateArrays (xALP_Browser;-2)
BWR_SetSort 

BWR_FormatBrowserCols 
If (vtBWR_OnLoadMethod#"")
	If (API Does Method Exist (vtBWR_OnLoadMethod)=1)
		KRL_ExecuteMethod (vtBWR_OnLoadMethod)
	End if 
End if 
AL_UpdateArrays (xALP_Browser;-2)

