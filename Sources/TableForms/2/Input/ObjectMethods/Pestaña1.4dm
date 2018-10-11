  //Método de Objeto: hlTab_STR_alumnosHistorico



Case of 
	: (Form event:C388=On Clicked:K2:4)
		AL_ExitCell (xALP_HNotasECursos)
		
		$page:=Selected list items:C379(Self:C308->)
		asigHist:=""
		vtSTR_AL_Observaciones:=""
		vtSTR_AL_LabelObservaciones:=""
		
		
		Case of 
			: ($page=1)
				ALP_RemoveAllArrays (xALP_HNotasECursos)
				AL_SetEntryOpts (xALP_HNotasECursos;1)
				al_LoadHNotas 
				  //$key:=String(◊gInstitucion)+"."+String(vl_Year_Historico)+"."+String(vl_NivelSeleccionado_Historico)+"."+String(Abs([Alumnos_Histórico]Alumno_Numero)
				  //$recNUm:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual]LlavePrincipal;->$key;True)
				AL_SetEnterable (xALP_HNotasECursos;0;0)
				
			: ($page=2)
				ALP_RemoveAllArrays (xALP_HNotasECursos)
				AL_HistoricoObservacionesPJ 
				
				
			: ($page=3)
				$rows:=AL_GetLine (xALP_HNotasECursos)  //ASM 20140602 Ticket  133506
				$rows:=Choose:C955((($rows=0) & (Size of array:C274(aNtaRecNum)>0));1;$rows)
				If ((Size of array:C274(aNtaRecNum)>0) & ($rows>0))
					ALP_RemoveAllArrays (xALP_HNotasECursos)
					GOTO RECORD:C242([Alumnos_Calificaciones:208];aNtaRecNum{$rows})
					AL_LeeObservacionesHistoricas (aNtaRecNum{$rows})
				End if 
				
			: ($page=4)
				ALP_RemoveAllArrays (xALP_HNotasECursos)
				al_LoadECursos (xALP_HNotasECursos;2)
				AL_UpdateArrays (xALP_HNotasECursos;-2)
				AL_SetEnterable (xALP_HNotasECursos;0;0)
				
		End case 
		
		
		
		
		OBJECT SET COLOR:C271(*;"Historic@";-3078)
		OBJECT SET VISIBLE:C603(*;"nivelhistorico@";False:C215)
		OBJECT SET VISIBLE:C603(*;"NewNotasH@";($page=1) | ($page=2))
		OBJECT SET VISIBLE:C603(*;"coment@";($page=2) | ($page=3))
		OBJECT SET VISIBLE:C603(*;"comentPopUp";$page=3)
		OBJECT SET VISIBLE:C603(*;"coment4";$page=3)
		OBJECT SET VISIBLE:C603(*;"NotasH@";$page=1)
End case 
