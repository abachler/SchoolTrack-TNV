Case of 
	: (([xShell_Documents:91]RefType:10="URL") & ([xShell_Documents:91]URL:11=""))
		CD_Dlog (0;__ ("Por favor ingrese la URL del documento que desea vincular."))
	: (([xShell_Documents:91]RefType:10="DOC") & ([xShell_Documents:91]OriginalPath:12=""))
		CD_Dlog (0;__ ("Por favor seleccione el docuewmnto que desea asociar."))
	: (([xShell_Documents:91]RefType:10="DOC") & ([xShell_Documents:91]DocumentName:3=""))
		CD_Dlog (0;__ ("Por favor asigne un nombre al documento asociado."))
	: (([xShell_Documents:91]RefType:10="URL") & ([xShell_Documents:91]DocumentName:3=""))
		CD_Dlog (0;__ ("Por favor indique el texto para el vínculo."))
	Else 
		ACCEPT:C269
End case 
