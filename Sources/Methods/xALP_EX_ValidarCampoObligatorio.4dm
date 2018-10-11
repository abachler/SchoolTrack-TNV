//%attributes = {}
  //xALP_EX_ValidarCampoObligatorio

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($col;$row;$id)
C_TEXT:C284($idCampo)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	
	  //celda seleccionada
	AL_GetCurrCell (xALP_CamposFormulario;$col;$row)
	
	Case of 
		: ($col=1)
			
			AL_GetCellValue (xALP_CamposFormulario;$row;4;$idCampo)
			$id:=Num:C11($idCampo)
			
			READ ONLY:C145([xxADT_MetaDataDefinition:79])
			QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]ID:1=$id)
			$valor:=String:C10(abCampoObligatorio{$row})
			If ([xxADT_MetaDataDefinition:79]Es Obligatorio:16=True:C214)
				
				If ($valor="False")
					CD_Dlog (1;__ ("Campo seleccionado debe ser obligatorio"))
					abCampoObligatorio{$row}:=True:C214
				End if 
			Else 
				Case of 
					: ($valor="True")
						AL_SetRowStyle (xALP_CamposFormulario;$row;1)
					: ($valor="False")
						AL_SetRowStyle (xALP_CamposFormulario;$row;0)
				End case 
				
			End if 
			
			AL_UpdateArrays (xALP_CamposFormulario;-2)
	End case 
End if 