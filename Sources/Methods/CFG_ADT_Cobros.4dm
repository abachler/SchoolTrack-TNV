//%attributes = {}
  //CFG_ADT_Cobros

$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	CFG_OpenConfigPanel (->[xxSTR_Constants:1];"ADTcfg_Cobros")
	ADTcfg_SaveItems 
Else 
	CD_Dlog (0;__ ("Sólo se pueden realizar cobros si usted dispone de una licencia para el módulo AccountTrack."))
End if 