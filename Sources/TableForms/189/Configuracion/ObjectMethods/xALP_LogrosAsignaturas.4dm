C_LONGINT:C283($result)
C_BOOLEAN:C305($CollapseExpand)

$recNum:=Record number:C243([MPA_AsignaturasMatrices:189])
$idMatriz:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
$idAsignatura:=[Asignaturas:18]Numero:1
$idProfesor:=[Asignaturas:18]profesor_numero:4
Case of 
	: (alProEvt=AL Row drag event)
		  //If ([MPA_AsignaturasMatrices]ConfiguracionPrincipal) | (([MPA_AsignaturasMatrices]ID_Creador#◊lUSR_CurrentUserID) & (◊lUSR_CurrentUserID>0) & (Not(USR_IsGroupMember_by_GrpID (-15001)))))
		$recNum:=Record number:C243([MPA_AsignaturasMatrices:189])
		If ([MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19)
			CD_Dlog (0;__ ("Esta es la matriz de evaluación de competencias por defecto.\r\rDebe ser modificada en Configuración / Subsectores de aprendizaje."))
		Else 
			
			If (([MPA_AsignaturasMatrices:189]ID_Creador:20=USR_GetUserID ) | (USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID )))
				$recNumAsignatura:=Record number:C243([Asignaturas:18])
				QUERY:C277([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91=$idMatriz;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero:1#$idAsignatura;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]profesor_numero:4#$idProfesor)
				If (Records in selection:C76([Asignaturas:18])>0)
					SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$aAsignaturas;[Asignaturas:18]Curso:5;$aCursos;[Asignaturas:18]profesor_nombre:13;$aProfesores)
					$lista:=""
					For ($i;1;Size of array:C274($aAsignaturas))
						$lista:=$aAsignaturas{$i}+", "+$aCursos{$i}+", "+$aProfesores{$i}+"."+Char:C90(Carriage return:K15:38)
					End for 
					$go:=False:C215
					$ignore:=CD_Dlog (0;__ ("Esta matriz es utilizada en las asignaturas listadas más abajo.\rNo es posible modificarla.\r\r")+$lista)
				Else 
					$go:=True:C214
				End if 
				KRL_GotoRecord (->[Asignaturas:18];$recNumAsignatura;True:C214)
			Else 
				$go:=False:C215
				$ignore:=CD_Dlog (0;__ ("Usted no es el creador de esta matriz.\rSólo su creador o un miembro del grupo Administración puede modificarla."))
			End if 
			
			If ($go)
				If (Not:C34(Semaphore:C143("UsoMatrizLogros"+String:C10($idMatriz))))
					$selectedItem:=Selected list items:C379(hl_Periodos)
					GET LIST ITEM:C378(hl_Periodos;Selected list items:C379(hl_Periodos);$refPeriodo;$nombrePeriodo)
					AL_GetDrgArea (Self:C308->;$destArea;$destProcess)
					If ($destArea#xALP_LogrosAsignaturas)
						AL_GetDrgSrcRow (Self:C308->;$srcRow)
						Case of 
							: (alEVLG_AdvCFG_TipoObjeto{$srcRow}=Eje_Aprendizaje)
								  //$msg:=Replace string(RP_GetIdxString (21017;4);"ˆ0";atEVLG_EjesLogros{$srcRow})
								$answer:=CD_Dlog (0;Replace string:C233(__ ("¿Desea quitar todas los Competencias del Eje de aprendizaje \"ˆ0\" de la configuracion seleccionada?");__ ("ˆ0");atEVLG_EjesLogros{$srcRow});__ ("");__ ("Si");__ ("No"))
								If ($answer=1)
									$idEje:=alEVLG_AdvCFG_Ids{$srcRow}
									EVLG_RetiraAprendizaje ($idMatriz;$idEje;$refPeriodo;Eje_Aprendizaje)
									KRL_ReloadInReadWriteMode (->[MPA_AsignaturasMatrices:189])
									[MPA_AsignaturasMatrices:189]DTS_Modificacion:18:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
									[MPA_AsignaturasMatrices:189]ModificadaPor:17:=USR_GetUserName (USR_GetUserID )
									SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
									KRL_ReloadAsReadOnly (->[MPA_AsignaturasMatrices:189])
									AL_UpdateArrays (xALP_LogrosAsignaturas;0)
									MPAmtx_LeeConfiguracion ($recNum;$refPeriodo;->alEVLG_AdvCFG_TipoObjeto;->alEVLG_AdvCFG_Ids;->atEVLG_AdvCFG_EjesLogros;->atEVLG_AdvCFG_Icons)
									AL_UpdateArrays (xALP_LogrosAsignaturas;-2)
								End if 
								
							: (alEVLG_AdvCFG_TipoObjeto{$srcRow}=Dimension_Aprendizaje)
								OK:=CD_Dlog (0;__ ("¿Desea quitar la dimensión de aprendizaje y los ennciados que puedan depender de ella de esta configuración?");__ ("");__ ("Si");__ ("No"))
								If (OK=1)
									$idDimension:=alEVLG_AdvCFG_Ids{$srcRow}
									EVLG_RetiraAprendizaje ($idMatriz;$idDimension;$refPeriodo;Dimension_Aprendizaje)
									KRL_ReloadInReadWriteMode (->[MPA_AsignaturasMatrices:189])
									[MPA_AsignaturasMatrices:189]DTS_Modificacion:18:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
									[MPA_AsignaturasMatrices:189]ModificadaPor:17:=USR_GetUserName (USR_GetUserID )
									SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
									KRL_ReloadAsReadOnly (->[MPA_AsignaturasMatrices:189])
									AL_UpdateArrays (xALP_LogrosAsignaturas;0)
									MPAmtx_LeeConfiguracion ($recNum;$refPeriodo;->alEVLG_AdvCFG_TipoObjeto;->alEVLG_AdvCFG_Ids;->atEVLG_AdvCFG_EjesLogros;->atEVLG_AdvCFG_Icons)
									AL_UpdateArrays (xALP_LogrosAsignaturas;-2)
								End if 
								
							: (alEVLG_AdvCFG_TipoObjeto{$srcRow}=Logro_Aprendizaje)
								OK:=CD_Dlog (0;__ ("¿Desea quitar la Competencia seleccionada de esta configuración?");__ ("");__ ("Si");__ ("No"))
								If (OK=1)
									$idCompetencia:=alEVLG_AdvCFG_Ids{$srcRow}
									EVLG_RetiraAprendizaje ($idMatriz;$idCompetencia;$refPeriodo;Logro_Aprendizaje)
									KRL_ReloadInReadWriteMode (->[MPA_AsignaturasMatrices:189])
									[MPA_AsignaturasMatrices:189]DTS_Modificacion:18:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
									[MPA_AsignaturasMatrices:189]ModificadaPor:17:=USR_GetUserName (USR_GetUserID )
									SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
									KRL_ReloadAsReadOnly (->[MPA_AsignaturasMatrices:189])
									AL_UpdateArrays (xALP_LogrosAsignaturas;0)
									MPAmtx_LeeConfiguracion ($recNum;$refPeriodo;->alEVLG_AdvCFG_TipoObjeto;->alEVLG_AdvCFG_Ids;->atEVLG_AdvCFG_EjesLogros;->atEVLG_AdvCFG_Icons)
									AL_UpdateArrays (xALP_LogrosAsignaturas;-2)
								End if 
						End case 
						POST KEY:C465(Character code:C91("=");256)
					End if 
					CLEAR SEMAPHORE:C144("UsoMatrizLogros"+String:C10($idMatriz))
					
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
					
					
				End if 
			End if 
		End if 
		
	: (alProEvt=AL Empty Area Single click)
		
	: (alProEvt=AL Empty Area Control Click)
		
		
	: (alProEvt=AL Single click event)
		$line:=AL_GetLine (Self:C308->)
		If ($line>0)
			$column:=AL_GetColumn (Self:C308->)
			If ($column=1)
				$CollapseExpand:=True:C214
			End if 
		End if 
	: (alProEvt=AL Double click event)
		$CollapseExpand:=True:C214
End case 


If ($CollapseExpand)
	$line:=AL_GetLine (Self:C308->)
	$icon:=Num:C11(atEVLG_AdvCFG_Icons{$line})
	Case of 
		: ($icon=9002)  //desplegado, colapsamos
			$tipoObjeto:=alEVLG_AdvCFG_TipoObjeto{$line}
			AL_UpdateArrays (Self:C308->;0)
			EVLG_ExpandCollapseObject ("Collapse";$idMatriz;$tipoObjeto;alEVLG_AdvCFG_Ids{$line};$line;->alEVLG_AdvCFG_TipoObjeto;->alEVLG_AdvCFG_Ids;->atEVLG_AdvCFG_EjesLogros;->atEVLG_AdvCFG_Icons)
			AL_UpdateArrays (Self:C308->;-2)
			POST KEY:C465(Character code:C91("=");256)
			
		: ($icon=9003)  //colapsado, desplegamos
			$tipoObjeto:=alEVLG_AdvCFG_TipoObjeto{$line}
			AL_UpdateArrays (Self:C308->;0)
			EVLG_ExpandCollapseObject ("Expand";$idMatriz;$tipoObjeto;alEVLG_AdvCFG_Ids{$line};$line;->alEVLG_AdvCFG_TipoObjeto;->alEVLG_AdvCFG_Ids;->atEVLG_AdvCFG_EjesLogros;->atEVLG_AdvCFG_Icons)
			
			AL_UpdateArrays (Self:C308->;-2)
			AL_SetLine (Self:C308->;$line+1)
			POST KEY:C465(Character code:C91("=");256)
	End case 
End if 

