If ([ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-8)
	If (Substring:C12(DocsReemp;1;1)#"(")
		DocsReemp:="("+DocsReemp
	End if 
Else 
	If (Substring:C12(DocsReemp;1;1)="(")
		DocsReemp:=Substring:C12(DocsReemp;2;Length:C16(DocsReemp))
	End if 
End if 
$choice:=Pop up menu:C542(DocsReemp)
If ($choice>0)
	vsACT_DocsReemp:=aACT_DocsReemp{$choice}
	vlACT_ReempPor:=$choice
	vtACT_PagoMsg:=__ ("Para el reemplazo con ")+aACT_DocsReemp{$choice}+__ (" no se requieren datos adicionales.")
	Case of 
		: ($choice=(vl_indiceFormasDePago))  //Efectivo
			OBJECT SET VISIBLE:C603(vtACT_PagoMsg;True:C214)
			FORM GOTO PAGE:C247(1)
		: ($choice=1)  //Mismo cheque
			vACT_BancoNombre:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
			vACT_Cuenta:=[ACT_Documentos_de_Pago:176]Ch_Cuenta:11
			vACT_Serie:=[ACT_Documentos_de_Pago:176]NoSerie:12
			vACT_FechaDoc:=[ACT_Documentos_de_Pago:176]Fecha:13
			vtACT_FechaDoc:=String:C10(vACT_FechaDoc;7)
			vACT_Titular:=[ACT_Documentos_de_Pago:176]Titular:9
			vACT_RUTTitular:=[ACT_Documentos_de_Pago:176]RUTTitular:10
			vACT_BancoCodigo:=[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8
			OBJECT SET VISIBLE:C603(vtACT_PagoMsg;False:C215)
			FORM GOTO PAGE:C247(2)
		: ($choice=(vl_indiceFormasDePago+1))  //Otro cheque
			vACT_BancoNombre:=vACT_BancoNombreTemp
			vACT_Cuenta:=vACT_CuentaTemp
			vACT_Serie:=vACT_SerieTemp
			vACT_FechaDoc:=vACT_FechaDocTemp
			vACT_Titular:=vACT_TitularTemp
			vtACT_FechaDoc:=vtACT_FechaDocTemp
			vACT_RUTTitular:=vACT_RUTTitularTemp
			vACT_BancoCodigo:=vACT_BancoCodigoTemp
			OBJECT SET VISIBLE:C603(vtACT_PagoMsg;False:C215)
			FORM GOTO PAGE:C247(3)
		: ($choice=(vl_indiceFormasDePago+2))  //Tarjeta de Credito
			OBJECT SET VISIBLE:C603(vtACT_PagoMsg;False:C215)
			FORM GOTO PAGE:C247(4)
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
				FORM GOTO PAGE:C247(1)
				OBJECT SET VISIBLE:C603(vtACT_PagoMsg;True:C214)
				vsACT_DocsReemp:=aACT_DocsReemp{vl_indiceFormasDePago}
				vlACT_ReempPor:=vl_indiceFormasDePago
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
				OBJECT SET VISIBLE:C603(vtACT_PagoMsg;False:C215)
				FORM GOTO PAGE:C247(5)
			End if 
		: ($choice=(vl_indiceFormasDePago+3))  //Redcompr
			OBJECT SET VISIBLE:C603(vtACT_PagoMsg;False:C215)
			FORM GOTO PAGE:C247(6)
		: ($choice=2)  //Varios cheques
			ACTpgs_InitArraysDocumentar ("LimpiaVarsFormP7")
			If (Size of array:C274(atACT_BancoNombre)>0)
				AL_UpdateArrays (xALP_Documentar;0)
				ACTpgs_InitArraysDocumentar ("DeclaraArrays")
				AL_UpdateArrays (xALP_Documentar;-2)
			End if 
			FORM GOTO PAGE:C247(7)
		Else 
			vtACT_PagoMsg:=__ ("Para el reemplazo con ")+aACT_DocsReemp{$choice}+__ (" no se requieren datos adicionales.")
			OBJECT SET VISIBLE:C603(vtACT_PagoMsg;True:C214)
			FORM GOTO PAGE:C247(1)
	End case 
End if 