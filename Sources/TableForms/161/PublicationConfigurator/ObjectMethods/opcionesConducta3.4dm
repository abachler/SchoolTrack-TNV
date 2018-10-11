SN3_SetCheckByChecks (->cb_PublicarConductaYAsistencia;"|";->cb_PublicarInasistencias;->cb_PublicarAtrasos;->cb_PublicarAnotaciones;->cb_PublicarCastigos;->cb_PublicarSuspensiones;->cb_PublicarCondicionalidad;->cb_PublicarPctAsistencia)
IT_SetButtonState ((cb_PublicarAnotaciones=1);->cb_PublicarAnotacionesPositivas;->cb_PublicarAnotacionesNegativas;->cb_PublicarAnotacionesNeutras)
If (Self:C308->=1)
	SN3_SetChecksByCheck (->cb_PublicarAnotaciones;->cb_PublicarAnotacionesPositivas;->cb_PublicarAnotacionesNegativas;->cb_PublicarAnotacionesNeutras)
End if 