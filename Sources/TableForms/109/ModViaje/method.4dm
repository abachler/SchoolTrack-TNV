Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		BWR_SetInputButtonsAppearence 
		
		READ ONLY:C145([BU_Rutas:26])
		ALL RECORDS:C47([BU_Rutas:26])
		SELECTION TO ARRAY:C260([BU_Rutas:26]Nombre:9;atRuta;[BU_Rutas:26]ID:12;alIDRuta)
		IT_SetButtonState (False:C215;->bDelViajes)
		IT_SetButtonState (False:C215;->atRecorrido)
		
		vtNombreRuta:=""
		vtNombreRec:=""
		
		$err:=ALP_DefaultColSettings (xalp_Viajes;1;"adBU_Fecha";__ ("Fecha");148;"0")
		$err:=ALP_DefaultColSettings (xalp_Viajes;2;"alBU_NumeroViaje";__ ("Número");148;"######")
		
		  //general options
		
		AL_SetColOpts (xalp_Viajes;1;1;1;0;0)
		AL_SetRowOpts (xalp_Viajes;0;0;0;0;1;0)
		AL_SetCellOpts (xalp_Viajes;0;1;1)
		AL_SetMiscOpts (xalp_Viajes;0;0;"\\";0;1)
		AL_SetMiscColor (xalp_Viajes;0;"White";0)
		AL_SetMiscColor (xalp_Viajes;1;"White";0)
		AL_SetMiscColor (xalp_Viajes;2;"White";0)
		AL_SetMiscColor (xalp_Viajes;3;"White";0)
		AL_SetMainCalls (xalp_Viajes;"";"")
		AL_SetScroll (xalp_Viajes;0;0)
		AL_SetCopyOpts (xalp_Viajes;0;"\t";"\r";Char:C90(0))
		AL_SetSortOpts (xalp_Viajes;0;1;0;"Select the columns to sort:";0)
		AL_SetEntryOpts (xalp_Viajes;1;0;0;0;0;".")
		AL_SetHeight (xalp_Viajes;1;2;1;1;2)
		AL_SetDividers (xalp_Viajes;"No line";"Black";0;"No line";"Black";0)
		AL_SetDrgOpts (xalp_Viajes;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xalp_Viajes;1;"";"";"")
		AL_SetDrgSrc (xalp_Viajes;2;"";"";"")
		AL_SetDrgSrc (xalp_Viajes;3;"";"";"")
		AL_SetDrgDst (xalp_Viajes;1;"";"";"")
		AL_SetDrgDst (xalp_Viajes;1;"";"";"")
		AL_SetDrgDst (xalp_Viajes;1;"";"";"")
		
		
		
		ALP_SetDefaultAppareance (xalp_Viajes)
		
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 