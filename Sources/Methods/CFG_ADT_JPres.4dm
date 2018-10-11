//%attributes = {}
  //CFG_ADT_JPres

CFG_OpenConfigPanel (->[xxSTR_Constants:1];"ADTcfg_Jornadas")
If (Find in array:C230(adPST_PresentDate;!00-00-00!)>0)
	For ($i;Size of array:C274(adPST_PresentDate);1;-1)
		If (adPST_PresentDate{$i}=!00-00-00!)
			AT_Delete ($i;1;->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
		End if 
	End for 
End if 
PST_SaveParameters 
PST_ReadParameters 