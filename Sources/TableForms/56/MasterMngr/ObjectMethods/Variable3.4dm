LENGUAJE_GuardaBlobs 
$id:=Substring:C12(sRsrId;1;5)
QUERY:C277([xxSTR_TextosInformesNotas:56];[xxSTR_TextosInformesNotas:56]ID:1=Num:C11($id))
If (Records in selection:C76([xxSTR_TextosInformesNotas:56])=1)
	<>aPopRsr:=Find in array:C230(<>aPopRsrID;($id+"@"))
	BLOB_Blob2Vars (-><>langPtr;0;-><>aStrIndex;-><>aStrText)
	sRsrID:=<>aPopRsr{<>aPopRsr}
	lastRsr:=<>aPopRsr
Else 
	sRsrID:=<>aPopRsr{<>aPopRsr}
End if 
AL_UpdateArrays (xALP_Rsr;Size of array:C274(<>aStrIndex))