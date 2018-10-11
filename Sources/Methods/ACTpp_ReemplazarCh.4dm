//%attributes = {}
  //ACTpp_ReemplazarCh
C_TEXT:C284($cargarDesde)
If (Count parameters:C259>=1)
	$cargarDesde:=$1
End if 
$line:=AL_GetLine (xALP_DocsenCartera)
$vb_idDctoCartera:=aACT_ApdosDCarID{$line}
If (ACTdc_DocumentoNoBloq ("Reemplazar";->$vb_idDctoCartera))
	  //$vl_idApdo:=[ACT_Documentos_de_Pago]ID_Apoderado
	If ($cargarDesde="terceros")
		$vl_idApdo:=[ACT_Documentos_de_Pago:176]ID_Tercero:48
	Else 
		$vl_idApdo:=[ACT_Documentos_de_Pago:176]ID_Apoderado:2
	End if 
	SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182];alACT_RecNumsDocs)
	vACT_BancoNombreTemp:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
	vACT_CuentaTemp:=[ACT_Documentos_de_Pago:176]Ch_Cuenta:11
	vACT_SerieTemp:=""
	vACT_FechaDocTemp:=!00-00-00!
	vtACT_FechaDocTemp:=String:C10(vACT_FechaDocTemp;7)+"00"
	vACT_TitularTemp:=[ACT_Documentos_de_Pago:176]Titular:9
	vACT_RUTTitularTemp:=[ACT_Documentos_de_Pago:176]RUTTitular:10
	vACT_BancoCodigoTemp:=[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8
	
	  //20120524 RCH
	vsACT_RUT:=[ACT_Documentos_de_Pago:176]RUTTitular:10
	vsACT_TipoDoc:=[ACT_Documentos_de_Pago:176]Tipodocumento:5
	vlACT_idFormaDePago:=[ACT_Documentos_de_Pago:176]id_forma_de_pago:51
	vlACT_idEstadoFormaDePago:=[ACT_Documentos_de_Pago:176]id_estado:53
	
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTdc_Reemplazador";0;4;__ ("Reemplazo de Documentos"))
	DIALOG:C40([xxSTR_Constants:1];"ACTdc_Reemplazador")
	CLOSE WINDOW:C154
	KRL_UnloadReadOnly (->[ACT_Pagos:172])
	  //KRL_FindAndLoadRecordByIndex (->[Personas]No;->$vl_idApdo;True)
	If ($cargarDesde="terceros")
		KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$vl_idApdo;True:C214)
	Else 
		KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$vl_idApdo;True:C214)
	End if 
Else 
	ACTdc_DocumentoNoBloq ("ReemplazarMensaje")
End if 
ACTdc_DocumentoNoBloq ("ReemplazarLiberaRegistros")