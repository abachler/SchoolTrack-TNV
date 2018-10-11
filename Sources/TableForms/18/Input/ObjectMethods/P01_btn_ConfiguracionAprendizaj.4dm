viBWR_RecordWasSaved:=AS_fSave 

If (viBWR_RecordWasSaved>=0)
	If ([Asignaturas:18]EVAPR_IdMatriz:91#0)
		AL_UpdateArrays (xALP_Ejes;0)
		AL_UpdateArrays (xALP_Evaluaciones;0)
		EVLG_ConfiguracionAvanzada 
	Else 
		CD_Dlog (0;__ ("No implementado aún."))
	End if 
End if 