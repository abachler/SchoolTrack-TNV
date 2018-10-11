//%attributes = {}
  //UD_v20121124_ACT_ArchivosContab

  //20121124 RCH para asignar id a los archivos de transferencia que pudieran no tener id forma de pago.
If (ACT_AccountTrackInicializado )
	STR_ReadGlobals 
	ACTfdp_CargaFormasDePago 
	ACTcfgfdp_OpcionesGenerales ("VerificaFormasDePagoXDef")
	
	READ WRITE:C146([xxACT_ArchivosBancarios:118])
	QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]Tipo:6="Contabilidad")
	APPLY TO SELECTION:C70([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=-17)
	KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])
End if 