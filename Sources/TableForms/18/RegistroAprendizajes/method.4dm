Case of 
	: (Form event:C388=On Load:K2:1)
		vlEVLG_mostrarObservacion:=Num:C11(PREF_fGet (0;"Indicador/Observación";"0"))
		
		
		EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;aNtaIdAlumno{aNtaIdAlumno};[Asignaturas:18]EVAPR_IdMatriz:91)
		AL_SetBackRGBColor (xALP_Aprendizajes;0;0;0;0;255;255;255;255;255;255)
		AL_SetAltRowColor (xALP_Aprendizajes;255;255;255;1)
		AL_SetWidths (xALP_Aprendizajes;1;1;442)
		
		
		Case of 
			: (aNtaIDAlumno=1)
				OBJECT SET ENABLED:C1123(bBWR_PreviousRecord;False:C215)
				OBJECT SET ENABLED:C1123(bBWR_FirstRecord;False:C215)
				OBJECT SET ENABLED:C1123(bBWR_NextRecord;True:C214)
				OBJECT SET ENABLED:C1123(bBWR_LastRecord;True:C214)
			: (aNtaIDAlumno=Size of array:C274(aNtaIDAlumno))
				OBJECT SET ENABLED:C1123(bBWR_PreviousRecord;True:C214)
				OBJECT SET ENABLED:C1123(bBWR_FirstRecord;True:C214)
				OBJECT SET ENABLED:C1123(bBWR_NextRecord;False:C215)
				OBJECT SET ENABLED:C1123(bBWR_LastRecord;False:C215)
			Else 
				OBJECT SET ENABLED:C1123(bBWR_PreviousRecord;True:C214)
				OBJECT SET ENABLED:C1123(bBWR_FirstRecord;True:C214)
				OBJECT SET ENABLED:C1123(bBWR_NextRecord;True:C214)
				OBJECT SET ENABLED:C1123(bBWR_LastRecord;True:C214)
		End case 
		
		If (vl_PeriodoSeleccionado#viSTR_PeriodoActual_Numero)
			vb_AvisaSiCambioPeriodo:=True:C214
			OBJECT SET COLOR:C271(vt_periodo;-3)
		Else 
			OBJECT SET COLOR:C271(vt_periodo;-5)
		End if 
		
		If (<>vb_BloquearModifSituacionFinal)
			OBJECT SET VISIBLE:C603(*;"bloqueoRegistro";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"bloqueoRegistro";False:C215)
		End if 
		
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 