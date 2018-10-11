Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		IT_SetButtonState ((Size of array:C274(alBU_IdRuta)>0);->bConfig;->bPrintRuta)
		IT_SetButtonState (False:C215;->bDelRuta)
		
		$err:=ALP_DefaultColSettings (xalp_Rutas;1;"atBU_NombreRuta";__ ("Nombre Ruta");80)
		$err:=ALP_DefaultColSettings (xalp_Rutas;2;"alBU_TotRecorridos";__ ("Recorridos");60;"###")
		$err:=ALP_DefaultColSettings (xalp_Rutas;3;"atBU_PatenteRuta";__ ("Bus");50)
		$err:=ALP_DefaultColSettings (xalp_Rutas;4;"atBU_MonitorRuta";__ ("Monitor");220)
		$err:=ALP_DefaultColSettings (xalp_Rutas;5;"alBU_MonitorID")
		$err:=ALP_DefaultColSettings (xalp_Rutas;6;"alBU_IdRuta")
		
		  //general options
		
		AL_SetColOpts (xalp_Rutas;1;1;1;2;0)
		AL_SetRowOpts (xalp_Rutas;0;1;0;0;1;0)
		AL_SetCellOpts (xalp_Rutas;0;1;1)
		AL_SetMiscOpts (xalp_Rutas;0;0;"\\";0;1)
		AL_SetMiscColor (xalp_Rutas;0;"White";0)
		AL_SetMiscColor (xalp_Rutas;1;"White";0)
		AL_SetMiscColor (xalp_Rutas;2;"White";0)
		AL_SetMiscColor (xalp_Rutas;3;"White";0)
		AL_SetMainCalls (xalp_Rutas;"";"")
		AL_SetScroll (xalp_Rutas;0;-3)
		AL_SetCopyOpts (xalp_Rutas;0;"\t";"\r";Char:C90(0))
		AL_SetSortOpts (xalp_Rutas;0;1;0;"Select the columns to sort:";0)
		AL_SetEntryOpts (xalp_Rutas;1;1;0;0;1;".")
		AL_SetHeight (xalp_Rutas;1;2;1;1;2)
		AL_SetDividers (xalp_Rutas;"No line";"Black";0;"No line";"Black";0)
		AL_SetDrgOpts (xalp_Rutas;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xalp_Rutas;1;"";"";"")
		AL_SetDrgSrc (xalp_Rutas;2;"";"";"")
		AL_SetDrgSrc (xalp_Rutas;3;"";"";"")
		AL_SetDrgDst (xalp_Rutas;1;"";"";"")
		AL_SetDrgDst (xalp_Rutas;1;"";"";"")
		AL_SetDrgDst (xalp_Rutas;1;"";"";"")
		
		AL_SetLine (xalp_Rutas;0)
		
		ALP_SetDefaultAppareance (xalp_Rutas)
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetDefaultAppareance (xalp_Rutas)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 