Case of 
	: (alProEvt=1)
		$row:=AL_GetLine (Self:C308->)
		vlACT_DocID:=alACT_DocsAfectosIDs{$row}
	: (alProEvt=2)
		$row:=AL_GetLine (Self:C308->)
		vlACT_DocID:=alACT_DocsAfectosIDs{$row}
		ACCEPT:C269
End case 