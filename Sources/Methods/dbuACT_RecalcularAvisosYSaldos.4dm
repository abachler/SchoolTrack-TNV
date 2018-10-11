//%attributes = {}
  //dbuACT_RecalcularAvisosYSaldos

$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	ACTinit_LoadPrefs 
	ARRAY LONGINT:C221($alACT_RNAvisos;0)
	ALL RECORDS:C47([ACT_Avisos_de_Cobranza:124])
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$alACT_RNAvisos;"")
	ACTpgs_RecalcularAvisos (->$alACT_RNAvisos)
	ACTmnu_RecalcularSaldosAvisos (->$alACT_RNAvisos)
End if 