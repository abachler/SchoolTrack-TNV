Case of 
	: ((alProEvt=1) | (alProEvt=2) | (alProEvt=-1))
		If (USR_checkRights ("D";->[ACT_Cargos:173]))
			$line:=AL_GetLine (xALP_Transacciones)
			$item:=Selected list items:C379(hlTab_ACT_Transacciones)
			Case of 
				: ($item=3)
					If ($line>0)
						READ ONLY:C145([ACT_CuentasCorrientes:175])
						READ ONLY:C145([xxACT_ItemsMatriz:180])
						READ ONLY:C145([ACT_Documentos_de_Cargo:174])
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aACT_ItemIDs{$line})
						QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
						$noMatriz2:=([ACT_Documentos_de_Cargo:174]ID_Matriz:2=-2)
						QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=aIDCta{$line})
						QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=[ACT_CuentasCorrientes:175]ID_Matriz:7)
						QUERY SELECTION:C341([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Item:2=aACT_ApdosTRefItem{$line})
						$NoEnMatriz:=(Records in selection:C76([xxACT_ItemsMatriz:180])=0)
						$Especial:=ACTcar_EsCargoEspecial (aACT_ApdosTRefItem{$line})
						IT_SetButtonState ((($NoEnMatriz) | ($Especial) | ($noMatriz2));->bDelCargos)
					Else 
						_O_DISABLE BUTTON:C193(bDelCargos)
					End if 
				: ($item=2)
					IT_SetButtonState (($line#0);->bDelCargos)
			End case 
		Else 
			_O_DISABLE BUTTON:C193(bDelCargos)
		End if 
	: (alProEvt=-3)
		ARRAY TEXT:C222($aArraysNames;0)
		$err:=AL_GetArrayNames (xALP_Transacciones;$aArraysNames)
		AT_RedimArrays (Size of array:C274($aArraysNames);->aTransWidths)
		For ($i;1;Size of array:C274($aArraysNames))
			AL_GetWidths (xALP_Transacciones;$i;1;$temp)
			aTransWidths{$i}:=$temp
		End for 
End case 