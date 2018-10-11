//%attributes = {}
  //xALCB_EX_TutoriasProfesores

If (False:C215)
	<>ST_v461:=False:C215  //15/8/98 at 16:53:36 by: Alberto Bachler
	  //implementación de bimestres
End if 


C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_Tutoria3;vCol;vRow)
	
	  //20110426 RCH Se guarda en sintesis.... ***** INICIO *****
	  //Case of 
	  //: (viSTR_Periodos_NumeroPeriodos=2)
	  //Case of 
	  //: (vRow=1)
	  //[Alumnos]Observaciones_Periodo1:=aObsText{vrow}
	  //: (vRow=2)
	  //[Alumnos]Observaciones_Periodo2:=aObsText{vrow}
	  //: (vRow=3)
	  //[Alumnos]Observaciones_finales:=aObsText{vrow}
	  //End case 
	  //: (viSTR_Periodos_NumeroPeriodos=3)
	  //Case of 
	  //: (vRow=1)
	  //[Alumnos]Observaciones_Periodo1:=aObsText{vrow}
	  //: (vRow=2)
	  //[Alumnos]Observaciones_Periodo2:=aObsText{vrow}
	  //: (vRow=3)
	  //[Alumnos]Observaciones_Periodo3:=aObsText{vrow}
	  //: (vRow=4)
	  //[Alumnos]Observaciones_finales:=aObsText{vrow}
	  //End case 
	  //: (viSTR_Periodos_NumeroPeriodos=4)
	  //Case of 
	  //: (vRow=1)
	  //[Alumnos]Observaciones_Periodo1:=aObsText{vrow}
	  //: (vRow=2)
	  //[Alumnos]Observaciones_Periodo2:=aObsText{vrow}
	  //: (vRow=3)
	  //[Alumnos]Observaciones_Periodo3:=aObsText{vrow}
	  //: (vRow=4)
	  //[Alumnos]Observaciones_Periodo4:=aObsText{vrow}
	  //: (vRow=5)
	  //[Alumnos]Observaciones_finales:=aObsText{vrow}
	  //End case 
	  //End case 
	  //SAVE RECORD([Alumnos])
	  //KRL_ReloadAsReadOnly (->[Alumnos])
	aObsText{vrow}:=ST_CleanString (aObsText{vrow})
	Case of 
		: (vRow>viSTR_Periodos_NumeroPeriodos)
			[Alumnos_SintesisAnual:210]Observaciones_Academicas:47:=aObsText{vrow}
		: (vRow=1)
			[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114:=aObsText{vrow}
		: (vRow=2)
			[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143:=aObsText{vrow}
		: (vRow=3)
			[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172:=aObsText{vrow}
		: (vRow=4)
			[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201:=aObsText{vrow}
		: (vRow=5)
			[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230:=aObsText{vrow}
	End case 
	SAVE RECORD:C53([Alumnos_SintesisAnual:210])
	KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
	  //***** FIN *****
End if 