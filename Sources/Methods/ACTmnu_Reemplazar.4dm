//%attributes = {}
  //ACTmnu_Reemplazar

vACT_BancoCodigo:=""
vACT_BancoNombre:=""
vACT_Cuenta:=""
vACT_FechaDoc:=!00-00-00!
vACT_Serie:=""
vACT_RUTTitular:=""
vACT_Titular:=""
vACT_BancoNombreTemp:=""
vACT_CuentaTemp:=""
vACT_SerieTemp:=""
vACT_FechaDocTemp:=!00-00-00!
vtACT_FechaDocTemp:=String:C10(vACT_FechaDocTemp;7)+"00"
vACT_TitularTemp:=""
vACT_RUTTitularTemp:=""
vACT_BancoCodigoTemp:=""

vtACT_TCAgnoVencimiento:=""
vtACT_TCBancoCodigo:=""
vtACT_TCBancoEmisor:=""
vtACT_TCMesVencimiento:=""
vtACT_TCDocumento:=""
vtACT_TCNumero:=""
vtACT_TCRUTTitular:=""
vtACT_TCTipo:=""
vtACT_TCTitular:=""
vtACT_TCCodigo:=""

vtACT_RDocumento:=""
  // Ticket 116401
vtACT_TDRUTTitular:=""
vtACT_TDTipo:=""
vtACT_TDTitular:=""
vtACT_TDCodigo:=""
vtACT_TDBancoEmisor:=""
vtACT_TDNumero:=""
vtACT_TDMesVencimiento:=""
vtACT_TDAgnoVencimiento:=""


vsACT_RUT:=""
vsACT_TipoDoc:=""
vlACT_idFormaDePago:=0
vlACT_idEstadoFormaDePago:=0

If (USR_GetMethodAcces (Current method name:C684))
	If (vb_RecordInInputForm)
		C_TEXT:C284($cargaDesde)
		If (Count parameters:C259>=1)
			$cargaDesde:=$1
		End if 
		If ($cargaDesde="terceros")
			ACTpp_ReemplazarCh ("terceros")
			ACTter_PageDocEnCartera 
		Else 
			ACTpp_ReemplazarCh 
			ACTpp_CargaALPPersonas (7)
			AL_SetLine (xALP_DocsenCartera;0)
		End if 
		  //ACTpp_ReemplazarCh 
		  //ACTpp_CargaALPPersonas (7)
		  //AL_SetLine (xALP_DocsenCartera;0)
		ACTpp_HabDesHabAcciones (False:C215)
	Else 
		ARRAY LONGINT:C221(abrSelect;0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		ARRAY LONGINT:C221(alACT_RecNumsDocs;Size of array:C274(abrSelect))
		For ($i;1;Size of array:C274(alACT_RecNumsDocs))
			alACT_RecNumsDocs{$i}:=alBWR_recordNumber{abrSelect{$i}}
		End for 
		READ ONLY:C145([ACT_Documentos_de_Pago:176])
		READ ONLY:C145([ACT_Documentos_en_Cartera:182])
		
		CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_en_Cartera:182];alACT_RecNumsDocs;"")
		QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Reemplazado:14=False:C215)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_en_Cartera:182];alACT_RecNumsDocs;"")
		
		If (Size of array:C274(alACT_RecNumsDocs)>0)
			ACTdc_CargaDCCreados ("InitArray")
			  //ALL RECORDS([ACT_Documentos_de_Pago])
			  //$vl_idDocPago:=Max([ACT_Documentos_de_Pago]ID)
			  //REDUCE SELECTION([ACT_Documentos_de_Pago];0)
			
			$vl_recNum:=alACT_RecNumsDocs{1}
			GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];$vl_recNum)
			If (ACTdc_DocumentoNoBloq ("Reemplazar";->[ACT_Documentos_en_Cartera:182]ID:1))
				READ WRITE:C146([ACT_Pagos:172])
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=[ACT_Documentos_de_Pago:176]ID:1)
				vACT_BancoCodigo:=[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8
				vACT_BancoNombre:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
				vACT_Cuenta:=[ACT_Documentos_de_Pago:176]Ch_Cuenta:11
				vACT_Serie:=""
				vACT_FechaDoc:=!00-00-00!
				vACT_RUTTitular:=[ACT_Documentos_de_Pago:176]RUTTitular:10
				vACT_Titular:=[ACT_Documentos_de_Pago:176]Titular:9
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
				
				ARRAY TEXT:C222(aACT_DocsReemp;0)
				WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTdc_Reemplazador";0;4;__ ("Reemplazo de Documentos"))
				DIALOG:C40([xxSTR_Constants:1];"ACTdc_Reemplazador")
				CLOSE WINDOW:C154
				KRL_UnloadReadOnly (->[ACT_Pagos:172])
			Else 
				ACTdc_DocumentoNoBloq ("ReemplazarMensaje")
			End if 
			ACTdc_DocumentoNoBloq ("ReemplazarLiberaRegistros")
			
		Else 
			CD_Dlog (0;__ ("Seleccione documentos en cartera no reemplazados."))
		End if 
		
		
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		USE SET:C118($set)
		ARRAY LONGINT:C221($al_disApdos;0)
		While (Not:C34(End selection:C36([ACT_Documentos_en_Cartera:182])))
			$vl_diDocPago:=Abs:C99([ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
			If (Find in array:C230($al_disApdos;[ACT_Documentos_en_Cartera:182]ID_Apoderado:2)=-1)
				APPEND TO ARRAY:C911($al_disApdos;[ACT_Documentos_en_Cartera:182]ID_Apoderado:2)
			End if 
			KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->$vl_diDocPago)
			ADD TO SET:C119([ACT_Documentos_en_Cartera:182];$set)
			NEXT RECORD:C51([ACT_Documentos_en_Cartera:182])
		End while 
		
		  //QUERY([ACT_Documentos_en_Cartera];[ACT_Documentos_en_Cartera]ID_DocdePago>=$vl_idDocPago)
		ACTdc_CargaDCCreados ("CargaNuevosDC")
		USE SET:C118($set)
		BWR_SelectTableData 
	End if 
End if 