C_BLOB:C604($data)
vtSN3_CurrDataType:="ingreso"
WDW_OpenDialogInDrawer (->[SN3_PublicationPrefs:161];"LevelsSelector")
If (ok=1)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Copiando la configuración de ")+vtSNT_ConfigLevelRD+__ (" a"))
	SN3_SaveDataReceptionSettings (vlSN3_CurrConfigLevel)
	For ($i;1;Size of array:C274(al_NivelesDestino))
		SN3_SaveDataReceptionSettings (al_NivelesDestino{$i})
		SN3_LoadDataReceptionSettings (vlSN3_CurrConfigLevel)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(al_NivelesDestino);__ ("Copiando la configuración de ")+vtSNT_ConfigLevelRD+__ (" a ")+at_NivelesDestino{$i}+__ ("..."))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_LoadDataReceptionSettings (vlSN3_CurrConfigLevel)
End if 