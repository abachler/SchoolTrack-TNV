//%attributes = {}
  // ACTdteRec_Generales()
  // 
  //
  // modificado por: Alberto Bachler Klein: 09-01-17, 18:26:38
  // -----------------------------------------------------------
C_TEXT:C284($t_accion;$t_retorno;$0;$1)
C_POINTER:C301($y_puntero1;$y_puntero2;$y_puntero3;$y_puntero4;$y_puntero5;$y_puntero6)

$t_accion:=$1
If (Count parameters:C259>=2)
	$y_puntero1:=$2
End if 
If (Count parameters:C259>=3)
	$y_puntero2:=$3
End if 
If (Count parameters:C259>=4)
	$y_puntero3:=$4
End if 
If (Count parameters:C259>=5)
	$y_puntero4:=$5
End if 
If (Count parameters:C259>=6)
	$y_puntero5:=$6
End if 
If (Count parameters:C259>=7)
	$y_puntero6:=$7
End if 

Case of 
	: ($t_accion="SetFechaHora")
		  //llena horas
		vdACT_fechaEjecucion:=!00-00-00!
		vhACT_horaEjecucion:=?00:00:00?
		
		$t_dts:=PREF_fGet (0;"ACT_DTEs_recibidos";DTS_MakeFromDateTime (vdACT_fechaEjecucion;vhACT_horaEjecucion))
		vdACT_fechaEjecucion:=DTS_GetDate ($t_dts)
		vhACT_horaEjecucion:=DTS_GetTime ($t_dts)
		
	: ($t_accion="InicializaOpcionesBusqueda")
		  //inicializa opciones de busqueda...
		atACTdteRec_RazonSocial:=1
		atACTdteRec_RutEmisor:=1
		atACTdteRec_Periodo:=1
		atACTdteRec_Recepcion:=1
		vrACT_folio:=0
		vdACT_fechaEmision:=!00-00-00!
		vdACT_fechaRecepcion:=!00-00-00!
		
	: ($t_accion="ObtieneRUTADocumentos")
		C_TEXT:C284($t_carpetaReceptor;$t_rutaCarpeta;$t_carpeta)
		C_REAL:C285($r_folio)
		$t_rutReceptor:=$y_puntero2->
		$t_rutEmisor:=$y_puntero3->
		$t_tipoArchivo:=$y_puntero4->
		$r_folio:=$y_puntero5->
		
		$t_carpetaReceptor:=$t_rutReceptor+Folder separator:K24:12+"Recibidos"
		$t_rutaCarpeta:=ACTabc_CreaRutaCarpetas ("DTE"+Folder separator:K24:12+$t_carpetaReceptor+Folder separator:K24:12+\
			String:C10(Year of:C25($y_puntero1->))+Folder separator:K24:12+String:C10(Month of:C24($y_puntero1->);"00")+Folder separator:K24:12)
		
		$t_tipoArchivo:=Substring:C12($t_tipoArchivo;1;Position:C15(":";$t_tipoArchivo)-1)
		$t_rutaDocumento:=$t_rutEmisor+"_"+$t_tipoArchivo+"_"+String:C10($r_folio)+".pdf"
		$t_rutaDocumento:=$t_rutaCarpeta+$t_rutaDocumento
		
		$t_retorno:=$t_rutaDocumento
		
End case 

$0:=$t_retorno