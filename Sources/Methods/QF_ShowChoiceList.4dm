//%attributes = {}
  //QF_ShowChoiceList

C_LONGINT:C283($1;$2;$hideCol;$sortCol)

If (Count parameters:C259>=1)
	$sortCol:=$1
End if 
If (Count parameters:C259=2)
	$hideCol:=$2
End if 

AL_RemoveArrays (xALP_Choices;1;30)
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
End case 
AL_SetMiscOpts (xALP_Choices;1;0;"'";0;1)
AL_SetRowOpts (xALP_Choices;0;1;0;0;0)
AL_SetColOpts (xALP_Choices;0;0;0;$hideCol+1;0;0;0)
AL_SetStyle (xALP_Choices;0;"Tahoma";11;0)
AL_SetSortOpts (xALP_Choices;0;0;0;"";0)
If ($sortCol>0)
	AL_SetSort (xALP_Choices;$sortCol)
End if 
AL_SetLine (xALP_Choices;choiceIdx)
AL_SetHeight (xALP_Choices;1;1;1;2)
AL_SetScroll (xALP_Choices;choiceIdx;1)
AL_SetColLock (xALP_Choices;1)


For ($i;1;Size of array:C274(<>aChoicePtrs{1}->))
	If (Dec:C9($i/2)=0)
		AL_SetRowColor (xALP_Choices;$i;"Black";0;"";1)
	Else 
		AL_SetRowColor (xALP_Choices;$i;"Black";0;"";(15*16)+2)
	End if 
End for 