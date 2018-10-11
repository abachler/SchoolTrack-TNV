//%attributes = {}
  // TGR_xShellTablesRelatedFiles()
  // Por: Alberto Bachler K.: 08-04-15, 16:57:11
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	$b_registroValido:=(Is table number valid:C999([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11)) & (Is field number valid:C1000([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3))
	$b_registroValido:=$b_registroValido & (Is table number valid:C999([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1)) & (Is field number valid:C1000([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4))
	
	If ($b_registroValido)
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[xShell_Tables_RelatedFiles:243]OrigenRelacion_RefTablaCampo:12:=KRL_MakeStringAccesKey (->[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;->[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)
				[xShell_Tables_RelatedFiles:243]DestinoRelacion_RefTablaCampo:13:=KRL_MakeStringAccesKey (->[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;->[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4)
				[xShell_Tables_RelatedFiles:243]ReferenciaUnica:15:=String:C10([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;"00000")+"."+String:C10([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3;"00000")+"->"+String:C10([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;"00000")+"."+String:C10([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4;"00000")
				[xShell_Tables_RelatedFiles:243]OrigenRelacion_NombreCampo:16:="["+Table name:C256([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11)+"]"+Field name:C257([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)
				[xShell_Tables_RelatedFiles:243]DestinoRelacion_NombreCampo:8:="["+Table name:C256([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1)+"]"+Field name:C257([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4)
				[xShell_Tables_RelatedFiles:243]DTS_modificacion:14:=DTS_Get_GMT_TimeStamp 
				
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				
				
				[xShell_Tables_RelatedFiles:243]OrigenRelacion_RefTablaCampo:12:=KRL_MakeStringAccesKey (->[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;->[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)
				[xShell_Tables_RelatedFiles:243]ReferenciaUnica:15:=[xShell_Tables_RelatedFiles:243]OrigenRelacion_RefTablaCampo:12+"->"+[xShell_Tables_RelatedFiles:243]DestinoRelacion_RefTablaCampo:13
				[xShell_Tables_RelatedFiles:243]DestinoRelacion_RefTablaCampo:13:=KRL_MakeStringAccesKey (->[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;->[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4)
				[xShell_Tables_RelatedFiles:243]ReferenciaUnica:15:=String:C10([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;"00000")+"."+String:C10([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3;"00000")+"->"+String:C10([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;"00000")+"."+String:C10([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4;"00000")
				[xShell_Tables_RelatedFiles:243]OrigenRelacion_NombreCampo:16:="["+Table name:C256([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11)+"]"+Field name:C257([xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)
				[xShell_Tables_RelatedFiles:243]DestinoRelacion_NombreCampo:8:="["+Table name:C256([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1)+"]"+Field name:C257([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4)
				
				
				If (KRL_RegistroFueModificado (->[xShell_Tables_RelatedFiles:243]))
					[xShell_Tables_RelatedFiles:243]DTS_modificacion:14:=DTS_Get_GMT_TimeStamp 
				End if 
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
	End if 
End if 