Case of 
	: (Form event:C388=On Clicked:K2:4)
		_O_C_INTEGER:C282($indice)
		If (v_certificado#"")
			$indice:=Find in array:C230(atADT_DID;v_idCertificado)
			If ($indice#-1)
				
				  //```````````````
				If (abADT_DElectronico{$indice})
					ADTcdd_GetFile (atADT_DID{$indice};[Alumnos:2]numero:1)
					
					  //```````````````
				End if 
			Else 
				CD_Dlog (1;__ ("No hay documento a abrir"))
			End if 
		End if 
End case 