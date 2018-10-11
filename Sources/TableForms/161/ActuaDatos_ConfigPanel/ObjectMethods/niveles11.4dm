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
		$msg:="Copia de configuración del nivel "+at_IDNivel{aiADT_NivNo}+" al nivel "+at_NivelesDestino{$i}
		LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")
		
		$fia:=Find in array:C230(aiADT_NivNo;al_NivelesDestino{$i})
		ab_NivelModificado{$fia}:=True:C214
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_LoadDataReceptionSettings (vlSN3_CurrConfigLevel)
	OBJECT SET SCROLL POSITION:C906(lb_CamposAlumno;1;*)
	OBJECT SET SCROLL POSITION:C906(lb_CamposRelaciones;1;*)
	OBJECT SET ENTERABLE:C238(SN3_PublicaRF;(SN3_ActuaDatosPublica=1))
	OBJECT SET ENTERABLE:C238(SN3_PublicaAlumno;(SN3_ActuaDatosPublica=1))
	OBJECT SET ENTERABLE:C238(SN3_EditaAlumno;(SN3_ActuaDatosPublica=1))
	OBJECT SET ENTERABLE:C238(SN3_EditaRF;(SN3_ActuaDatosPublica=1))
End if 