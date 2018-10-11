READ WRITE:C146([xxACT_TransferenciaBancaria:131])
For ($i;1;Size of array:C274(at_ACTNombreCampo))
	QUERY:C277([xShell_Fields:52];[xShell_Fields:52]ID:24=al_idCampos{$i})
	If (Records in selection:C76([xShell_Fields:52])>0)
		
		  //QUERY([xxACT_TransferenciaBancaria];[xxACT_TransferenciaBancaria]id_xShellFields=[xShell_Fields]ID)
		
		QUERY:C277([xxACT_TransferenciaBancaria:131];[xxACT_TransferenciaBancaria:131]Tabla_Número:2=[xShell_Fields:52]NumeroTabla:1;*)
		QUERY:C277([xxACT_TransferenciaBancaria:131]; & ;[xxACT_TransferenciaBancaria:131]Campo_Número:3=[xShell_Fields:52]NumeroCampo:2)
		
		If (Records in selection:C76([xxACT_TransferenciaBancaria:131])=0)
			CREATE RECORD:C68([xxACT_TransferenciaBancaria:131])
			[xxACT_TransferenciaBancaria:131]id_tabla:1:=SQ_SeqNumber (->[xxACT_TransferenciaBancaria:131]id_tabla:1)
		End if 
		[xxACT_TransferenciaBancaria:131]Tabla_Número:2:=[xShell_Fields:52]NumeroTabla:1
		[xxACT_TransferenciaBancaria:131]Campo_Número:3:=[xShell_Fields:52]NumeroCampo:2
		[xxACT_TransferenciaBancaria:131]EnPAT:4:=ab_EnPAT{$i}
		[xxACT_TransferenciaBancaria:131]EnPAC:5:=ab_EnPAC{$i}
		[xxACT_TransferenciaBancaria:131]EnCuponera:6:=ab_EnCUPONERA{$i}
		[xxACT_TransferenciaBancaria:131]EnContabilidad:7:=ab_EnCONTABILIDAD{$i}
		[xxACT_TransferenciaBancaria:131]id_xShellFields:8:=al_idCampos{$i}
		SAVE RECORD:C53([xxACT_TransferenciaBancaria:131])
	End if 
End for 
KRL_UnloadReadOnly (->[xxACT_TransferenciaBancaria:131])
ACTwtrf_SaveLibrary 
AT_Initialize (->at_ACTNombreCampo;->ab_EnPAT;->ab_EnPAC;->ab_EnCUPONERA;->ab_EnCONTABILIDAD;->at_ACTNombreCampoAL;->ab_EnPATAL;->ab_EnPACAL;->ab_EnCUPONERAAL;->ab_EnCONTABILIDADAL;->ai_ACTTipoExportacion)