If (alProEvt=AL Single click event)
	$line:=AL_GetLine (Self:C308->)
	
	If ($line>0)
		$recNum:=alMPA_RecNumMatriz{$line}
		GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$recNum)
		GET LIST ITEM:C378(hl_Periodos2;Selected list items:C379(hl_Periodos);$refPeriodo;$itemText)
		AL_UpdateArrays (xALP_LogrosAsignaturas;0)
		MPAmtx_LeeConfiguracion ($recNum;1;->alEVLG_AdvCFG_TipoObjeto;->alEVLG_AdvCFG_Ids;->atEVLG_AdvCFG_EjesLogros;->atEVLG_AdvCFG_Icons)
		AL_UpdateArrays (xALP_LogrosAsignaturas;-2)
		
		
		If ([MPA_AsignaturasMatrices:189]CreadaPor:15#"")
			$createdBy:="Creada por: \r"+[MPA_AsignaturasMatrices:189]CreadaPor:15+" el "
		Else 
			$createdBy:="Creada el: "
		End if 
		If ([MPA_AsignaturasMatrices:189]CreadaPor:15#"")
			$modifiedBy:="\rModificada por: \r"+[MPA_AsignaturasMatrices:189]ModificadaPor:17+" el "
		Else 
			$modifiedBy:="\rModificada el: "
		End if 
		vtEVLG_InfoConfig:=$createdBy+String:C10(DTS_GetDate ([MPA_AsignaturasMatrices:189]DTS_Creacion:16))+", "+String:C10(DTS_GetTime ([MPA_AsignaturasMatrices:189]DTS_Creacion:16);2)
		vtEVLG_InfoConfig:=vtEVLG_InfoConfig+"\r"+$modifiedBy+String:C10(DTS_GetDate ([MPA_AsignaturasMatrices:189]DTS_Modificacion:18))+", "+String:C10(DTS_GetTime ([MPA_AsignaturasMatrices:189]DTS_Modificacion:18);2)
		
		POST KEY:C465(Character code:C91("=");256)
	Else 
		_O_DISABLE BUTTON:C193(bSetConfig)
	End if 
	
End if 