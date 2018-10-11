IT_SetButtonState ((Self:C308->>0);->bDelDoc)
Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		EDIT ITEM:C870(Self:C308->)
	: (Form event:C388=On Data Change:K2:15)
		_O_QUERY SUBRECORDS:C108([ADT_Candidatos:49]Documentos:50;[ADT_Candidatos]Documentos'ID=atADT_DID{Self:C308->})
		[ADT_Candidatos]Documentos'Nombre:=Self:C308->{Self:C308->}
		SAVE RECORD:C53([ADT_Candidatos:49])
End case 