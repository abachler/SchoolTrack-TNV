//%attributes = {}
  //LENGUAJE_GuardaBlobs

C_LONGINT:C283($i;$k)

READ WRITE:C146([xxSTR_TextosInformesNotas:56])
QUERY:C277([xxSTR_TextosInformesNotas:56];[xxSTR_TextosInformesNotas:56]ID:1=<>aPopRsrId{lastRsr})
BLOB_Variables2Blob (<>langPtr;0;-><>aStrIndex;-><>aStrText)
SORT ARRAY:C229(<>aStrIndex;<>aStrText;>)
COPY ARRAY:C226(<>aStrIndex;$strIndex)
COPY ARRAY:C226(<>aStrText;$strText)

For ($i;8;12)
	If (Field:C253(<>langPtr)#Field:C253(Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);$i)))
		ARRAY INTEGER:C220(<>aStrIndex;0)
		ARRAY TEXT:C222(<>aStrText;0)
		BLOB_Blob2Vars (Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);$i);0;-><>aStrIndex;-><>aStrText)
		SORT ARRAY:C229(<>aStrIndex;<>aStrText;>)
		$s1:=Size of array:C274($strIndex)
		$s2:=Size of array:C274(<>aStrIndex)
		If ($s1>$s2)
			AT_Insert ($s2+1;$s1-$s2;-><>aStrIndex;-><>aStrText)
		End if 
		For ($k;1;Size of array:C274($strIndex))
			<>aStrIndex{$k}:=$strIndex{$k}
			If (<>aStrText{$k}="")
				<>aStrText{$k}:=$strText{$k}
			End if 
		End for 
		BLOB_Variables2Blob (Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);$i);0;-><>aStrIndex;-><>aStrText)
	End if 
End for 
SAVE RECORD:C53([xxSTR_TextosInformesNotas:56])
READ ONLY:C145([xxSTR_TextosInformesNotas:56])