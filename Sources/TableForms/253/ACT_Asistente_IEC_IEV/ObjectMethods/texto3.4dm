
C_LONGINT:C283($l_recs)

$l_recs:=Num:C11(ACTdte_OpcionesGeneralesIE ("ValidaPeriodoLibroElectronicoFolioNotificacion"))
If ($l_recs>0)
	CD_Dlog (0;__ ("¡ATENCIÓN! Ya existe un libro enviado, con el mismo folio de notificación, para el período seleccionado."))
End if 
