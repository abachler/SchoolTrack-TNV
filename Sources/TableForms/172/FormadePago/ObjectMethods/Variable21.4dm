vbSpell_StopChecking:=True:C214
C_TEXT:C284(vsACT_FormasdePago;tempSelf;vsACT_OldFdP;$tempSelf)
$value:=""
$tempSelf:=Self:C308->
IT_Clairvoyance (Self:C308;->atACT_FormasdePagoNew2)
Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		  //IT_Clairvoyance (Self;->atACT_FormasdePagoNew)
	: (Form event:C388=On Getting Focus:K2:7)
		tempSelf:=Self:C308->
		vsACT_OldFdP:=Self:C308->
	: (Form event:C388=On Losing Focus:K2:8)
		If (Self:C308->="")
			Self:C308->:=$tempSelf
			IT_Clairvoyance (Self:C308;->atACT_FormasdePagoNew2)
			  //ACTinit_LoadFdPago 
			$page:=Find in array:C230(atACT_FormasdePagoNew;Self:C308->)
			If ($page#-1)
				$value:=atACT_FormasdePagoNew{$page}
			Else 
				$value:=""
			End if 
		Else 
			$page:=Find in array:C230(atACT_FormasdePagoNew;Self:C308->)
		End if 
		If ($page#-1)
			vlACT_FormasdePago:=alACT_FormasdePagoID{$page}
			Case of 
				: (vlACT_FormasdePago=-8)
					C_BOOLEAN:C305($msg)
					ACTcfg_LoadConfigData (8)
					ACTcfg_LoadConfigData (6)
					  //$catID:=Find in array(atACT_Categorias;"letra@")
					$catID:=Find in array:C230(alACT_IDsCats;-2)
					If (($catID>0) & (Size of array:C274(alACT_AñoTasaImpuesto)>0))
						  //alACT_IDCat{0}:=alACT_IDsCats{$catID}
						  //ARRAY LONGINT($DA_Return;0)
						  //AT_SearchArray (->alACT_IDCat;"=";->$DA_Return)
						  //If (Size of array($DA_Return)=1)
						  //vtACT_LDocumento:=String(alACT_Proxima{$DA_Return{1}})
						  //vl_indexLC:=$DA_Return{1}
						  //If (Num(vtACT_LDocumento)<=0)
						  //$msg:=True
						  //End if 
						  //Else 
						  //$msg:=True
						  //End if 
						
						  //***** 20140709 RCH MANEJO MULTINUMERACION *****
						C_LONGINT:C283($l_indice)
						$l_indice:=ACTlc_ObtieneIndex (alACT_IDsCats{$catID})
						If ($l_indice#0)
							vtACT_LDocumento:=String:C10(alACT_Proxima{$l_indice})
							vl_indexLC:=$l_indice
							If (Num:C11(vtACT_LDocumento)<=0)
								$msg:=True:C214
							End if 
						Else 
							$msg:=True:C214
						End if 
						  //***** MANEJO MULTINUMERACION *****
						
					Else 
						$msg:=True:C214
					End if 
					If ($msg)
						CD_Dlog (0;__ ("Antes de documentar en letras debe completar la configuración."))
						  //$page:=1
						ACTcfg_OpcionesFormasDePago ("InicializaVariablesIngresoPagos")
						$value:=vsACT_FormasdePago
						vdACT_LFechaVencimiento:=!00-00-00!
						vtACT_LFechaVencimiento:=""
						vtACT_LFechaEmision:=""
						vdACT_LFechaEmision:=!00-00-00!
						vtACT_LTitular:=""
						vtACT_LRUTTitular:=""
					Else 
						vdACT_LFechaVencimiento:=Current date:C33(*)
						vtACT_LFechaVencimiento:=String:C10(Current date:C33(*);7)
						vtACT_LFechaEmision:=String:C10(Current date:C33(*);7)
						vdACT_LFechaEmision:=Current date:C33(*)
						Case of 
							: (vbACT_PagoXApdo)
								vtACT_LTitular:=[Personas:7]Apellidos_y_nombres:30
								vtACT_LRUTTitular:=[Personas:7]RUT:6
							: (vbACTpgs_PagoXTercero)
								vtACT_LTitular:=[ACT_Terceros:138]Nombre_Completo:9
								vtACT_LRUTTitular:=[ACT_Terceros:138]RUT:4
						End case 
					End if 
			End case 
			
			If ($value#"")
				Self:C308->:=$value
			End if 
			vtACT_PagoMsg:=__ ("Para el pago con ")+atACT_FormasdePagoNew{$page}+__ (" no se requieren datos adicionales.")
			  //ACTcfg_OpcionesFormasDePago ("InicializaVariablesIngresoPagos")
			ACTcfg_OpcionesFormasDePago ("CargaCuentasContables";->vsACT_FormasdePago;->vlACT_FormasdePago)
			ACTcfg_OpcionesFormasDePago ("GOTOPAGE";->vlACT_FormasdePago)
			
			  //20180228 RCH Ticket 194134
			  //GOTO OBJECT(vrACT_MontoPago)
			Case of 
				: (vlACT_FormasdePago=-4)  //cheque
					GOTO OBJECT:C206(vtACT_BancoCuenta)
				: (vlACT_FormasdePago=-6)  //TC
					GOTO OBJECT:C206(vtACT_TCDocumento)
				: (vlACT_FormasdePago=-7)  //TD
					GOTO OBJECT:C206(vtACT_RDocumento)
				: (vlACT_FormasdePago=-8)  //Letra
					GOTO OBJECT:C206(vtACT_LDocumento)
				Else 
					GOTO OBJECT:C206(vrACT_MontoPago)
			End case 
			
		Else 
			BEEP:C151
			Self:C308->:=tempSelf
			atACT_FormasdePagoNew:=Find in array:C230(atACT_FormasdePagoNew;tempSelf)
			GOTO OBJECT:C206(vsACT_FormasdePago)
		End if 
		vbSpell_StopChecking:=True:C214
End case 