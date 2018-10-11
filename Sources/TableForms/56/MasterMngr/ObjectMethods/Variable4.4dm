If (Before:C29)
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
	$err:=AL_SetArraysNam (Self:C308->;1;2;"<>aStrIndex";"<>aStrText")
	AL_SetHeaders (Self:C308->;1;2;__ ("Nº");__ ("Texto"))
	AL_SetWidths (Self:C308->;1;2;58;400)
	AL_SetSort (Self:C308->;1)
	AL_SetRowOpts (Self:C308->;0;1;0;0;0)
	AL_SetHeight (Self:C308->;1;1;2;0)
	AL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
	AL_SetDividers (Self:C308->;"Black";"Grey";0;"Black";"Grey";0)
	AL_SetSortOpts (Self:C308->;0;0;0;"";0)
	AL_SetEntryOpts (Self:C308->;2;1;0;1;1;<>tXS_RS_DecimalSeparator)
	AL_SetEnterable (Self:C308->;2;1)
	AL_SetEnterable (Self:C308->;1;0)
	  //AL_SetCallbacks (Self>>;"";"rsr_setString")
	ALP_SetDefaultAppareance (Self:C308->;9;2;6;1;8)
	AL_SetFormat (Self:C308->;1;"######")
	AL_SetScroll (Self:C308->;0;-3)
End if 
