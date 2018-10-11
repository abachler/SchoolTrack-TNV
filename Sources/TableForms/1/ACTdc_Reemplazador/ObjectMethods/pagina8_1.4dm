
C_TEXT:C284(vtACT_DocsReemp)
vtACT_DocsReemp:=AT_array2text (->aACT_DocsReemp)

  //mismo cheque no va porque el monto puede variar
If (Substring:C12(vtACT_DocsReemp;1;1)#"(")
	vtACT_DocsReemp:="("+vtACT_DocsReemp
End if 

  //varios cheques
$vt_variosCheques:=ST_GetWord (vtACT_DocsReemp;2;";")
$vt_variosCheques2:="("+$vt_variosCheques
vtACT_DocsReemp:=Replace string:C233(vtACT_DocsReemp;$vt_variosCheques;$vt_variosCheques2)

$choice:=Pop up menu:C542(vtACT_DocsReemp)
If ($choice>0)
	vrACT_MontoAReemplazarXFP:=0
	vsACT_DocsReemp2:=aACT_DocsReemp{$choice}
	vlACT_ReempPor2:=alACT_IDFormasdePago{$choice}
	vtACT_PagoMsg:=__ ("Para el reemplazo con ")+aACT_DocsReemp{$choice}+__ (" no se requieren datos adicionales.")
	Case of 
		: ($choice=(vl_indiceFormasDePago))  //Efectivo
			
		: ($choice=1)  //Mismo cheque
			vACT_BancoNombre:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
			vACT_Cuenta:=[ACT_Documentos_de_Pago:176]Ch_Cuenta:11
			vACT_Serie:=[ACT_Documentos_de_Pago:176]NoSerie:12
			vACT_FechaDoc:=[ACT_Documentos_de_Pago:176]Fecha:13
			If (vACT_FechaDoc=!00-00-00!)
				vACT_FechaDoc:=Current date:C33(*)
			End if 
			vtACT_FechaDoc:=String:C10(vACT_FechaDoc;7)
			vACT_Titular:=[ACT_Documentos_de_Pago:176]Titular:9
			vACT_RUTTitular:=[ACT_Documentos_de_Pago:176]RUTTitular:10
			vACT_BancoCodigo:=[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8
			
		: ($choice=(vl_indiceFormasDePago+1))  //Otro cheque
			vACT_BancoNombre:=vACT_BancoNombreTemp
			vACT_Cuenta:=vACT_CuentaTemp
			vACT_Serie:=vACT_SerieTemp
			vACT_FechaDoc:=vACT_FechaDocTemp
			If (vACT_FechaDoc=!00-00-00!)
				vACT_FechaDoc:=Current date:C33(*)
			End if 
			vtACT_FechaDoc:=String:C10(vACT_FechaDoc;7)
			vACT_Titular:=vACT_TitularTemp
			vACT_RUTTitular:=vACT_RUTTitularTemp
			vACT_BancoCodigo:=vACT_BancoCodigoTemp
			
		: ($choice=(vl_indiceFormasDePago+2))  //Tarjeta de Credito
			
		: ($choice=(vl_indiceFormasDePago+4))  //Letra
			C_BOOLEAN:C305($msg)
			ACTcfg_LoadConfigData (8)
			ACTcfg_LoadConfigData (6)
			  //$catID:=Find in array(atACT_Categorias;"letra@")
			$catID:=Find in array:C230(alACT_IDsCats;-2)
			If (($catID>0) & (Size of array:C274(alACT_AñoTasaImpuesto)>0))
				alACT_IDCat{0}:=alACT_IDsCats{$catID}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->alACT_IDCat;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)=1)
					vtACT_LDocumento:=String:C10(alACT_Proxima{$DA_Return{1}})
					vl_indexLC:=$DA_Return{1}
					If (Num:C11(vtACT_LDocumento)<=0)
						$msg:=True:C214
					End if 
				Else 
					$msg:=True:C214
				End if 
			Else 
				$msg:=True:C214
			End if 
			If ($msg)
				vdACT_LFechaVencimiento:=!00-00-00!
				vtACT_LFechaVencimiento:=""
				vtACT_LFechaEmision:=""
				vdACT_LFechaEmision:=!00-00-00!
				vtACT_LTitular:=""
				vtACT_LRUTTitular:=""
				vsACT_DocsReemp2:=aACT_DocsReemp{vl_indiceFormasDePago}
				vlACT_ReempPor2:=vl_indiceFormasDePago
				vtACT_PagoMsg:="Para el reemplazo con "+aACT_DocsReemp{vl_indiceFormasDePago}+" no se requieren datos adicionales."
				CD_Dlog (0;__ ("Antes de documentar en letras debe completar la configuración."))
			Else 
				C_REAL:C285(vrACT_MontoPago)
				vdACT_LFechaVencimiento:=Current date:C33(*)
				vtACT_LFechaVencimiento:=String:C10(Current date:C33(*);7)
				vtACT_LFechaEmision:=String:C10(Current date:C33(*);7)
				vdACT_LFechaEmision:=Current date:C33(*)
				vtACT_LTitular:=[ACT_Documentos_de_Pago:176]Titular:9
				vtACT_LRUTTitular:=[ACT_Documentos_de_Pago:176]RUTTitular:10
				vrACT_MontoPago:=vrACT_Monto
				
			End if 
			
		: ($choice=(vl_indiceFormasDePago+3))  //Redcompr
			
		: ($choice=2)  //Varios cheques
			
		Else 
			vtACT_PagoMsg:=__ ("Para el reemplazo con ")+aACT_DocsReemp{$choice}+__ (" no se requieren datos adicionales.")
			
	End case 
	
	ACTdc_OpcionesReemplazoMasivo ("ObjetosPagina8")
	
End if 