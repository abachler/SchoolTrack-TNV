Case of 
	: (Form event:C388=On Data Change:K2:15)
		C_TEXT:C284($caracter;$cadena;$original)
		READ WRITE:C146([ADT_Candidatos:49])
		_O_QUERY SUBRECORDS:C108([ADT_Candidatos:49]Documentos:50;[ADT_Candidatos]Documentos'ID=atADT_DID{Self:C308->})
		
		If (abADT_DCertificado{abADT_DCertificado}=True:C214)
			$caracter:=Substring:C12(atADT_DID{Self:C308->};1;1)
			If ($caracter#"-")
				atADT_DID{Self:C308->}:="-"+atADT_DID{Self:C308->}
				
				[ADT_Candidatos]Documentos'ID:=atADT_DID{Self:C308->}
				SAVE RECORD:C53([ADT_Candidatos:49])
			End if 
			v_certificado:=atADT_DNombre{Self:C308->}
			v_idCertificado:=atADT_DID{Self:C308->}
		Else 
			$caracter:=Substring:C12(atADT_DID{Self:C308->};1;1)
			$cadena:=Substring:C12(atADT_DID{Self:C308->};2;Length:C16(atADT_DID{Self:C308->}))
			
			If ($caracter="-")
				[ADT_Candidatos]Documentos'ID:=$cadena
			Else 
				[ADT_Candidatos]Documentos'ID:=atADT_DID{Self:C308->}
			End if 
			SAVE RECORD:C53([ADT_Candidatos:49])
			v_certificado:=""
			v_idCertificado:=""
		End if 
End case 
