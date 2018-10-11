C_LONGINT:C283($vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo)
C_LONGINT:C283($objId;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;vlSRop_options;$order;$selected;$tableNo;$fieldNo;$varType;viSRop_ArrayIndex;$calcType;$rows;$cols;viSRop_HorOffset;viSRop_VerOffset)



Case of 
	: (vlSR_breakType=SR Section Break On Field)
		RObj_ShowTableFields_Selector (2;->vlSR_breakTable;->vlSR_breakField)
		
	: (vlSR_breakType=SR Section Break On Array)
		ARRAY LONGINT:C221($aIds;0)
		ARRAY TEXT:C222($aVarNames;0)
		
		SR Get Object IDs (xReportData;SR All Objects;$aIds)
		For ($i;1;Size of array:C274($aIds))
			SR Get Object Properties (xReportData;$aIds{$i};$vtSRop_VariableName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$vlSRop_options;$order;$selected;$tableNo;$fieldNo;$viSRop_VariableType;$viSRop_ArrayIndex;$viSRop_CalcType;$vtSRop_CalcValueVariable;$rows;$cols;$viSRop_HorOffset;$viSRop_VerOffset)
			If (($objType=SR Object Type Variable) & ($viSRop_VariableType=SR Variable Type Array Auto))
				APPEND TO ARRAY:C911($aVarNames;$vtSRop_VariableName)
			End if 
		End for 
		
		SORT ARRAY:C229($aVarNames)
		$selected:=0
		If (vtSRP_BreakObjectName#"")
			$selected:=Find in array:C230($aVarNames;vtSRP_BreakObjectName)
		End if 
		$result:=Pop up menu:C542(AT_array2text (->$aVarNames);$selected)
		If ($result>0)
			vtSRP_BreakObjectName:=$aVarNames{$result}
			vtSR_breakVariable:=vtSRP_BreakObjectName
			  //vlSR_breakTable:=0
			  //vlSR_breakField:=0
		End if 
		
	: (vlSR_breakType=SR Section Break On Variable)
		ARRAY LONGINT:C221($aIds;0)
		ARRAY TEXT:C222($aVarNames;0)
		
		SR Get Object IDs (xReportData;SR All Objects;$aIds)
		For ($i;1;Size of array:C274($aIds))
			SR Get Object Properties (xReportData;$aIds{$i};$vtSRop_VariableName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$vlSRop_options;$order;$selected;$tableNo;$fieldNo;$viSRop_VariableType;$viSRop_ArrayIndex;$viSRop_CalcType;$vtSRop_CalcValueVariable;$rows;$cols;$viSRop_HorOffset;$viSRop_VerOffset)
			If (($objType=SR Object Type Variable) & ($viSRop_VariableType=SR Variable Type Variable))
				APPEND TO ARRAY:C911($aVarNames;$vtSRop_VariableName)
			End if 
		End for 
		
		
		SORT ARRAY:C229($aVarNames)
		AT_DistinctsArrayValues (->$aVarNames)
		$selected:=0
		If (vtSRP_BreakObjectName#"")
			$selected:=Find in array:C230($aVarNames;vtSRP_BreakObjectName)
		End if 
		$result:=Pop up menu:C542(AT_array2text (->$aVarNames);$selected)
		If ($result>0)
			vtSRP_BreakObjectName:=$aVarNames{$result}
			vtSR_breakVariable:=vtSRP_BreakObjectName
			  //vlSR_breakTable:=0
			  //vlSR_breakField:=0
		End if 
		
End case 
