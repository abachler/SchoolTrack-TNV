//%attributes = {}
  //UD_v20140319_ListaIntervalo

C_TEXT:C284($vt_intervalo)
$vt_intervalo:=PREF_fGet (0;"CommTrack Updates")
Case of 
	: ($vt_intervalo="1")
		PREF_Set (0;"CommTrack Updates";"4")
	: ($vt_intervalo="2")
		PREF_Set (0;"CommTrack Updates";"5")
	: ($vt_intervalo="3")
		PREF_Set (0;"CommTrack Updates";"6")
End case 