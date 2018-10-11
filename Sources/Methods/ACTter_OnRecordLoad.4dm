//%attributes = {}
  //ACTter_OnRecordLoad

C_LONGINT:C283($viBWR_RecordWasSaved)
C_LONGINT:C283(viBWR_RecordWasSaved;vlSTR_PeriodoSeleccionado)

  //C_BOOLEAN(campopropio)
  //campopropio:=False
  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
vb_guardarCambios:=False:C215
If (([ACT_Terceros:138]Nacionalidad:27="") & (Not:C34([ACT_Terceros:138]Es_empresa:2)))
	[ACT_Terceros:138]Nacionalidad:27:=LOC_GetNacionalidad 
End if 
ACTter_SetIdentificador 

If ((Form event:C388#On Load:K2:1) & (Form event:C388#On Activate:K2:9))
	Case of 
		: (vlACT_PaginaFormTerceros=1)
			$viBWR_RecordWasSaved:=ACTter_fSave 
		: (vlACT_PaginaFormTerceros=2)
			$viBWR_RecordWasSaved:=ACTter_fSave 
	End case 
End if 

SET LIST ITEM PROPERTIES:C386(hlTab_ACT_Terceros;1;(USR_checkRights ("L";->[ACT_Terceros:138]));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_ACT_Terceros;2;(USR_checkRights ("L";->[ACT_Terceros:138]));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_ACT_Terceros;3;(USR_checkRights ("L";->[ACT_Terceros_Pactado:139]));1;0)

If (Count parameters:C259=1)
	vlACT_PaginaFormTerceros:=$1
Else 
	If (vlACT_PaginaFormTerceros=0)
		vlACT_PaginaFormTerceros:=1
	End if 
End if 

If (Record number:C243([ACT_Terceros:138])=-3)
	  // Modificado por: Alexis Bustamante (24-04-2017)
	  //ticket 177665
	[ACT_Terceros:138]Ciudad:7:=<>GPROVINCIA
	vlACT_PaginaFormTerceros:=1
	[ACT_Terceros:138]Modo_de_Pago:30:=ACTcfgfdp_OpcionesGenerales ("fdpXDefecto")
	[ACT_Terceros:138]Id_Modo_de_Pago:61:=vl_FormadePagoXDef
	vt_ModoDePagoTer:=[ACT_Terceros:138]Modo_de_Pago:30
End if 

C_LONGINT:C283($result)
If ($viBWR_RecordWasSaved>=0)
	Case of 
		: (vlACT_PaginaFormTerceros=1)
			$result:=ACTter_PageGeneral 
			
		: (vlACT_PaginaFormTerceros=2)
			$result:=ACTter_PageInfoPagos 
			
		: (vlACT_PaginaFormTerceros=3)
			$result:=ACTter_PagePactado 
			
		: (vlACT_PaginaFormTerceros=4)
			AL_UpdateArrays (xALP_Transacciones;0)
			
			  //ACTter_LoadTransacciones (1)
			  //20120322 RCH Cuando se cambiaba de registro mostraba los datos de la pagina 1 pero aparecia seleccionada otra pagina, por ejemplo, la 3...
			$item:=Selected list items:C379(hlTab_ACT_Transacciones)
			If ($item=0)
				$item:=1
				SELECT LIST ITEMS BY POSITION:C381(hlTab_ACT_Transacciones;$item)
			End if 
			ACTter_LoadTransacciones ($item)
			
			AL_UpdateArrays (xALP_Transacciones;-2)
			AL_SetLine (xALP_Transacciones;0)
			For ($i;1;Size of array:C274(aTransWidths))
				AL_SetWidths (xALP_Transacciones;$i;1;aTransWidths{$i})
			End for 
			$result:=1
			
		: (vlACT_PaginaFormTerceros=5)
			ACTpp_CargaArregloAñosHist ("avisosTer";[ACT_Terceros:138]Id:1)
			$result:=ACTter_PageAvisosDeCobranza 
			
		: (vlACT_PaginaFormTerceros=6)
			ACTpp_CargaArregloAñosHist ("pagosTer";[ACT_Terceros:138]Id:1)
			$result:=ACTter_PagePagos 
			
		: (vlACT_PaginaFormTerceros=7)
			ACTpp_CargaArregloAñosHist ("doctribTer";[ACT_Terceros:138]Id:1)
			$result:=ACTter_PageDocTributarios 
			
		: (vlACT_PaginaFormTerceros=8)
			$result:=ACTter_PageDocEnCartera 
			
		: (vlACT_PaginaFormTerceros=9)
			ACTpp_CargaArregloAñosHist ("docdepTer";[ACT_Terceros:138]Id:1)
			$result:=ACTter_PageDocDepositados 
		Else 
			$result:=ACTter_PageGeneral 
			
	End case 
	ACT_SetTotalsColorInputForm (->[ACT_Terceros:138]Saldo:54;->[ACT_Terceros:138]Deuda_Vencida:52)
	
	If ($result=1)
		FORM GOTO PAGE:C247(vlACT_PaginaFormTerceros)
	Else 
		vlACT_PaginaFormTerceros:=1
		ACTter_OnRecordLoad (1)
	End if 
	SELECT LIST ITEMS BY REFERENCE:C630(hlTab_ACT_Terceros;vlACT_PaginaFormTerceros)
Else 
	vlACT_PaginaFormTerceros:=1
	SELECT LIST ITEMS BY REFERENCE:C630(hlTab_ACT_Terceros;vlACT_PaginaFormTerceros)
End if 

ACTter_SetObjects 

  //20150316 RCH
ACTbol_ObtieneResponsableFact ("CargaVarDesdeFichaTer")