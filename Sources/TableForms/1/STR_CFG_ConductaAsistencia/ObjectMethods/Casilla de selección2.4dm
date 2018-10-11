<>vr_RegistrarMinutosEnAtrasos:=cb_RegistrarMinutosEnAtrasos
PREF_Set (0;"RegistrarMinutosEnAtrasos";String:C10(cb_RegistrarMinutosEnAtrasos))
If (Self:C308->=0)
	_O_DISABLE BUTTON:C193(cb_InasistenciasXatrasos)
	OBJECT SET ENTERABLE:C238(vt_Intervalos;False:C215)
	cb_InasistenciasXatrasos:=0
	OBJECT SET ENTERABLE:C238(vi_Minutos_Inasistencia_hora;False:C215)
	OBJECT SET ENTERABLE:C238(vi_Minutos_Inasistencia_Dia;False:C215)
	BLOB_Variables2Blob (->xPreferenciasAtrasos;0;->vt_Intervalos;->vi_Minutos_Inasistencia_hora;->vi_Minutos_Inasistencia_Dia)
	PREF_SetBlob (0;"PreferenciasAtrasos";xPreferenciasAtrasos)
Else 
	_O_ENABLE BUTTON:C192(cb_InasistenciasXatrasos)
	OBJECT SET ENTERABLE:C238(vt_Intervalos;True:C214)
End if 