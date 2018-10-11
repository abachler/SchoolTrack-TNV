WDW_Open (446;102;0;4;__ ("Nueva Area"))
FORM SET INPUT:C55([xxSTR_TextosInformesNotas:56];"Input")
ADD RECORD:C56([xxSTR_TextosInformesNotas:56];*)
CLOSE WINDOW:C154
If (ok=1)
	$id:=[xxSTR_TextosInformesNotas:56]ID:1
	READ ONLY:C145([xxSTR_TextosInformesNotas:56])
	ALL RECORDS:C47([xxSTR_TextosInformesNotas:56])
	SELECTION TO ARRAY:C260([xxSTR_TextosInformesNotas:56]ID:1;<>aPopRsrID;[xxSTR_TextosInformesNotas:56]Name:2;<>aPopRsr)
	For ($i;1;Size of array:C274(<>aPopRsr))
		<>aPopRsr{$i}:=String:C10(<>aPopRsrID{$i};"00000")+": "+<>aPopRsr{$i}
		SORT ARRAY:C229(<>aPopRsrID;<>aPopRsr)
		<>aLang:=1
		<>langPtr:=Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);<>aLang+2)
		<>aPopRsr:=Find in array:C230(<>aPopRsrId;$id)
	End for 
	UNLOAD RECORD:C212([xxSTR_TextosInformesNotas:56])
End if 