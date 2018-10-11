Case of 
	: (ALProEvt=2)
		$vl_line:=AL_GetLine (ALP_Pagares)
		$vl_idPagare:=alACTp_IDPagare{$vl_line}
		If ($vl_idPagare>0)
			CREATE SET:C116([ACT_Pagares:184];"setPagares")
			READ ONLY:C145([ACT_Pagares:184])
			QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]ID:12=$vl_idPagare)
			WDW_OpenFormWindow (->[ACT_Pagares:184];"Input";-1;8;"Pagaré número: "+String:C10([ACT_Pagares:184]Numero_Pagare:11);"wdwClose")
			KRL_ModifyRecord (->[ACT_Pagares:184];"Input")
			CLOSE WINDOW:C154
			USE SET:C118("setPagares")
			CLEAR SET:C117("setPagares")
			ACTcfg_OpcionesPagares ("CargaArreglosALP")
		End if 
End case 