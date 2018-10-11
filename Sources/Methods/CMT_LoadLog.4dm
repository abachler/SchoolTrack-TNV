//%attributes = {}
  //CMT_LoadLog

AL_UpdateArrays (xALP_CMT_LogList;0)
If (Selected list items:C379(aHL_CMT_ConfigLog)=2)
	If (vbCMT_LoadedSNLog=False:C215)
		CMT_LoadCMTLog 
	End if 
	COPY ARRAY:C226(adCMT_Log_FechaCMT;adCMT_Log_Fecha)
	COPY ARRAY:C226(atCMT_Log_EventoCMT;atCMT_Log_Evento)
	COPY ARRAY:C226(alCMT_Log_HoraCMT;alCMT_Log_Hora)
Else 
	If (vbCMT_LoadedSTLog=False:C215)
		CMT_LoadSTLog 
	End if 
	COPY ARRAY:C226(adCMT_Log_FechaST;adCMT_Log_Fecha)
	COPY ARRAY:C226(atCMT_Log_EventoST;atCMT_Log_Evento)
	COPY ARRAY:C226(alCMT_Log_HoraST;alCMT_Log_Hora)
End if 
AL_UpdateArrays (xALP_CMT_LogList;-2)
AL_SetLine (xALP_CMT_LogList;0)