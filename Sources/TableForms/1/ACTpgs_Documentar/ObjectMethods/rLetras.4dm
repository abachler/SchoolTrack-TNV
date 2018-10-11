rCheques:=0

C_BOOLEAN:C305($msg)

ACTcfg_LoadConfigData (8)
ACTcfg_LoadConfigData (6)
$catID:=Find in array:C230(atACT_Categorias;"letra@")
If (($catID>0) & (Size of array:C274(alACT_AñoTasaImpuesto)>0))
	  //alACT_IDCat{0}:=alACT_IDsCats{$catID}
	  //ARRAY LONGINT($DA_Return;0)
	  //AT_SearchArray (->alACT_IDCat;"=";->$DA_Return)
	  //If (Size of array($DA_Return)=1)
	  //vlACT_LCFolio:=alACT_Proxima{$DA_Return{1}}
	  //vl_indexLC:=$DA_Return{1}
	  //If (vlACT_LCFolio<=0)
	  //$msg:=True
	  //End if 
	  //Else 
	  //$msg:=True
	  //End if 
	
	  //***** 20140709 RCH MANEJO MULTINUMERACION *****
	C_LONGINT:C283($l_indice)
	$l_indice:=ACTlc_ObtieneIndex (alACT_IDsCats{$catID})
	If ($l_indice#0)
		vlACT_LCFolio:=alACT_Proxima{$l_indice}
		vl_indexLC:=$l_indice
		If (vlACT_LCFolio<=0)
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
	FORM GOTO PAGE:C247(1)
	Self:C308->:=0
	rCheques:=1
	REDRAW WINDOW:C456
	
	xALSet_ACT_Documentar 
	AL_UpdateArrays (xALP_DocumentarLC;0)
	AT_Initialize (->arACT_LCFolio;->atACT_LCRut;->atACT_LCAceptante;->adACT_LCEmision;->adACT_LCVencimiento)
	AT_Initialize (->arACT_LCMonto;->arACT_LCImpuesto;->abACT_LCModificados;->atACT_BancoCodigo;->atACT_ObsDoc)
	AL_UpdateArrays (xALP_DocumentarLC;-2)
	CD_Dlog (0;__ ("Antes de documentar en letras debe completar la configuración."))
Else 
	If (Self:C308->=0)
		Self:C308->:=1
	End if 
	FORM GOTO PAGE:C247(2)
	xALSet_ACT_DocumentarLetra 
	AL_UpdateArrays (xALP_Documentar;0)
	AT_Initialize (->atACT_BancoNombre;->atACT_BancoCodigo;->atACT_Cuenta;->atACT_Titular;->atACT_RUTTitular;->atACT_Serie;->atACT_Fecha;->adACT_Fecha;->arACT_MontoCheque;->asACT_RUTTitular;->abACT_Modificados;->atACT_ObsDoc)
	ACTcfg_OpcionesRecargosCaja ("CargaDatosMulta")
	ACTcfg_OpcionesRecargosCaja ("ValidacionesFormDocumentar")
	ACTfdp_OpcionesRecargos ("CargaMontoRecargoDocumentar")
	AL_UpdateArrays (xALP_Documentar;-2)
End if 