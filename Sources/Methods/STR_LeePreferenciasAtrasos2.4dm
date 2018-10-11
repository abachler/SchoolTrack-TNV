//%attributes = {}
  //STR_LeePreferenciasAtrasos2

  //EMA 11/10/06
C_TEXT:C284(vt_Intervalos)
_O_C_INTEGER:C282(vi_Minutos_Inasistencia_hora;vi_RegistrarMinutosEnAtrasos;vi_Minutos_Inasistencia_Dia)
vi_RegistrarMinutosEnAtrasos:=Num:C11(PREF_fGet (0;"RegistrarMinutosEnAtrasos";"0"))

<>vr_InasistenciasXatrasos:=Num:C11(PREF_fGet (0;"RegistrarInasistenciasPorAtrasos";"0"))

C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
xBlob:=PREF_fGetBlob (0;"PreferenciasAtrasos";xBlob)
BLOB_Blob2Vars (->xBlob;0;->vt_Intervalos;->vi_Minutos_Inasistencia_hora;->vi_Minutos_Inasistencia_Dia)
j_tabla1:=Num:C11(PREF_fGet (0;"ConfiguracionTablaPrimaria";"1"))
If (j_tabla1=1)
	_O_C_INTEGER:C282(conversionDia)
	ARRAY LONGINT:C221(ATSTRAL_FALTAMINUTOSDESDE;4)  //´rch `rch55275
	ARRAY LONGINT:C221(ATSTRAL_FALTAMINUTOSHASTA;4)
	ARRAY LONGINT:C221(ATSTRAL_FALTACONV;4)
	ARRAY TEXT:C222(ATSTRAL_FALTATIPO;4)
	SET BLOB SIZE:C606(xblob;0)
	xblob:=PREF_fGetBlob (0;"PreferenciasAtrasosDia")
	BLOB_Blob2Vars (->xblob;0;->vt_Intervalos;->ATSTRAL_FALTAMINUTOSDESDE;->ATSTRAL_FALTAMINUTOSHASTA;->ATSTRAL_FALTACONV;->conversionDia;->ATSTRAL_FALTATIPO)
	SET BLOB SIZE:C606(xblob;0)
	If (Size of array:C274(ATSTRAL_FALTAMINUTOSDESDE)=6)
		
		ARRAY LONGINT:C221(ATSTRAL_FALTAMINUTOSDESDE;4)  //´rch `rch55275
		ARRAY LONGINT:C221(ATSTRAL_FALTAMINUTOSHASTA;4)
		ARRAY LONGINT:C221(ATSTRAL_FALTACONV;4)
		ARRAY TEXT:C222(ATSTRAL_FALTATIPO;4)
		For ($i;1;4)
			ATSTRAL_FALTAMINUTOSDESDE{$i}:=0
			ATSTRAL_FALTAMINUTOSHASTA{$i}:=0
			ATSTRAL_FALTACONV{$i}:=0
		End for 
		vt_Intervalos:=""
		SET BLOB SIZE:C606(xblob;0)
		BLOB_Variables2Blob (->xblob;0;->vt_Intervalos;->ATSTRAL_FALTAMINUTOSDESDE;->ATSTRAL_FALTAMINUTOSHASTA;->ATSTRAL_FALTACONV;->conversionDia;->ATSTRAL_FALTATIPO)
		PREF_SetBlob (0;"PreferenciasAtrasosDia";xblob)
		SET BLOB SIZE:C606(xblob;0)
		xblob:=PREF_fGetBlob (0;"PreferenciasAtrasosDia")
		BLOB_Blob2Vars (->xblob;0;->vt_Intervalos;->ATSTRAL_FALTAMINUTOSDESDE;->ATSTRAL_FALTAMINUTOSHASTA;->ATSTRAL_FALTACONV;->conversionDia;->ATSTRAL_FALTATIPO)
		SET BLOB SIZE:C606(xblob;0)
	End if 
Else 
	_O_C_INTEGER:C282(conversionDia)
	ARRAY LONGINT:C221(ATSTRAL_FALTAMINUTOSDESDE;6)  //´rch `rch55275
	ARRAY LONGINT:C221(ATSTRAL_FALTAMINUTOSHASTA;6)
	ARRAY LONGINT:C221(ATSTRAL_FALTACONV;6)
	ARRAY TEXT:C222(ATSTRAL_FALTATIPO;6)
	SET BLOB SIZE:C606(xblob;0)
	xblob:=PREF_fGetBlob (0;"PreferenciasAtrasosDia")
	BLOB_Blob2Vars (->xblob;0;->vt_Intervalos;->ATSTRAL_FALTAMINUTOSDESDE;->ATSTRAL_FALTAMINUTOSHASTA;->ATSTRAL_FALTACONV;->conversionDia;->ATSTRAL_FALTATIPO)
	SET BLOB SIZE:C606(xblob;0)
	
	If (Size of array:C274(ATSTRAL_FALTAMINUTOSDESDE)=4)
		
		ARRAY LONGINT:C221(ATSTRAL_FALTAMINUTOSDESDE;6)  //´rch `rch55275
		ARRAY LONGINT:C221(ATSTRAL_FALTAMINUTOSHASTA;6)
		ARRAY LONGINT:C221(ATSTRAL_FALTACONV;6)
		ARRAY TEXT:C222(ATSTRAL_FALTATIPO;6)
		For ($i;1;6)
			ATSTRAL_FALTAMINUTOSDESDE{$i}:=0
			ATSTRAL_FALTAMINUTOSHASTA{$i}:=0
			ATSTRAL_FALTACONV{$i}:=0
		End for 
		vt_Intervalos:=""
		SET BLOB SIZE:C606(xblob;0)
		BLOB_Variables2Blob (->xblob;0;->vt_Intervalos;->ATSTRAL_FALTAMINUTOSDESDE;->ATSTRAL_FALTAMINUTOSHASTA;->ATSTRAL_FALTACONV;->conversionDia;->ATSTRAL_FALTATIPO)
		PREF_SetBlob (0;"PreferenciasAtrasosDia";xblob)
		SET BLOB SIZE:C606(xblob;0)
		xblob:=PREF_fGetBlob (0;"PreferenciasAtrasosDia")
		BLOB_Blob2Vars (->xblob;0;->vt_Intervalos;->ATSTRAL_FALTAMINUTOSDESDE;->ATSTRAL_FALTAMINUTOSHASTA;->ATSTRAL_FALTACONV;->conversionDia;->ATSTRAL_FALTATIPO)
		SET BLOB SIZE:C606(xblob;0)
	End if 
End if 




<>gAllowMultipleLates:=Num:C11(PREF_fGet (0;"AllowMultipleLates";"0"))

