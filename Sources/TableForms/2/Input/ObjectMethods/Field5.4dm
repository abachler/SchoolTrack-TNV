Case of 
	: (<>vtXS_CountryCode="cl")
		IT_clairvoyanceOnFields2 (Self:C308;->[xxSTR_Comunas:94]Nombre_comuna:7)
	Else 
		IT_Clairvoyance (Self:C308;-><>aComuna;"Comunas")
End case 

Case of 
	: (Form event:C388=On Data Change:K2:15)
		$text:=Get edited text:C655
		If (([Familia:78]Comuna:8#"") & ([Familia:78]Comuna:8#Old:C35([Familia:78]Comuna:8)))
			Case of 
				: (<>vtXS_CountryCode="cl")
					READ ONLY:C145([xxSTR_Comunas:94])
					QUERY:C277([xxSTR_Comunas:94];[xxSTR_Comunas:94]Nombre_comuna:7=[Familia:78]Comuna:8;*)
					QUERY:C277([xxSTR_Comunas:94];[xxSTR_Comunas:94]Pais:10=<>gPais)
					If (Records in selection:C76([xxSTR_Comunas:94])>0)
						
					Else 
						CD_Dlog (0;[Familia:78]Comuna:8+__ (" no es una comuna oficial en ")+<>gPais+__ ("."))
						[Familia:78]Comuna:8:=""
					End if 
				Else 
					  //nada 
			End case 
			If ([Familia:78]Comuna:8#"")
				$el:=Find in array:C230(<>aComuna;[Familia:78]Comuna:8)
				If ($el<0)
					READ WRITE:C146([xShell_List:39])
					QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Comunas")
					$value:=ST_Format (->[Familia:78]Comuna:8;->[xShell_List:39]Listname:1)
					INSERT IN ARRAY:C227(<>aComuna;1;1)
					<>aComuna{1}:=$value
					SORT ARRAY:C229(<>aComuna)
					  //BLOB_Variables2Blob (->[xShell_List]Contents;0;-><>aComuna)
					  //SAVE RECORD([xShell_List])
					  //20140107 ASM Ticket  128514
					TBL_SaveListAndArrays (-><>aComuna)
					UNLOAD RECORD:C212([xShell_List:39])
					[Familia:78]Comuna:8:=$value
				Else 
					[Familia:78]Comuna:8:=<>aComuna{$el}
				End if 
			End if 
		Else 
			Case of 
				: (<>vtXS_CountryCode="cl")
					If (($text#"") & ([Familia:78]Comuna:8="") & (<>vtXS_CountryCode="cl"))
						CD_Dlog (0;$text+__ (" no es una comuna oficial en ")+<>gPais+__ ("."))
					End if 
				Else 
					  //nada
			End case 
		End if 
		If (Form event:C388=On Data Change:K2:15)
			AL_ActualizaDireccionFamilia (Self:C308)
		End if 
End case 