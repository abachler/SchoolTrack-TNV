  // Método: Método de Formulario: [xxSTR_Constants]ACTusr_DobleArea
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 04-11-10, 16:34:29
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		C_LONGINT:C283(vlACTusr_modoAsignacionCTA;vlACTusr_modoAsignacionCC)
		  //vlACTusr_modoAsignacionCTA:=0 modo normal, uno a uno.
		  //vlACTusr_modoAsignacionCTA:=1 modo masivo, a todos.
		  //vlACTusr_modoAsignacionCTA:=2 modo confirmacion, consulta antes de aplicar a todos.
		
		For ($i;1;Size of array:C274(aQR_Pointer1))
			RESOLVE POINTER:C394(aQR_Pointer1{$i};$varName;$tableNum;$fieldNum)
			$error:=ALP_DefaultColSettings (xALP_Area1;$i;$varName)
		End for 
		ALP_SetDefaultAppareance (xALP_Area1;9;1;6;1;8;2;2)
		AL_SetColOpts (xALP_Area1;1;1;1;2;0)
		AL_SetRowOpts (xALP_Area1;1;1;0;0;1;0)
		AL_SetCellOpts (xALP_Area1;0;1;1)
		AL_SetMiscOpts (xALP_Area1;0;0;"\\";1;1)
		AL_SetMainCalls (xALP_Area1;"";"")
		AL_SetCallbacks (xALP_Area1;"";"")
		AL_SetEntryOpts (xALP_Area1;5;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_Area1;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xALP_Area1;1;"";"";"")
		AL_SetDrgSrc (xALP_Area1;2;"";"";"")
		AL_SetDrgSrc (xALP_Area1;3;"";"";"")
		AL_SetDrgDst (xALP_Area1;1;"";"";"")
		AL_SetDrgDst (xALP_Area1;1;"";"";"")
		AL_SetDrgDst (xALP_Area1;1;"";"";"")
		
		
		  //contra cuentas
		For ($i;1;Size of array:C274(aQR_Pointer2))
			RESOLVE POINTER:C394(aQR_Pointer2{$i};$varName;$tableNum;$fieldNum)
			$error:=ALP_DefaultColSettings (xALP_Area2;$i;$varName)
		End for 
		  //general options
		ALP_SetDefaultAppareance (xALP_Area2;9;1;6;1;8;1;2)
		AL_SetColOpts (xALP_Area2;1;1;1;1;0)
		AL_SetRowOpts (xALP_Area2;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_Area2;0;1;1)
		AL_SetMiscOpts (xALP_Area2;0;0;"\\";1;1)
		AL_SetMainCalls (xALP_Area2;"";"")
		AL_SetCallbacks (xALP_Area2;"";"")
		AL_SetEntryOpts (xALP_Area2;5;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_Area2;0;30;0)
		
		IT_SetButtonState (False:C215;->bClearCCCbl;->bDelLinea)
		
		AL_UpdateArrays (xALP_Area2;-2)
		AL_UpdateArrays (xALP_Area1;-2)
		wref:=WDW_GetWindowID 
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
		
	: (Form event:C388=On Close Box:K2:21)
		vlACTusr_modoAsignacionCTA:=0
		vlACTusr_modoAsignacionCC:=0
		
End case 