//%attributes = {}
  //ACTbol_ValidaInicioEmision
C_BOOLEAN:C305($0;$3;$b_mostrarMsj)
C_BOOLEAN:C305($emitir;$go)
C_LONGINT:C283($PorDefecto;$vl_tipoMsj)

$b_mostrarMsj:=True:C214
$vl_tipoMsj:=$1
If (Count parameters:C259>=3)
	$b_mostrarMsj:=$3
End if 

ACTcfg_LoadConfigData (8)

If (Size of array:C274(alACT_IDsCats)>0)
	
	If (Count parameters:C259>=2)  //20150626 RCH Se agrega parametro opcional
		$PorDefecto:=Find in array:C230(alACT_IDsCats;$2)
	Else 
		$PorDefecto:=Find in array:C230(abACT_PorDefecto;True:C214)
	End if 
	
	If ($PorDefecto#-1)
		$emitir:=ACTcfg_SearchCatDocs (alACT_IDsCats{$PorDefecto})
		If ($emitir)
			$go:=True:C214
		Else 
			$go:=False:C215
		End if 
	Else 
		$go:=False:C215
	End if 
Else 
	$go:=False:C215
End if 

If (Not:C34($go))
	If ($b_mostrarMsj)
		Case of 
			: ($vl_tipoMsj=1)
				CD_Dlog (0;__ ("La emisión de documentos tributarios no se puede realizar mientras no esté definida por completo una categoría de documentos tributarios.\rRealice la configuración de categorías en Configuración/Documentos Tributarios."))
			: ($vl_tipoMsj=2)
				CD_Dlog (0;__ ("El proceso de importación no se puede realizar mientras no esté definida por completo una categoría de documentos tributarios.\rRealice la configuración de categorías en Configuración/Documentos Tributarios."))
		End case 
	End if 
End if 
  //If (($emitir) & (<>gCountryCode="ar"))
If (($emitir) & (<>gCountryCode="ar") & (Records in table:C83([ACT_RazonesSociales:279])=1))  //20170802 RCH Solo se puede verificar de esta manera si hay 1 RS configurada
	If (cs_emitirCFDI=1)
		If (vtACT_errorPHPExec="")
			If (vrACT_PuntoDeVenta=0)
				vtACT_errorPHPExec:=__ ("El punto de venta configurado no puede ser 0. Revise la configuración de las Facturas Electrónicas.")
				$go:=False:C215
			End if 
		Else 
			$go:=False:C215
		End if 
		
		If (Not:C34($go))
			If ($b_mostrarMsj)
				CD_Dlog (0;vtACT_errorPHPExec)
			End if 
		End if 
		
	End if 
	
End if 

  //20150902 RCH Se verifica inicio de emision de documentos electrónicos. Si no es server oficial y apunta al ambiente de producción del SII se pregunta si se puede continuar
If ($go)
	If (<>gCountryCode="cl")
		READ ONLY:C145([ACT_RazonesSociales:279])
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recs)
		QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]emisor_electronico:30=True:C214)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($l_recs>0)
			QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]emisor_electronico:30=True:C214)
			If (ACTdte_EsEmisorColegium ([ACT_RazonesSociales:279]id:1))
				$b_ambienteCertificacion:=(Num:C11(PREF_fGet (0;"ACT_AMBIENTE_CERTIFICACION_SII";"1"))=1)
				If (Not:C34($b_ambienteCertificacion))
					If (Not:C34(ACT_VerificaInicioProceso (__ ("Si continúa se emitirán documentos en el ambiente de producción del SII."))))
						$go:=False:C215
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

$0:=$go