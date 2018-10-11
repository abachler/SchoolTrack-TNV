AL_ExitCell (xALP_Aprendizajes)
If (aNtaIDAlumno<Size of array:C274(aNtaIDAlumno))
	aNtaIDAlumno:=Size of array:C274(aNtaIDAlumno)
	aNtaStdNme:=aNtaIDAlumno
	Case of 
		: (aNtaIDAlumno=1)
			_O_DISABLE BUTTON:C193(bBWR_PreviousRecord)
			_O_DISABLE BUTTON:C193(bBWR_FirstRecord)
			_O_ENABLE BUTTON:C192(bBWR_NextRecord)
			_O_ENABLE BUTTON:C192(bBWR_LastRecord)
		: (aNtaIDAlumno=Size of array:C274(aNtaIDAlumno))
			_O_DISABLE BUTTON:C193(bBWR_NextRecord)
			_O_DISABLE BUTTON:C193(bBWR_LastRecord)
			_O_ENABLE BUTTON:C192(bBWR_PreviousRecord)
			_O_ENABLE BUTTON:C192(bBWR_FirstRecord)
		Else 
			_O_ENABLE BUTTON:C192(bBWR_PreviousRecord)
			_O_ENABLE BUTTON:C192(bBWR_FirstRecord)
			_O_ENABLE BUTTON:C192(bBWR_NextRecord)
			_O_ENABLE BUTTON:C192(bBWR_LastRecord)
	End case 
	EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;aNtaIDAlumno{aNtaIDAlumno};[Asignaturas:18]EVAPR_IdMatriz:91)
Else 
	BEEP:C151
End if 
