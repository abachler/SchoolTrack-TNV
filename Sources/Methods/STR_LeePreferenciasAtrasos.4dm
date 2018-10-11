//%attributes = {}
  //  //STR_LeePreferenciasAtrasos
  //MONO: Ahora se utiliza la versión 2 de este método STR_LeePreferenciasAtrasos2
  //  //EMA 11/10/06
  //C_TEXT(vt_Intervalos)
  //_o_C_INTEGER(vi_Minutos_Inasistencia_hora;vi_RegistrarMinutosEnAtrasos;vi_Minutos_Inasistencia_Dia)
  //vi_RegistrarMinutosEnAtrasos:=Num(PREF_fGet (0;"RegistrarMinutosEnAtrasos";"0"))

  //<>vr_InasistenciasXatrasos:=Num(PREF_fGet (0;"RegistrarInasistenciasPorAtrasos";"0"))

  //C_BLOB(xBlob)
  //SET BLOB SIZE(xBlob;0)
  //xBlob:=PREF_fGetBlob (0;"PreferenciasAtrasos";xBlob)
  //BLOB_Blob2Vars (->xBlob;0;->vt_Intervalos;->vi_Minutos_Inasistencia_hora;->vi_Minutos_Inasistencia_Dia)

  //_o_C_INTEGER(conversionDia)
  //ARRAY LONGINT(ATSTRAL_FALTAMINUTOSDESDE;6)  //´rch `rch55275
  //ARRAY LONGINT(ATSTRAL_FALTAMINUTOSHASTA;6)
  //ARRAY LONGINT(ATSTRAL_FALTACONV;6)
  //ARRAY TEXT(ATSTRAL_FALTATIPO;6)
  //SET BLOB SIZE(xblob;0)
  //xblob:=PREF_fGetBlob (0;"PreferenciasAtrasosDia")
  //BLOB_Blob2Vars (->xblob;0;->vt_Intervalos;->ATSTRAL_FALTAMINUTOSDESDE;->ATSTRAL_FALTAMINUTOSHASTA;->ATSTRAL_FALTACONV;->conversionDia;->ATSTRAL_FALTATIPO)
  //SET BLOB SIZE(xblob;0)

  //If (Size of array(ATSTRAL_FALTAMINUTOSDESDE)=4)

  //ARRAY LONGINT(ATSTRAL_FALTAMINUTOSDESDE;6)  //´rch `rch55275
  //ARRAY LONGINT(ATSTRAL_FALTAMINUTOSHASTA;6)
  //ARRAY LONGINT(ATSTRAL_FALTACONV;6)
  //ARRAY TEXT(ATSTRAL_FALTATIPO;6)

  //SET BLOB SIZE(xblob;0)
  //BLOB_Variables2Blob (->xblob;0;->vt_Intervalos;->ATSTRAL_FALTAMINUTOSDESDE;->ATSTRAL_FALTAMINUTOSHASTA;->ATSTRAL_FALTACONV;->conversionDia;->ATSTRAL_FALTATIPO)
  //PREF_SetBlob (0;"PreferenciasAtrasosDia";xblob)
  //SET BLOB SIZE(xblob;0)

  //End if 


  //<>gAllowMultipleLates:=Num(PREF_fGet (0;"AllowMultipleLates";"0"))

