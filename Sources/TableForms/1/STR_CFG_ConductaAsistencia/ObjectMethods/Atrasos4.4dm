<>vr_InasistenciasXatrasos:=cb_InasistenciasXatrasos
PREF_Set (0;"RegistrarInasistenciasPorAtrasos";String:C10(cb_InasistenciasXatrasos))

If (Self:C308->>0)
	OBJECT SET ENTERABLE:C238(vi_Minutos_Inasistencia_hora;True:C214)
	OBJECT SET ENTERABLE:C238(vi_Minutos_Inasistencia_Dia;True:C214)
Else 
	vi_Minutos_Inasistencia_hora:=0
	vi_Minutos_Inasistencia_Dia:=0
	OBJECT SET ENTERABLE:C238(vi_Minutos_Inasistencia_hora;False:C215)
	OBJECT SET ENTERABLE:C238(vi_Minutos_Inasistencia_Dia;False:C215)
	BLOB_Variables2Blob (->xPreferenciasAtrasos;0;->vt_Intervalos;->vi_Minutos_Inasistencia_hora;->vi_Minutos_Inasistencia_Dia)
	PREF_SetBlob (0;"PreferenciasAtrasos";xPreferenciasAtrasos)
End if 