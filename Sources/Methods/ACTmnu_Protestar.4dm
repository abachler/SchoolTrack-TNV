//%attributes = {}
  //ACTmnu_Protestar

If (USR_GetMethodAcces (Current method name:C684))
	If (vb_RecordInInputForm)
		C_TEXT:C284($cargarDesde)
		C_TEXT:C284($yearName)
		$yearName:=aYearsACT{aYearsACT}
		If (Count parameters:C259=1)
			$cargarDesde:=$1
		End if 
		$line:=AL_GetLine (xALP_DocsDepositados)
		$vl_idDocPago:=aACT_ApdosDDID{$line}
		If (ACTdc_DocumentoNoBloq ("Protestar";->$vl_idDocPago))
			ARRAY LONGINT:C221(alACT_RecNumsDocs;1)
			alACT_RecNumsDocs{1}:=Record number:C243([ACT_Documentos_de_Pago:176])
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTdd_Protestador";0;4;__ ("Protestar Documentos Depositados"))
			DIALOG:C40([xxSTR_Constants:1];"ACTdd_Protestador")
			CLOSE WINDOW:C154
		Else 
			ACTdc_DocumentoNoBloq ("ProtestarMensaje")
		End if 
		ACTdc_DocumentoNoBloq ("ProtestarLiberaRegistros")
		
		If ($cargarDesde="terceros")
			ACTter_PageDocDepositados ($yearName)
		Else 
			AL_UpdateArrays (xALP_DocsDepositados;0)
			ACTpp_LoadDocsDepositados 
			AL_UpdateArrays (xALP_DocsDepositados;-2)
			AL_SetLine (xALP_DocsDepositados;0)
		End if 
		
		  //AL_UpdateArrays (xALP_DocsDepositados;0)
		  //ACTpp_LoadDocsDepositados 
		  //AL_UpdateArrays (xALP_DocsDepositados;-2)
		  //AL_SetLine (xALP_DocsDepositados;0)
		
		_O_DISABLE BUTTON:C193(bProtestar)
	Else 
		ARRAY LONGINT:C221(abrSelect;0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		ARRAY LONGINT:C221(alACT_RecNumsDocs;Size of array:C274(abrSelect))
		For ($i;1;Size of array:C274(alACT_RecNumsDocs))
			alACT_RecNumsDocs{$i}:=alBWR_recordNumber{abrSelect{$i}}
		End for 
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTdd_Protestador";0;4;__ ("Protestar Documentos Depositados"))
		DIALOG:C40([xxSTR_Constants:1];"ACTdd_Protestador")
		CLOSE WINDOW:C154
		USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(->[ACT_Documentos_de_Pago:176])))
		BWR_SelectTableData 
	End if 
End if 
