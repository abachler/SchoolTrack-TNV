Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		BWR_SetInputButtonsAppearence 
		IT_SetButtonState (False:C215;->bDelFunc)
		
		$err:=ALP_DefaultColSettings (xalp_BURec;1;"atBU_RecNombre";__ ("Nombre");85)
		$err:=ALP_DefaultColSettings (xalp_BURec;2;"atBU_Jornada";__ ("Jornada");55)
		$err:=ALP_DefaultColSettings (xalp_BURec;3;"alBU_Hora";__ ("Hora");55;"&/2")
		$err:=ALP_DefaultColSettings (xalp_BURec;4;"atBU_Dia";__ ("Día");80)
		$err:=ALP_DefaultColSettings (xalp_BURec;5;"alBU_IdRecorrido")
		$err:=ALP_DefaultColSettings (xalp_BURec;6;"alBU_Ruta")
		
		  //general options
		ALP_SetDefaultAppareance (xalp_BURec)
		AL_SetColOpts (xalp_BURec;1;1;1;2;0)
		AL_SetRowOpts (xalp_BURec;0;0;0;0;1;0)
		AL_SetCellOpts (xalp_BURec;0;1;1)
		AL_SetMiscOpts (xalp_BURec;0;0;"\\";0;1)
		AL_SetMainCalls (xalp_BURec;"";"")
		AL_SetScroll (xalp_BURec;0;-3)
		AL_SetEntryOpts (xalp_BURec;1;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xalp_BURec;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xalp_BURec;1;"";"";"")
		AL_SetDrgSrc (xalp_BURec;2;"";"";"")
		AL_SetDrgSrc (xalp_BURec;3;"";"";"")
		AL_SetDrgDst (xalp_BURec;1;"";"";"")
		AL_SetDrgDst (xalp_BURec;1;"";"";"")
		AL_SetDrgDst (xalp_BURec;1;"";"";"")
		
		  //***************************** PROFESORES INSCRITOS **********************************************************
		
		$err:=ALP_DefaultColSettings (xalp_BUFunc;1;"atBU_PFNom";__ ("Nombre Funcionario");160)
		$err:=ALP_DefaultColSettings (xalp_BUFunc;2;"atBU_PFCargo";__ ("Cargo");120)
		$err:=ALP_DefaultColSettings (xalp_BUFunc;3;"alBU_PFID")
		
		
		  //general options
		ALP_SetDefaultAppareance (xalp_BUFunc)
		AL_SetColOpts (xalp_BUFunc;1;1;1;1;0)
		AL_SetRowOpts (xalp_BUFunc;0;0;0;0;1;0)
		AL_SetCellOpts (xalp_BUFunc;0;1;1)
		AL_SetMiscOpts (xalp_BUFunc;0;0;"\\";0;1)
		AL_SetMainCalls (xalp_BUFunc;"";"")
		AL_SetScroll (xalp_BUFunc;0;0)
		AL_SetEntryOpts (xalp_BUFunc;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xalp_BUFunc;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xalp_BUFunc;1;String:C10(xalp_BUFunc))
		AL_SetDrgDst (xalp_BUFunc;1;String:C10(xalp_BUListaFunc))
		
		
		$err:=ALP_DefaultColSettings (xalp_BUListaFunc;1;"atBU_PFNomGen";__ ("Nombre");190)
		$err:=ALP_DefaultColSettings (xalp_BUListaFunc;2;"atBU_PFCargoGen";__ ("Cargo");150)
		$err:=ALP_DefaultColSettings (xalp_BUListaFunc;3;"alBU_PFIdGen")
		
		  //general options
		ALP_SetDefaultAppareance (xalp_BUListaFunc)
		AL_SetColOpts (xalp_BUListaFunc;1;1;1;1;0)
		AL_SetRowOpts (xalp_BUListaFunc;0;0;0;0;1;0)
		AL_SetCellOpts (xalp_BUListaFunc;0;1;1)
		AL_SetMiscOpts (xalp_BUListaFunc;0;0;"\\";0;1)
		AL_SetMainCalls (xalp_BUListaFunc;"";"")
		AL_SetScroll (xalp_BUListaFunc;0;0)
		AL_SetEntryOpts (xalp_BUListaFunc;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xalp_BUListaFunc;0;30;0)
		
		  //dragging options
		AL_SetDrgSrc (xalp_BUListaFunc;1;String:C10(xalp_BUListaFunc))
		AL_SetDrgDst (xalp_BUListaFunc;1;String:C10(xalp_BUFunc))
		
		
		$recorrido:=Find in array:C230(alBU_IdRecorrido;vl_IdRec)
		If ($recorrido#-1)
			AL_SetLine (xalp_BURec;$recorrido)
			AL_UpdateArrays (xalp_BUFunc;0)
			  //AL_UpdateArrays (xALP_BUListaFunc;0)
			BU_CtrListasProfesores (vl_IdRec)
			IT_SetButtonState (False:C215;->bDelFunc)
			  //AL_UpdateArrays (xALP_Trans1;-2)
			AL_UpdateArrays (xalp_BUFunc;-2)
			AL_SetLine (xalp_BUFunc;0)
		Else 
			
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		$line:=AL_GetLine (xalp_BURec)
		BU_Refresh_Recorridos (1;alBU_Ruta{$line})
		AL_UpdateArrays (xalp_Inscripciones;0)
		BU_Refresh_Inscripciones (0)
		AL_UpdateArrays (xalp_Inscripciones;-2)
		CANCEL:C270
		
End case 
