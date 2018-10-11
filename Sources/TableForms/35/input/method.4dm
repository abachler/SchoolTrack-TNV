Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		BWR_SetInputButtonsAppearence 
		IT_SetButtonState ((Size of array:C274(alBU_ALID)>0);->bPrintAL)
		IT_SetButtonState (False:C215;->bDelAL)
		
		$err:=ALP_DefaultColSettings (xalp_ListaRec;1;"atBU_RecNombre";__ ("Nombre");110)
		$err:=ALP_DefaultColSettings (xalp_ListaRec;2;"atBU_Jornada";__ ("Jornada");55)
		$err:=ALP_DefaultColSettings (xalp_ListaRec;3;"alBU_Hora";__ ("Hora");45;"&/2")
		$err:=ALP_DefaultColSettings (xalp_ListaRec;4;"atBU_Dia";__ ("Día");50)
		$err:=ALP_DefaultColSettings (xalp_ListaRec;5;"alBU_IdRecorrido")
		$err:=ALP_DefaultColSettings (xalp_ListaRec;6;"alBU_Ruta")
		
		  //general options
		ALP_SetDefaultAppareance (xalp_ListaRec)
		AL_SetColOpts (xalp_ListaRec;1;1;1;0;0)
		AL_SetRowOpts (xalp_ListaRec;0;0;0;0;1;0)
		AL_SetCellOpts (xalp_ListaRec;0;1;1)
		AL_SetMiscOpts (xalp_ListaRec;0;0;"\\";0;1)
		AL_SetMainCalls (xalp_ListaRec;"";"")
		AL_SetScroll (xalp_ListaRec;0;-3)
		AL_SetEntryOpts (xalp_ListaRec;1;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xalp_ListaRec;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xalp_ListaRec;1;"";"";"")
		AL_SetDrgSrc (xalp_ListaRec;2;"";"";"")
		AL_SetDrgSrc (xalp_ListaRec;3;"";"";"")
		AL_SetDrgDst (xalp_ListaRec;1;"";"";"")
		AL_SetDrgDst (xalp_ListaRec;1;"";"";"")
		AL_SetDrgDst (xalp_ListaRec;1;"";"";"")
		
		  //************************************** XALP_INSCRITOS ***********************************************
		
		ARRAY TEXT:C222(atBU_ServPopup;0)
		LIST TO ARRAY:C288("STR_BUServicios";atBU_ServPopup)
		ARRAY TEXT:C222(atBU_AcompPopup;0)
		LIST TO ARRAY:C288("STR_Parentescos";atBU_AcompPopup)
		C_LONGINT:C283($Error)
		
		$err:=ALP_DefaultColSettings (xalp_Inscritos;1;"atBU_ALNom";__ ("Nombre");160)
		$err:=ALP_DefaultColSettings (xalp_Inscritos;2;"atBU_ALCurso";__ ("Curso");56)
		$err:=ALP_DefaultColSettings (xalp_Inscritos;3;"atBU_ALTipoServ";__ ("Servicio");93)
		AL_SetEnterable (xalp_Inscritos;3;2;atBU_ServPopup)
		$err:=ALP_DefaultColSettings (xalp_Inscritos;4;"ap_Acompañado";__ ("Tiene acompañante");73;"1")
		$err:=ALP_DefaultColSettings (xalp_Inscritos;5;"atBU_ALAcompañado";__ ("Acompañante");130)
		AL_SetEnterable (xalp_Inscritos;5;3;atBU_AcompPopup)
		$err:=ALP_DefaultColSettings (xalp_Inscritos;6;"alBU_ALID")
		$err:=ALP_DefaultColSettings (xalp_Inscritos;7;"atBU_ALDesciende")
		
		  //general options
		ALP_SetDefaultAppareance (xalp_Inscritos)
		AL_SetColOpts (xalp_Inscritos;0;0;0;2;0)
		AL_SetRowOpts (xalp_Inscritos;0;0;0;0;1;0)
		AL_SetCellOpts (xalp_Inscritos;0;1;1)
		AL_SetMiscOpts (xalp_Inscritos;0;0;"\\";0;1)
		AL_SetMainCalls (xalp_Inscritos;"";"")
		AL_SetCallbacks (xalp_Inscritos;"";"BU_xALP_CB_EX_Inscritos")
		AL_SetScroll (xalp_Inscritos;0;-3)
		AL_SetEntryOpts (xalp_Inscritos;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xalp_Inscritos;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xalp_Inscritos;1;String:C10(xalp_Inscritos))
		AL_SetDrgDst (xalp_Inscritos;1;String:C10(xALP_Trans1))
		
		$recorrido:=Find in array:C230(alBU_IdRecorrido;vl_IdRec)
		If ($recorrido#-1)
			AL_SetLine (xalp_ListaRec;$recorrido)
			AL_UpdateArrays (xalp_Inscritos;0)
			AL_UpdateArrays (xALP_Trans1;0)
			BU_CtrListas (<>aCursos{<>acursos};alBU_IdRecorrido{$recorrido})
			IT_SetButtonState ((Size of array:C274(alBU_ALID)>0);->bPrintAL)
			IT_SetButtonState (False:C215;->bDelAL)
			AL_UpdateArrays (xALP_Trans1;-2)
			AL_UpdateArrays (xalp_Inscritos;-2)
			AL_SetLine (xalp_Inscritos;0)
		Else 
			
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		$line:=AL_GetLine (xalp_ListaRec)
		BU_Refresh_Recorridos (1;alBU_Ruta{$line})
		AL_UpdateArrays (xalp_Inscripciones;0)
		BU_Refresh_Inscripciones (0)
		AL_UpdateArrays (xalp_Inscripciones;-2)
		CANCEL:C270
End case 
