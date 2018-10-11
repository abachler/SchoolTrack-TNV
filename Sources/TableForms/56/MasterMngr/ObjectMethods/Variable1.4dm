If (Self:C308->>0)
	LENGUAJE_GuardaBlobs 
	sRsrID:=<>aPopRsr{<>aPopRsr}
	$id:=Num:C11(Substring:C12(sRsrId;1;5))
	QUERY:C277([xxSTR_TextosInformesNotas:56];[xxSTR_TextosInformesNotas:56]ID:1=$id)
	If (Records in selection:C76([xxSTR_TextosInformesNotas:56])=1)
		<>aPopRsr:=Find in array:C230(<>aPopRsrID;$id)
		ARRAY INTEGER:C220(<>aStrIndex;0)
		ARRAY TEXT:C222(<>aStrText;0)
		BLOB_Blob2Vars (-><>langPtr;0;-><>aStrIndex;-><>aStrText)
		lastRsr:=<>aPopRsr
	Else 
		sRsrID:=<>aPopRsr{<>aPopRsr}
	End if 
	AL_UpdateArrays (xALP_Rsr;Size of array:C274(<>aStrIndex))
End if 