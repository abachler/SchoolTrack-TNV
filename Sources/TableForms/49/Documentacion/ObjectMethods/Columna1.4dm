IT_SetButtonState ((Self:C308->>0);->bDelDoc)
Case of 
	: (Form event:C388=On Clicked:K2:4)
		
	: (Form event:C388=On Data Change:K2:15)
		_O_QUERY SUBRECORDS:C108([ADT_Candidatos:49]Documentos:50;[ADT_Candidatos]Documentos'ID=atADT_DID{Self:C308->})
		[ADT_Candidatos]Documentos'Revisado:=Self:C308->{Self:C308->}
		SAVE RECORD:C53([ADT_Candidatos:49])
		LISTBOX SELECT ROW:C912(lbDocumentos;Self:C308->;lk replace selection:K53:1)
		REDRAW WINDOW:C456
End case 