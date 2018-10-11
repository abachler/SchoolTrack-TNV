  //FormasdePago:=AT_array2text (->atACT_FormasdePago)
$FormasdePago:=AT_array2text (->atACT_FormasdePagoNew)
$choice:=Pop up menu:C542($FormasdePago)
If ($choice>0)
	  //vsACT_FormasdePago:=atACT_FormasdePago{$choice}
	  //ACTcfg_OpcionesFormasDePago ("InicializaVariablesIngresoPagos")
	vlACT_FormasdePago:=alACT_FormasdePagoID{$choice}
	vsACT_FormasdePago:=atACT_FormasdePagoNew{$choice}
	ACTcfg_OpcionesFormasDePago ("CargaCuentasContables";->vsACT_FormasdePago;->vlACT_FormasdePago)
	Case of 
		: (vlACT_FormasdePago=-8)  //letras
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
			End if 
			  //***** MANEJO MULTINUMERACION *****
			
			
			If ($msg)
				CD_Dlog (0;__ ("Antes de documentar en letras debe completar la configuración."))
				ACTcfg_OpcionesFormasDePago ("InicializaVariablesIngresoPagos")
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
	
	
	atACT_FormasdePago:=$choice
	vtACT_PagoMsg:="Para el pago con "+atACT_FormasdePago{$choice}+" no se requieren datos adicionales."
	If ($choice>5)
		vtACT_PagoMsg:="Para el pago con "+atACT_FormasdePago{$choice}+" no se requieren datos adicionales."
		$choice:=1
	End if 
	
	  //20120709 ASM código agregado  por nueva funcionalidad "Recargo en formas de Pago"
	ACTfdp_OpcionesRecargos ("InicializaVars")
	vrACT_MontoRecargo:=ACTfdp_OpcionesRecargos ("CargaMontoRecargo";->vlACT_FormasdePago;->vrACT_MontoAPagar)
	ACTfdp_OpcionesRecargos ("SumaMontos")
	If (crPermitirRecargoItem=1)
		OBJECT SET VISIBLE:C603(*;"multaCfg4";True:C214)
		OBJECT SET VISIBLE:C603(*;"multaCfg7";True:C214)
		OBJECT SET VISIBLE:C603(*;"multaCfg3";True:C214)
		OBJECT SET VISIBLE:C603(*;"multaCfg2";True:C214)
		If (crPermitirModificarMonto=1)
			OBJECT SET ENTERABLE:C238(*;"multaCfg2";True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(*;"multaCfg2";False:C215)
		End if 
	Else 
		  //OBJECT SET VISIBLE(*;"multaCfg7";False)
		  //OBJECT SET VISIBLE(*;"multaCfg4";False)
		OBJECT SET VISIBLE:C603(*;"multaCfg3";False:C215)
		OBJECT SET VISIBLE:C603(*;"multaCfg2";False:C215)
	End if 
	
	
	
	  //FORM GOTO PAGE($Choice)
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
	
End if 