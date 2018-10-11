C_LONGINT:C283($hResize;$bWidth;$bHeight)


$line:=AL_GetLine (xALP_Configs)

If ($line>0)
	$recNum:=alMPA_RecNumMatriz{$line}
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$recNum)
	
	Case of 
		: ([MPA_AsignaturasMatrices:189]ID_Matriz:1=vlMPA_IDMatrizActual)
			CD_Dlog (0;__ ("La matriz seleccionada es la matriz actual de esta asignatura.\r\rNo puede ser eliminada."))
			
		: ([MPA_AsignaturasMatrices:189]ID_Matriz:1=vlMPA_IDMatrizDefecto)
			CD_Dlog (0;__ ("La matriz seleccionada es la matriz por defecto para las asignatura del área en este nivel académico.\r\rNo puede ser eliminada."))
			
		: ($recNum>=0)
			READ WRITE:C146([MPA_AsignaturasMatrices:189])
			GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$recNum)
			If (([MPA_AsignaturasMatrices:189]ID_Creador:20=<>lUSR_CurrentUserID) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))
				$recNumAsignaturas:=Record number:C243([Asignaturas:18])
				QUERY:C277([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
				If (Records in selection:C76([Asignaturas:18])>0)
					CD_Dlog (0;__ ("Esta configuración es utilizada para una o más asignaturas.\r\rLa configuración seleccionada no puede ser eliminada."))
				Else 
					LOG_RegisterEvt ("Eliminación de matriz de evaluación "+[MPA_AsignaturasMatrices:189]NombreMatriz:2+", "+[Asignaturas:18]Nivel:30+", ID #"+String:C10([MPA_AsignaturasMatrices:189]ID_Matriz:1))
					KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
					KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
					DELETE RECORD:C58([MPA_AsignaturasMatrices:189])
					AL_UpdateArrays (xALP_Configs;0)
					AT_Delete ($line;1;->atMPA_NombreMatriz;->alMPA_RecNumMatriz)
					AL_UpdateArrays (xALP_Configs;-2)
					
					$el:=Find in array:C230(alMPA_RecNumMatriz;vlMPA_RecNumMatrizActual)
					AL_SetLine (xALP_Configs;$el)
					AL_SetRowColor (xALP_Configs;$el;"Red")
					AL_SetRowStyle (xALP_Configs;$el;1)
					
					GOTO RECORD:C242([MPA_AsignaturasMatrices:189];vlMPA_RecNumMatrizActual)
					If ([MPA_AsignaturasMatrices:189]CreadaPor:15#"")
						$createdBy:="Creada por: \r"+[MPA_AsignaturasMatrices:189]CreadaPor:15+" el "
					Else 
						$createdBy:="Creada el: "
					End if 
					If ([MPA_AsignaturasMatrices:189]CreadaPor:15#"")
						$modifiedBy:="\rModificada por: \r"+[MPA_AsignaturasMatrices:189]ModificadaPor:17+" el "
					Else 
						$modifiedBy:="\rModificada el: "
					End if 
					vtEVLG_InfoConfig:=$createdBy+String:C10(DTS_GetDate ([MPA_AsignaturasMatrices:189]DTS_Creacion:16))+", "+String:C10(DTS_GetTime ([MPA_AsignaturasMatrices:189]DTS_Creacion:16);2)
					vtEVLG_InfoConfig:=vtEVLG_InfoConfig+"\r"+$modifiedBy+String:C10(DTS_GetDate ([MPA_AsignaturasMatrices:189]DTS_Modificacion:18))+", "+String:C10(DTS_GetTime ([MPA_AsignaturasMatrices:189]DTS_Modificacion:18);2)
					AL_UpdateArrays (xALP_LogrosAsignaturas;0)
					MPAmtx_LeeConfiguracion (vlMPA_RecNumMatrizActual;1;->alEVLG_AdvCFG_TipoObjeto;->alEVLG_AdvCFG_Ids;->atEVLG_AdvCFG_EjesLogros;->atEVLG_AdvCFG_Icons)
					AL_UpdateArrays (xALP_LogrosAsignaturas;-2)
					
					POST KEY:C465(Character code:C91("=");256)
				End if 
				KRL_ReloadAsReadOnly (->[MPA_AsignaturasMatrices:189])
				GOTO RECORD:C242([Asignaturas:18];$recNumAsignaturas)
			Else 
				CD_Dlog (0;__ ("Usted no es el creador de esta configuración ni tiene permisos para eliminarla.\r\rLa configuración seleccionada no puede ser eliminada."))
			End if 
	End case 
Else 
	CD_Dlog (0;__ ("No hay ninguna matriz de evaluación seleccionada."))
End if 

