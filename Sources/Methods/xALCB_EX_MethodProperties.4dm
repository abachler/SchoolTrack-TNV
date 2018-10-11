//%attributes = {}
  //xALCB_EX_MethodProperties

C_BOOLEAN:C305($0)
C_LONGINT:C283($area;$col;$row;$1;$2)

$area:=$1
$method:=$2

If ($method=8)  //soft deselect
	$0:=False:C215
Else 
	AL_GetCurrCell ($area;$col;$row)
	If ($col=4)
		$methodName:=atXS_Methods_Name{$row}
		If ($methodName#"")
			aMethodNames{0}:=$methodName
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->aMethodNames;">>";->$DA_Return)
			If (Size of array:C274($DA_Return)>1)
				ARRAY TEXT:C222(distinctMethods;0)
				ARRAY LONGINT:C221(distinctMethodIDs;0)
				For ($i;1;Size of array:C274($DA_Return))
					APPEND TO ARRAY:C911(distinctMethods;aMethodNames{$DA_Return{$i}})
					APPEND TO ARRAY:C911(distinctMethodIDs;aMethodIDs{$DA_Return{$i}})
				End for 
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;2)
				<>aChoicePtrs{1}:=->distinctMethods
				<>aChoicePtrs{2}:=->distinctMethodIDs
				TBL_ShowChoiceList (1;__ ("Seleccione el método");1)
				If (ok=1)
					alXS_Methods_ID{$row}:=distinctMethodIDs{choiceIdx}
					atXS_Methods_Name{$row}:=distinctMethods{choiceIdx}
				Else 
					alXS_Methods_ID{$row}:=0
					atXS_Methods_Name{$row}:=""
					AL_GotoCell ($area;$col;$row)
					AL_SetCellHigh ($area;1;32000)
				End if 
				ARRAY TEXT:C222(distinctMethods;0)
				ARRAY LONGINT:C221(distinctMethodIDs;0)
			Else 
				If (Size of array:C274($DA_Return)=0)
					CD_Dlog (0;__ ("El método no existe."))
					alXS_Methods_ID{$row}:=0
					atXS_Methods_Name{$row}:=""
					AL_GotoCell ($area;$col;$row)
					AL_SetCellHigh ($area;1;32000)
				Else 
					alXS_Methods_ID{$row}:=aMethodIDs{$DA_Return{1}}
					atXS_Methods_Name{$row}:=aMethodNames{$DA_Return{1}}
				End if 
			End if 
		Else 
			ARRAY POINTER:C280(<>aChoicePtrs;0)
			ARRAY POINTER:C280(<>aChoicePtrs;2)
			<>aChoicePtrs{1}:=->aMethodNames
			<>aChoicePtrs{2}:=->aMethodIDs
			TBL_ShowChoiceList (1;__ ("Seleccione el método");1)
			If (ok=1)
				alXS_Methods_ID{$row}:=aMethodIDs{choiceIdx}
				atXS_Methods_Name{$row}:=aMethodNames{choiceIdx}
			Else 
				alXS_Methods_ID{$row}:=0
				atXS_Methods_Name{$row}:=""
			End if 
		End if 
	End if 
	$0:=True:C214
End if 