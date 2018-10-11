Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(bDevTools;(<>lUSR_RelatedTableUserID=-1))
		ARRAY INTEGER:C220(<>aStrIndex;0)
		ARRAY TEXT:C222(<>aStrText;0)
		If (Size of array:C274(<>aPopRsr)>0)
			lastRsr:=1
			<>apopRsr:=1
			sRsrID:=<>aPopRsr{<>aPopRsr}
			$id:=Num:C11(Substring:C12(sRsrId;1;5))
			QUERY:C277([xxSTR_TextosInformesNotas:56];[xxSTR_TextosInformesNotas:56]ID:1=$id)
			If (Records in selection:C76([xxSTR_TextosInformesNotas:56])=1)
				<>aPopRsr:=Find in array:C230(<>aPopRsrID;$id)
				BLOB_Blob2Vars (<>langPtr;0;-><>aStrIndex;-><>aStrText)
				lastRsr:=<>aPopRsr
			End if 
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 