Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY INTEGER:C220(aLinesSelected;0)
		ARRAY LONGINT:C221(aIndex;0)
		ARRAY LONGINT:C221(aIndex;Size of array:C274(<>aChoicePtrs{1}->))
		For ($i;1;Size of array:C274(aIndex))
			aIndex{$i}:=$i
		End for 
		Case of 
			: (Size of array:C274(<>aChoicePtrs)=1)
				RESOLVE POINTER:C394(<>aChoicePtrs{1};$arrName1;$tableNum;$fieldNum)
				$err:=AL_SetArraysNam (xALP_Choices;1;2;$arrName1;"aIndex")
				vi_indexCol:=2
			: (Size of array:C274(<>aChoicePtrs)=2)
				RESOLVE POINTER:C394(<>aChoicePtrs{1};$arrName1;$tableNum;$fieldNum)
				RESOLVE POINTER:C394(<>aChoicePtrs{2};$arrName2;$tableNum;$fieldNum)
				$err:=AL_SetArraysNam (xALP_Choices;1;3;$arrName1;$arrName2;"aIndex")
				vi_indexCol:=3
			: (Size of array:C274(<>aChoicePtrs)=3)
				RESOLVE POINTER:C394(<>aChoicePtrs{1};$arrName1;$tableNum;$fieldNum)
				RESOLVE POINTER:C394(<>aChoicePtrs{2};$arrName2;$tableNum;$fieldNum)
				RESOLVE POINTER:C394(<>aChoicePtrs{3};$arrName3;$tableNum;$fieldNum)
				$err:=AL_SetArraysNam (xALP_Choices;1;4;$arrName1;$arrName2;$arrName3;"aIndex")
				vi_indexCol:=4
			: (Size of array:C274(<>aChoicePtrs)=4)
				RESOLVE POINTER:C394(<>aChoicePtrs{1};$arrName1;$tableNum;$fieldNum)
				RESOLVE POINTER:C394(<>aChoicePtrs{2};$arrName2;$tableNum;$fieldNum)
				RESOLVE POINTER:C394(<>aChoicePtrs{3};$arrName3;$tableNum;$fieldNum)
				RESOLVE POINTER:C394(<>aChoicePtrs{4};$arrName4;$tableNum;$fieldNum)
				$err:=AL_SetArraysNam (xALP_Choices;1;5;$arrName1;$arrName2;$arrName3;$arrName4;"aIndex")
				vi_indexCol:=5
			: (Size of array:C274(<>aChoicePtrs)=5)
				RESOLVE POINTER:C394(<>aChoicePtrs{1};$arrName1;$tableNum;$fieldNum)
				RESOLVE POINTER:C394(<>aChoicePtrs{2};$arrName2;$tableNum;$fieldNum)
				RESOLVE POINTER:C394(<>aChoicePtrs{3};$arrName3;$tableNum;$fieldNum)
				RESOLVE POINTER:C394(<>aChoicePtrs{4};$arrName4;$tableNum;$fieldNum)
				RESOLVE POINTER:C394(<>aChoicePtrs{5};$arrName5;$tableNum;$fieldNum)
				$err:=AL_SetArraysNam (xALP_Choices;1;6;$arrName1;$arrName2;$arrName3;$arrName4;$arrName5;"aIndex")
				vi_indexCol:=6
		End case 
		
		For ($i;1;Size of array:C274(<>aChoicePtrs))
			$type:=Type:C295(<>aChoicePtrs{$i}->)
			If ((($type=LongInt array:K8:19) | ($type=Integer array:K8:18) | ($type=Real array:K8:17)))
				AL_SetFormat (xALP_Choices;$i;"#########")  //los números no eran visualizados correctamente...
			End if 
		End for 
		
		If (vi_sortCol>(-MAXINT:K35:1))
			AL_SetSort (xALP_Choices;vi_sortCol)
		End if 
		AL_SetLine (xALP_Choices;choiceIdx)
		AL_SetScroll (xALP_Choices;choiceIdx;-3)
		AL_SetColLock (xALP_Choices;1)
		ALP_SetDefaultAppareance (xALP_Choices;9;1;1;1;4)
		AL_SetMiscOpts (xALP_Choices;1;0;"\\";0;1)
		If (vb_AllowMultiLine)
			AL_SetRowOpts (xALP_Choices;1;1;0;0;0)
		Else 
			AL_SetRowOpts (xALP_Choices;0;1;0;0;0)
		End if 
		AL_SetColOpts (xALP_Choices;0;0;0;hideCol+1;0;0;0)
		AL_SetSortOpts (xALP_Choices;0;0;0;"";0)
	: ((ALproEvt=2) | (breturn=1) | (bEnter=1))
		If (vb_AllowMultiLine)
			ARRAY INTEGER:C220(aLinesSelected;0)
			$result:=AL_GetSelect (xALP_Choices;aLinesSelected)
			If (Size of array:C274(aLinesSelected)>0)
				ACCEPT:C269
			End if 
		Else 
			choiceIdx:=AL_GetLine (xALP_Choices)
			If (choiceIdx#0)
				  //AL_SetSort (xALP_Choices;vi_indexCol)
				ACCEPT:C269
			End if 
		End if 
End case 