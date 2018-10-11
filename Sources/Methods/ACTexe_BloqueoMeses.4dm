//%attributes = {}
  //ACTexe_BloqueoMeses

C_TEXT:C284(vMesNombre1;vMesNombre2;vMesNombre3;vMesNombre4;vMesNombre5;vMesNombre6;vMesNombre7;vMesNombre8;vMesNombre9;vMesNombre10;vMesNombre11;vMesNombre12)
C_LONGINT:C283(cb_Cerrado1;cb_Cerrado2;cb_Cerrado3;cb_Cerrado4;cb_Cerrado5;cb_Cerrado6;cb_Cerrado7;cb_Cerrado8;cb_Cerrado9;cb_Cerrado10;cb_Cerrado11;cb_Cerrado12)
C_BOOLEAN:C305(vb_BloqDef1;vb_BloqDef2;vb_BloqDef3;vb_BloqDef4;vb_BloqDef5;vb_BloqDef6;vb_BloqDef7;vb_BloqDef8;vb_BloqDef9;vb_BloqDef10;vb_BloqDef11;vb_BloqDef12)

If (USR_GetMethodAcces (Current method name:C684))
	If (Not:C34(Semaphore:C143("BloqueoMeses")))
		WDW_OpenFormWindow (->[xxACT_CierresMensuales:108];"Configuracion";-1;4;__ ("Bloqueos Mensuales"))
		DIALOG:C40([xxACT_CierresMensuales:108];"Configuracion")
		CLOSE WINDOW:C154
		If (ok=1)
			LOG_RegisterEvt ("Bloqueo o liberación de bloqueo de meses.")
		End if 
		CLEAR SEMAPHORE:C144("BloqueoMeses")
	Else 
		CD_Dlog (0;__ ("Otro usuario está realizando bloqueo o liberación de meses."))
	End if 
End if 