C_LONGINT:C283($records)

If ((vbMPA_ConfiguracionesPropias) | (USR_IsGroupMember_by_GrpID (-15001)))
	
	
	$selectedConfigRecNum:=Record number:C243([MPA_AsignaturasMatrices:189])
	$ConfigName:=[MPA_AsignaturasMatrices:189]NombreMatriz:2
	
	$popUpItems:="Nueva Matriz;Duplicar matriz seleccionada"
	$result:=Pop up menu:C542($popUpItems;0)
	If ($result>0)
		$recNumAsignatura:=Record number:C243([Asignaturas:18])
		$recNumMateria:=Find in field:C653([xxSTR_Materias:20]Materia:2;[Asignaturas:18]Asignatura:3)
		$recNumArea:=Find in field:C653([MPA_DefinicionAreas:186]AreaAsignatura:4;[xxSTR_Materias:20]AreaMPA:4)
		GOTO RECORD:C242([MPA_DefinicionAreas:186];$recNumArea)
		KRL_GotoRecord (->[xxSTR_Materias:20];$recNumMateria;False:C215)
		If (OK=1)
			$recNumArea:=Find in field:C653([MPA_DefinicionAreas:186]AreaAsignatura:4;[xxSTR_Materias:20]AreaMPA:4)
			KRL_GotoRecord (->[MPA_DefinicionAreas:186];$recNumArea;False:C215)
			If (OK=1)
				SCAN INDEX:C350([MPA_AsignaturasMatrices:189]ID_Matriz:1;1;<)
				$nextID:=String:C10([MPA_AsignaturasMatrices:189]ID_Matriz:1+1)
				KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$selectedConfigRecNum;True:C214)
				$nombreMatriz:=[Asignaturas:18]denominacion_interna:16+" - "+[Asignaturas:18]Nivel:30+" ("+$nextID+")"
				
				
				$nombreMatriz:=CD_Request (__ ("Nombre de la nueva matriz de Evaluación:");__ ("Aceptar");__ ("Cancelar");__ ("");$nombreMatriz)
				While (Find in array:C230(atMPA_NombreMatriz;$nombreMatriz)>0)
					CD_Dlog (0;__ ("Ya existe una matriz con el mismo nombre para esta asignatura en este nivel.\r\rPor favor ingrese un nombre diferente."))
					$nombreMatriz:=CD_Request (__ ("Nombre de la nueva matriz de Evaluación:");__ ("Aceptar");__ ("Cancelar");__ ("");$nombreMatriz)
				End while 
				
				If ($nombreMatriz#"")
					CREATE RECORD:C68([MPA_AsignaturasMatrices:189])
					[MPA_AsignaturasMatrices:189]ID_Matriz:1:=SQ_SeqNumber (->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
					[MPA_AsignaturasMatrices:189]ID_Creador:20:=<>lUSR_CurrentUserID
					[MPA_AsignaturasMatrices:189]CreadaPor:15:=<>tUSR_CurrentUser
					[MPA_AsignaturasMatrices:189]DTS_Creacion:16:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
					[MPA_AsignaturasMatrices:189]ModificadaPor:17:=[MPA_AsignaturasMatrices:189]CreadaPor:15
					[MPA_AsignaturasMatrices:189]DTS_Modificacion:18:=[MPA_AsignaturasMatrices:189]DTS_Creacion:16
					[MPA_AsignaturasMatrices:189]ID_Area:22:=[MPA_DefinicionAreas:186]ID:1
					[MPA_AsignaturasMatrices:189]Area:13:=[MPA_DefinicionAreas:186]AreaAsignatura:4
					[MPA_AsignaturasMatrices:189]Asignatura:3:=[Asignaturas:18]Asignatura:3
					[MPA_AsignaturasMatrices:189]NumeroNivel:4:=[Asignaturas:18]Numero_del_Nivel:6
					[MPA_AsignaturasMatrices:189]NombreMatriz:2:=$nombreMatriz
					[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19:=False:C215
					SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
					$recNumNuevaMatriz:=Record number:C243([MPA_AsignaturasMatrices:189])
					$idMatriz:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
					GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$recNumNuevaMatriz)
					Case of 
						: ($result=2)
							GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$selectedConfigRecNum)
							ARRAY LONGINT:C221($aRecNums;0)
							QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
							LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$aRecNums;"")
							For ($i;1;Size of array:C274($aRecNums))
								GOTO RECORD:C242([MPA_ObjetosMatriz:204];$aRecNums{$i})
								DUPLICATE RECORD:C225([MPA_ObjetosMatriz:204])
								[MPA_ObjetosMatriz:204]Auto_UUID:28:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
								[MPA_ObjetosMatriz:204]ID_Matriz:1:=$idMatriz
								SAVE RECORD:C53([MPA_ObjetosMatriz:204])
							End for 
					End case 
					
					
					KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$recNumNuevaMatriz)
					
					AL_UpdateArrays (xALP_Configs;0)
					APPEND TO ARRAY:C911(atMPA_NombreMatriz;[MPA_AsignaturasMatrices:189]NombreMatriz:2)
					APPEND TO ARRAY:C911(alMPA_RecNumMatriz;$recNumNuevaMatriz)
					AL_UpdateArrays (xALP_Configs;-2)
					AL_SetLine (xALP_Configs;Size of array:C274(alMPA_RecNumMatriz))
					
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
					MPAmtx_LeeConfiguracion ($recNumNuevaMatriz;$refPeriodo;->alEVLG_AdvCFG_TipoObjeto;->alEVLG_AdvCFG_Ids;->atEVLG_AdvCFG_EjesLogros;->atEVLG_AdvCFG_Icons)
					AL_UpdateArrays (xALP_LogrosAsignaturas;-2)
					
					POST KEY:C465(Character code:C91("=");256)
					
				End if 
			Else 
				
			End if 
		Else 
			
		End if 
	Else 
		
	End if 
Else 
	CD_Dlog (0;__ ("Usted no dispone de los permisos necesarios para crear configuraciones personalizadas de Aprendizajes Esperados."))
End if 