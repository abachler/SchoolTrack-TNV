If (ADTcdd_esRegistroValido )
	
	If (vEstadoActualIdx>1)
		vEstadoActualIdx:=vEstadoActualIdx-1
		$oldEstado:=[ADT_Candidatos:49]ID_Estado:49
		$oldSitFinal:=[ADT_Candidatos:49]ID_SitFinal:51
		[ADT_Candidatos:49]ID_Estado:49:=alADT_TresEstados{vEstadoActualIdx}
		OBJECT SET VISIBLE:C603(*;"lista_espera@";[ADT_Candidatos:49]ID_Estado:49=-4)
		If ([ADT_Candidatos:49]ID_Estado:49#0)
			$text:=HL_FindInListByReference (hl_Estados;[ADT_Candidatos:49]ID_Estado:49)
			[ADT_Candidatos:49]Estado:52:=$text
			CREATE RECORD:C68([xxADT_LogCambioEstado:162])
			[xxADT_LogCambioEstado:162]ID_Candidato:1:=[ADT_Candidatos:49]Candidato_numero:1
			[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4:=[ADT_Candidatos:49]ID_Estado:49
			[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3:=$oldEstado
			[xxADT_LogCambioEstado:162]ID_Usuario:5:=USR_GetUserID 
			[xxADT_LogCambioEstado:162]DTS:2:=DTS_MakeFromDateTime 
			SAVE RECORD:C53([xxADT_LogCambioEstado:162])
			UNLOAD RECORD:C212([xxADT_LogCambioEstado:162])
			SAVE RECORD:C53([ADT_Candidatos:49])
			
			HL_ExpandAll (hl_EstadosGeneral)
			$estGral:=List item position:C629(hl_EstadosGeneral;[ADT_Candidatos:49]ID_Estado:49)
			GET LIST ITEM:C378(hl_EstadosGeneral;$estGral;$refGral;$textGral;$sublist;$expanded)
			If ($sublist=0)
				If ($oldSitFinal#[ADT_Candidatos:49]ID_Estado:49)
					[ADT_Candidatos:49]ID_SitFinal:51:=[ADT_Candidatos:49]ID_Estado:49
					[ADT_Candidatos:49]Situación_final:16:=[ADT_Candidatos:49]Estado:52
					SAVE RECORD:C53([ADT_Candidatos:49])
				End if 
				HL_ClearList (hl_SitFinal)
				hl_SitFinal:=New list:C375
				APPEND TO LIST:C376(hl_SitFinal;$text;[ADT_Candidatos:49]ID_Estado:49)
				SELECT LIST ITEMS BY POSITION:C381(hl_SitFinal;1)
				_O_REDRAW LIST:C382(hl_SitFinal)
			Else 
				HL_ClearList (hl_SitFinal)
				hl_SitFinal:=New list:C375
				$j:=1
				For ($i;Count list items:C380(hl_EstadosGeneral);1;-1)
					GET LIST ITEM:C378(hl_EstadosGeneral;$i;$ref;$text)
					If ($ref<=-100)
						$parent:=List item parent:C633(hl_EstadosGeneral;$ref)
						If ($parent=[ADT_Candidatos:49]ID_Estado:49)
							If (Count list items:C380(hl_SitFinal)=0)
								APPEND TO LIST:C376(hl_SitFinal;$text;$ref)
							Else 
								GET LIST ITEM:C378(hl_SitFinal;$j;$refSF;$textSF)
								INSERT IN LIST:C625(hl_SitFinal;$refSF;$text;$ref)
							End if 
						End if 
						$j:=$j+1
					End if 
				End for 
				SELECT LIST ITEMS BY POSITION:C381(hl_SitFinal;1)
				GET LIST ITEM:C378(hl_SitFinal;*;$ref;$text)
				If ([ADT_Candidatos:49]ID_SitFinal:51#$ref)
					[ADT_Candidatos:49]ID_SitFinal:51:=$ref
					[ADT_Candidatos:49]Situación_final:16:=$text
					SAVE RECORD:C53([ADT_Candidatos:49])
				End if 
				_O_REDRAW LIST:C382(hl_SitFinal)
			End if 
		Else 
			HL_ClearList (hl_SitFinal)
			hl_SitFinal:=New list:C375
			[ADT_Candidatos:49]Estado:52:="Indeterminado"
			[ADT_Candidatos:49]ID_Estado:49:=0
			[ADT_Candidatos:49]ID_SitFinal:51:=0
			[ADT_Candidatos:49]Situación_final:16:=[ADT_Candidatos:49]Estado:52
			APPEND TO LIST:C376(hl_SitFinal;[ADT_Candidatos:49]Estado:52;[ADT_Candidatos:49]ID_Estado:49)
			SELECT LIST ITEMS BY POSITION:C381(hl_SitFinal;1)
			CREATE RECORD:C68([xxADT_LogCambioEstado:162])
			[xxADT_LogCambioEstado:162]ID_Candidato:1:=[ADT_Candidatos:49]Candidato_numero:1
			[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4:=[ADT_Candidatos:49]ID_Estado:49
			[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3:=$oldEstado
			[xxADT_LogCambioEstado:162]ID_Usuario:5:=USR_GetUserID 
			[xxADT_LogCambioEstado:162]DTS:2:=DTS_MakeFromDateTime 
			SAVE RECORD:C53([xxADT_LogCambioEstado:162])
			UNLOAD RECORD:C212([xxADT_LogCambioEstado:162])
			SAVE RECORD:C53([ADT_Candidatos:49])
		End if 
		IT_SetButtonState ((vEstadoActualIdx>1);Self:C308)
		_O_ENABLE BUTTON:C192(bNextEstado)
	End if 
	
	$estadoTerm:=Num:C11(PREF_fGet (0;"estadoTerminalADT";"0"))
	$cond:=(([ADT_Candidatos:49]ID_SitFinal:51=$estadoTerm) & ($estadoTerm#0))
	OBJECT SET VISIBLE:C603(*;"acceptOTF@";$cond)
	
End if 