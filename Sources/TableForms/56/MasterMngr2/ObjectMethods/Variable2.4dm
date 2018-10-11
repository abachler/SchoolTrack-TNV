If (Self:C308->>0)
	LENGUAJE_GuardaBlobs 
	<>langPtr:=Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);<>aLang+7)
	BLOB_Blob2Vars (<>langPtr;0;-><>aStrIndex;-><>aStrText)
	AL_UpdateArrays (xALP_Rsr;Size of array:C274(<>aStrIndex))
End if 