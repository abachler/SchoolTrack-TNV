If (Find in array:C230(<>aPLaceCode;Self:C308->)=-1)
	INSERT IN ARRAY:C227(<>aPLaceCode;1;1)
	INSERT IN ARRAY:C227(<>aPLace;1;1)
	<>aPlaceCode{1}:=Self:C308->
End if 
[xxBBL_Preferencias:65]Lugar principal:29:=Self:C308->
SAVE RECORD:C53([xxBBL_Preferencias:65])