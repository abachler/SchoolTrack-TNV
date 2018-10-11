//%attributes = {}
  //ACTinit_CreateDefFdPCodes

C_LONGINT:C283($0)
$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	C_BOOLEAN:C305($vb_setBlob)
	If (Count parameters:C259=1)
		$vb_setBlob:=$1
	Else 
		$vb_setBlob:=True:C214
	End if 
	
	If ($vb_setBlob)
		ACTcfgfdp_OpcionesGenerales ("VerificaFormasDePagoXDef")
	Else 
		$vl_cantidad:=0
		For ($i;1;Size of array:C274(<>atACT_FormasDePago2D{1}))
			If (Num:C11(<>atACT_FormasDePago2D{1}{$i})<0)
				$vl_cantidad:=$vl_cantidad+1
			End if 
		End for 
		$0:=$vl_cantidad
	End if 
	  //ARRAY TEXT($atACT_FormasdePago;0)
	  //APPEND TO ARRAY($atACT_FormasdePago;"Efectivo")
	  //APPEND TO ARRAY($atACT_FormasdePago;"Cheque")
	  //APPEND TO ARRAY($atACT_FormasdePago;"Tarjeta de Crédito")
	  //APPEND TO ARRAY($atACT_FormasdePago;"Tarjeta de Débito")
	  //APPEND TO ARRAY($atACT_FormasdePago;"Letra")
	  //APPEND TO ARRAY($atACT_FormasdePago;"PAT")
	  //APPEND TO ARRAY($atACT_FormasdePago;"PAC")
	  //APPEND TO ARRAY($atACT_FormasdePago;"Cuponera")
	  //APPEND TO ARRAY($atACT_FormasdePago;"Nota de Crédito")
	  //
	  //If ($vb_setBlob)
	  //ARRAY TEXT(atACT_FormasdePago;0)
	  //For ($i;1;Size of array($atACT_FormasdePago))
	  //APPEND TO ARRAY(atACT_FormasdePago;$atACT_FormasdePago{$i})
	  //End for 
	  //
	  //If (atACT_FormasdePago=0)
	  //atACT_FormasdePago:=1
	  //End if 
	  //ARRAY TEXT(atACT_FdPCodes;0)
	  //APPEND TO ARRAY(atACT_FdPCodes;"EF")
	  //APPEND TO ARRAY(atACT_FdPCodes;"CH")
	  //APPEND TO ARRAY(atACT_FdPCodes;"TC")
	  //APPEND TO ARRAY(atACT_FdPCodes;"TD")
	  //APPEND TO ARRAY(atACT_FdPCodes;"LT")
	  //APPEND TO ARRAY(atACT_FdPCodes;"PAT")
	  //APPEND TO ARRAY(atACT_FdPCodes;"PAC")
	  //APPEND TO ARRAY(atACT_FdPCodes;"CUP")
	  //APPEND TO ARRAY(atACT_FdPCodes;"NC")
	  //
	  //ARRAY TEXT(atACT_FdPCtaContable;0)
	  //ARRAY TEXT(atACT_FdPCtaCodAux;0)
	  //ARRAY TEXT(atACT_FdPCentroCostos;0)
	  //ARRAY TEXT(atACT_FdPCtaContable;Size of array(atACT_FormasdePago))
	  //ARRAY TEXT(atACT_FdPCtaCodAux;Size of array(atACT_FormasdePago))
	  //ARRAY TEXT(atACT_FdPCentroCostos;Size of array(atACT_FormasdePago))
	  //ARRAY TEXT(atACT_FdPCCtaContable;0)
	  //ARRAY TEXT(atACT_FdPCCtaCodAux;0)
	  //ARRAY TEXT(atACT_FdPCCentroCostos;0)
	  //ARRAY TEXT(atACT_FdPCCtaContable;Size of array(atACT_FormasdePago))
	  //ARRAY TEXT(atACT_FdPCCtaCodAux;Size of array(atACT_FormasdePago))
	  //ARRAY TEXT(atACT_FdPCCentroCostos;Size of array(atACT_FormasdePago))
	  //ARRAY TEXT(atACT_FdPCodInterno;Size of array(atACT_FormasdePago))
	  //
	  //vtACT_CPCAFecha:=""
	  //vtACT_CCCAFecha:=""
	  //vtACT_CCPCAFecha:=""
	  //vtACT_CCCCAFecha:=""
	  //vtACT_CAUXCCAFecha:=""
	  //vtACT_CAUXCCCAFecha:=""
	  //vtACT_CICAFecha:=""
	  //
	  //
	  //SET BLOB SIZE(xBlob;0)
	  //BLOB_Variables2Blob (->xBlob;0;->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCtaContable;->atACT_FdPCentroCostos;->vtACT_CPCAFecha;->vtACT_CCCAFecha;->atACT_FdPCCtaContable;->atACT_FdPCCentroCostos;->vtACT_CCPCAFecha;->vtACT_CCCCAFecha;->vtACT_CAUXCCAFecha;->vtACT_CAUXCCCAFecha;->atACT_FdPCtaCodAux;->atACT_FdPCCtaCodAux;->atACT_FdPCodInterno;->vtACT_CICAFecha)
	  //PREF_SetBlob (0;"ACT_CodesFdPago";xBlob)
	  //SET BLOB SIZE(xBlob;0)
	  //Else 
	  //$0:=Size of array($atACT_FormasdePago)
	  //End if 
End if 