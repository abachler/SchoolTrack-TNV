//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 26-05-17, 09:56:01
  // ----------------------------------------------------
  // Método: UD_v20170526_FdpServipag
  // Descripción
  // Agrega nueva forma de pago
  //
  // Parámetros
  // ----------------------------------------------------

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($vl_IDFormaPago)
	C_TEXT:C284($vt_glosa)
	$vt_glosa:="Servipag"
	ACTfdp_VerificaNuevaFDP ($vt_glosa)
	ACTfdp_CargaFormasDePago 
	$vl_IDFormaPago:=Num:C11(ACTcfg_OpcionesFormasDePago ("NuevaFormaDePago";->$vt_glosa))
	ACTfdp_EstadosXDefecto 
End if 
