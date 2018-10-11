  //OBJETO 3.4 --> Ok Prototipo 1: 27/10/05

Case of 
	: (Form event:C388=On Load:K2:1)
		$err:=AL_SetArraysNam (xALP_Trans1;1;1;"◊aStdWhNme")
		$err:=AL_SetArraysNam (xALP_Trans1;2;1;"◊aStdId")
		AL_SetHeaders (xALP_Trans1;1;1;__ ("Alumnos"))
		ALP_SetDefaultAppareance (xALP_Trans1;11;1;2;1;4)
		AL_SetSort (xALP_Trans1;1)
		AL_SetWidths (xALP_Trans1;1;2;200;52)
		AL_SetMiscOpts (xALP_Trans1;0;0;"\\";0;1)
		AL_SetColOpts (xALP_Trans1;0;0;0;1;0;0;0)
		AL_SetRowOpts (xALP_Trans1;1;1;0;0;0)
		AL_SetSortOpts (xALP_Trans1;1;0;0;"";0)
		AL_SetScroll (xALP_Trans1;0;-3)
		ARRAY INTEGER:C220(alLines;0)
		AL_SetSelect (xALP_Trans1;alLines)
		AL_SetDrgSrc (xALP_Trans1;1;String:C10(xALP_Trans1))
		AL_SetDrgDst (xALP_Trans1;1;String:C10(xalp_Inscritos))
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (Self:C308->#0)
			C_LONGINT:C283($line)
			
			$line:=AL_GetLine (xalp_ListaRec)
			AL_UpdateArrays (xALP_Trans1;0)
			AL_UpdateArrays (xalp_ListaRec;0)
			AL_UpdateArrays (xalp_Inscritos;0)
			BU_CtrListas (<>aCursos{<>acursos};alBU_IdRecorrido{$line})
			AL_UpdateArrays (xALP_Trans1;-2)
			AL_UpdateArrays (xalp_ListaRec;-2)
			AL_UpdateArrays (xalp_Inscritos;-2)
			
		End if 
End case 
