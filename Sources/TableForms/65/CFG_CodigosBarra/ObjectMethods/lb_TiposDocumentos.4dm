  // [xxBBL_Preferencias].CFG_CodigosBarra.lb_TiposDocumentos()
  // Por: Alberto Bachler: 20/11/13, 18:15:14
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($l_filaOrigen;$l_procesoOrigen)
C_POINTER:C301($y_objetoOrigen)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			BBLcfg_AccionesTipoDocumentos 
		End if 
		
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($y_objetoOrigen;$l_filaOrigen;$l_procesoOrigen)
		If ($y_objetoOrigen#OBJECT Get pointer:C1124(Object current:K67:2))
			$0:=-1
		End if 
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($y_objetoOrigen;$l_filaOrigen;$l_procesoOrigen)
		$l_filaDestino:=Drop position:C608
		$l_tipoDocumentoActual:=<>alBBL_IDMedia{$l_filaOrigen}
		$l_tipoDocumentoReemplazo:=<>alBBL_IDMedia{$l_filaDestino}
		BBLcfg_SustituyeTipoDocumento ($l_tipoDocumentoActual;$l_tipoDocumentoReemplazo)
		
End case 

