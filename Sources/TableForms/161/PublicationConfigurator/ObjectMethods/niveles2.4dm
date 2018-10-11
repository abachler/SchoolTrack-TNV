C_BLOB:C604($data)
WDW_OpenDialogInDrawer (->[SN3_PublicationPrefs:161];"LevelsSelector")
If (ok=1)
	If (rTodos=1)
		SET BLOB SIZE:C606($data;0)
		SN3_SavePubConfig (vlSN3_CurrConfigLevel)
		READ ONLY:C145([SN3_PublicationPrefs:161])
		QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=vlSN3_CurrConfigLevel)
		$data:=[SN3_PublicationPrefs:161]xData:2
		UNLOAD RECORD:C212([SN3_PublicationPrefs:161])
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Copiando la configuración completa de ")+vtSNT_ConfigLevel+__ (" a"))
		For ($i;1;Size of array:C274(al_NivelesDestino))
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(al_NivelesDestino)*100;__ ("Copiando la configuración completa de ")+vtSNT_ConfigLevel+__ (" a ")+at_NivelesDestino{$i}+__ ("..."))
			READ WRITE:C146([SN3_PublicationPrefs:161])
			QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=al_NivelesDestino{$i})
			If (Records in selection:C76([SN3_PublicationPrefs:161])=0)
				CREATE RECORD:C68([SN3_PublicationPrefs:161])
				[SN3_PublicationPrefs:161]Nivel:1:=al_NivelesDestino{$i}
			End if 
			[SN3_PublicationPrefs:161]xData:2:=$data
			SAVE RECORD:C53([SN3_PublicationPrefs:161])
		End for 
		
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		KRL_UnloadReadOnly (->[SN3_PublicationPrefs:161])
	Else 
		SN3_SavePubConfig (vlSN3_CurrConfigLevel)
		READ ONLY:C145([SN3_PublicationPrefs:161])
		QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=vlSN3_CurrConfigLevel)
		$data:=[SN3_PublicationPrefs:161]xData:2
		UNLOAD RECORD:C212([SN3_PublicationPrefs:161])
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Copiando la configuración a todos los niveles..."))
		For ($i;1;Size of array:C274(al_NivelesDestino))
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(al_NivelesDestino))
			QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=al_NivelesDestino{$i})
			If (Records in selection:C76([SN3_PublicationPrefs:161])=0)
				SN3_InitPubVariables 
				SN3_SavePubConfig (al_NivelesDestino{$i})
			End if 
			SN3_ParseConfigXML (->$data)
			SN3_ModifyXMLEntry (al_NivelesDestino{$i};vlSN3_CurrDataType)
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
End if 