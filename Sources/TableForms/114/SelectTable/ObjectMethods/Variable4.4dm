$tableNum:=vi_TableNumber
If ($tableNum>0)
	vi_TableNumber:=$tableNum
	aTableNames:=Find in array:C230(aTableNumbers;$tableNum)
Else 
	vi_TableNumber:=0
	aTableNames:=0
End if 