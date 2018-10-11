$currentdate:=Current date:C33(*)
AL_UpdateArrays (xALP_Loans;Size of array:C274(aLong2))
For ($i;1;Size of array:C274(aDate1))
	Case of 
		: ((aText4{$i}#<>aCpyStatus{1}) & (aText4{$i}#<>aCpyStatus{2}))
			AL_SetRowColor (xALP_Loans;$i;"Grey";0)
			AL_SetRowStyle (xALP_Loans;$i;2)
		: ((aDate1{$i}<$currentDate) & (aDate2{$i}=!00-00-00!))
			AL_SetRowColor (xALP_Loans;$i;"Red";0)
		: ((aDate2{$i}=!00-00-00!) & (aText4{$i}=<>aCpyStatus{2}))
			AL_SetRowColor (xALP_Loans;$i;"Blue";0)
		: (aDate2{$i}>!00-00-00!)
			AL_SetRowColor (xALP_Loans;$i;"Black";0)
	End case 
End for 
AL_SetLine (xALP_Loans;0)

OBJECT SET VISIBLE:C603(bCurrent;False:C215)
OBJECT SET VISIBLE:C603(bHistoric;True:C214)