//%attributes = {}
  //ACTdte_EsEmisorColegium

C_LONGINT:C283($l_idRS;$1)
C_BOOLEAN:C305($0;bACT_emisorAutorizadoCLG)

$l_idRS:=$1
If ($l_idRS=0)
	$l_idRS:=-1
End if 

KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->$l_idRS)
ACTcfdi_OpcionesGenerales ("OnLoadConf";->$l_idRS)
  //If ((cs_emitirCFDI=1) & (at_proveedores{at_proveedores}="Colegium") & ([ACT_RazonesSociales]emisor_electronico))
If ((cs_emitirCFDI=1) & (at_proveedores{at_proveedores}="Colegium") & ([ACT_RazonesSociales:279]emisor_electronico:30) & (<>gCountryCode="cl"))  //20150626 RCH
	
	
	If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? 8)
		If (LICENCIA_esModuloAutorizado (1;12))  //20150725 RCH Se valida licencia. Si tiene, es emisor Colegium. De lo contrario no es.
			bACT_emisorAutorizadoCLG:=True:C214
		Else 
			bACT_emisorAutorizadoCLG:=False:C215
		End if 
	Else 
		bACT_emisorAutorizadoCLG:=False:C215
	End if 
	$0:=True:C214
Else 
	bACT_emisorAutorizadoCLG:=False:C215
	$0:=False:C215
End if 
