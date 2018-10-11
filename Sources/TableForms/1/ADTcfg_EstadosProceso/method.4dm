ARRAY TEXT:C222(aEstadosRompeSecuencia;0)

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		hl_Estados:=New list:C375
		hl_Estados:=ADTcfg_LoadEstados 
		
		blobRompeSecuencia:=PREF_fGetBlob (0;"EstadosRompeSecuencia";blobRompeSecuencia)
		BLOB_Blob2Vars (->blobRompeSecuencia;0;->aEstadosRompeSecuencia)
		BLOB_Variables2Blob (->blobRompeSecuencia;0;->aEstadosRompeSecuencia)
		
		cb_SaltarEstados:=Num:C11(PREF_fGet (0;"SaltarEstadosADT";"0"))
		cb_IngresarMotivo:=Num:C11(PREF_fGet (0;"MotivoAlCambiarEstado";"0"))
		_O_DISABLE BUTTON:C193(bDelEstado)
		
		For ($i;1;Count list items:C380(hl_Estados))
			GET LIST ITEM:C378(hl_Estados;$i;$ref;$text)
			GET LIST ITEM PROPERTIES:C631(hl_Estados;$ref;$enterable)
			If (($ref<0) & ($ref>-100))
				
				If (Find in array:C230(aEstadosRompeSecuencia;$text)#-1)
					SET LIST ITEM PROPERTIES:C386(hl_Estados;$ref;$enterable;Bold:K14:2;0;0x00FF)
				Else 
					SET LIST ITEM PROPERTIES:C386(hl_Estados;$ref;$enterable;Bold:K14:2;0;-1)
				End if 
			Else 
				If (Find in array:C230(aEstadosRompeSecuencia;$text)#-1)
					SET LIST ITEM PROPERTIES:C386(hl_Estados;$ref;$enterable;Plain:K14:1;0;0x00FF)
				Else 
					SET LIST ITEM PROPERTIES:C386(hl_Estados;$ref;$enterable;Plain:K14:1;0;-1)
				End if 
			End if 
		End for 
		
		$estadoTerm:=Num:C11(PREF_fGet (0;"estadoTerminalADT";"0"))
		If ($estadoTerm=0)
			vMsgTerminal:=__ ("El estado terminal no ha sido establecido.")
		Else 
			$text:=HL_FindInListByReference (hl_Estados;$estadoTerm;True:C214)
			If ($estadoTerm<=-100)
				vMsgTerminal:=__ ("La situación terminal es ")+$text+"."
			Else 
				vMsgTerminal:=__ ("El estado terminal es ")+$text+"."
			End if 
		End if 
		
		$estadoRet:=Num:C11(PREF_fGet (0;"estadoRetiroADT";"0"))
		If ($estadoRet=0)
			vMsgRetiro:=__ ("El estado de retiro no ha sido establecido.")
		Else 
			$text:=HL_FindInListByReference (hl_Estados;$estadoRet;True:C214)
			If ($estadoRet<=-100)
				vMsgRetiro:=__ ("La situación de retiro es ")+$text+"."
			Else 
				vMsgRetiro:=__ ("El estado de retiro es ")+$text+"."
			End if 
		End if 
		
		$estadoRechazo:=Num:C11(PREF_fGet (0;"estadoRechazoADT";"0"))
		If ($estadoRechazo=0)
			vMsgRechazo:=__ ("El estado de rechazo no ha sido establecido.")
		Else 
			$text:=HL_FindInListByReference (hl_Estados;$estadoRechazo;True:C214)
			If ($estadoRechazo<=-100)
				vMsgRechazo:=__ ("La situación de rechazo es ")+$text+"."
			Else 
				vMsgRechazo:=__ ("El estado de rechazo es ")+$text+"."
			End if 
		End if 
		
		vMsgRS:=__ ("Estados que rompen secuencia")
		HL_CollapseAll (hl_Estados)
		SET LIST PROPERTIES:C387(hl_Estados;_o_Ala Macintosh:K28:1;0;18;1;0;0)
		_O_REDRAW LIST:C382(hl_Estados)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 
