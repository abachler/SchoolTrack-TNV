//%attributes = {"executedOnServer":true}
  // CMT_CargaLibreria()
  // 
  //
  // creado por: Alberto Bachler Klein: 22-12-16, 11:42:48
  // -----------------------------------------------------------

$t_rutaDocumento:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+"CMTCamposUtilizados.txt"
CMT_FTP_Settings ("Read")

If (<>vl_CMT_OnOff=1)
	SET CHANNEL:C77(10;$t_rutaDocumento)
	If (ok=1)
		OK:=1
		$vt_retorno:=CMT_Transferencia ("LimpiaTabla")
		If ($vt_retorno="1")
			If (OK=1)
				RECEIVE VARIABLE:C81(nbRecords)
				For ($i;1;nbRecords)
					RECEIVE RECORD:C79([CMT_Transferencia:158])
					[CMT_Transferencia:158]Id:1:=0  //para asignar nuevo id en la configuracion
					SAVE RECORD:C53([CMT_Transferencia:158])
				End for 
			End if 
		Else 
			LOG_RegisterEvt ("Los registros asociados a la aplicación CMT no pudieron ser eliminados.")
		End if 
		SET CHANNEL:C77(11)
	End if 
End if 