//%attributes = {}
  //ACTdc_DocumentoNoBloq

C_BOOLEAN:C305($0;$vb_retorno)
C_TEXT:C284($vt_accion;$1)
C_POINTER:C301($ptr1)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="BusquedaDocCartera")
		READ WRITE:C146([ACT_Documentos_en_Cartera:182])
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=$ptr1->)
		
	: ($vt_accion="BusquedaDocPago")
		READ WRITE:C146([ACT_Documentos_de_Pago:176])
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=$ptr1->)
		
	: ($vt_accion="BusquedaDeRegistros")
		ACTdc_DocumentoNoBloq ("BusquedaDocCartera";$ptr1)
		ACTdc_DocumentoNoBloq ("BusquedaDocPago";->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
		
	: ($vt_accion="RegistrosEnUsoTabla")
		$vb_retorno:=Locked:C147($ptr1->)
		
	: ($vt_accion="RegistrosEnUso")
		$lockedCartera:=ACTdc_DocumentoNoBloq ("RegistrosEnUsoTabla";->[ACT_Documentos_en_Cartera:182])
		$lockedPagos:=ACTdc_DocumentoNoBloq ("RegistrosEnUsoTabla";->[ACT_Documentos_de_Pago:176])
		If ($lockedCartera | $lockedPagos)
			$vb_retorno:=False:C215
		Else 
			$vb_retorno:=True:C214
		End if 
	: ($vt_accion="CarteraYDocPago")
		$vb_retorno:=ACTdc_DocumentoNoBloq ("BusquedaDeRegistros";$ptr1)
		$vb_retorno:=ACTdc_DocumentoNoBloq ("RegistrosEnUso")
		
	: ($vt_accion="LiberaRegistrosCarteraYDocPago")
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
		KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
		
	: ($vt_accion="Prorroga")
		$vb_retorno:=ACTdc_DocumentoNoBloq ("CarteraYDocPago";->[ACT_Documentos_en_Cartera:182]ID:1)
		
	: ($vt_accion="ProrrogaMensaje")
		CD_Dlog (0;__ ("El registro actual está en uso. No es posible prorrogar el documento en este momento."))
		CANCEL:C270
		
	: ($vt_accion="ProrrogaLiberaRegistros")
		ACTdc_DocumentoNoBloq ("LiberaRegistrosCarteraYDocPago")
		
	: ($vt_accion="Depositar")
		$vb_retorno:=ACTdc_DocumentoNoBloq ("CarteraYDocPago";$ptr1)
		
	: ($vt_accion="DepositarMensaje")
		CD_Dlog (0;__ ("El registro actual está en uso. No es posible depositar el documento en este momento."))
		
	: ($vt_accion="DepositarLiberaRegistros")
		ACTdc_DocumentoNoBloq ("LiberaRegistrosCarteraYDocPago")
		
	: ($vt_accion="Reemplazar")
		$vb_retorno:=ACTdc_DocumentoNoBloq ("CarteraYDocPago";$ptr1)
		
	: ($vt_accion="ReemplazarMensaje")
		CD_Dlog (0;__ ("El registro actual está en uso. No es posible reemplazar el documento en este momento."))
		
	: ($vt_accion="ReemplazarLiberaRegistros")
		ACTdc_DocumentoNoBloq ("LiberaRegistrosCarteraYDocPago")
		
	: ($vt_accion="CambiarU")
		$vb_retorno:=ACTdc_DocumentoNoBloq ("CarteraYDocPago";$ptr1)
		
	: ($vt_accion="CambiarUMensaje")
		CD_Dlog (0;__ ("El registro actual está en uso. No es posible reemplazar el documento en este momento."))
		
	: ($vt_accion="CambiarULiberaRegistros")
		ACTdc_DocumentoNoBloq ("LiberaRegistrosCarteraYDocPago")
		
	: ($vt_accion="Protestar")
		ACTdc_DocumentoNoBloq ("BusquedaDocPago";$ptr1)
		$vb_retorno:=Not:C34(ACTdc_DocumentoNoBloq ("RegistrosEnUsoTabla";->[ACT_Documentos_de_Pago:176]))
		
		
	: ($vt_accion="ProtestarMensaje")
		CD_Dlog (0;__ ("El registro actual está en uso. No es posible protestar el documento en este momento."))
		
	: ($vt_accion="ProtestarLiberaRegistros")
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
		
End case 
$0:=$vb_retorno