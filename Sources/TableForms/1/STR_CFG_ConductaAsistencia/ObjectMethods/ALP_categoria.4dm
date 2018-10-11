ARRAY INTEGER:C220($aInt2;2;0)
Case of 
	: (alProEvt=-1)
		$line:=AL_GetLine (Self:C308->)
		$currentCategoria:=at_STR_CategoriasAnot_Nombres{$line}
		AL_GetSort (Self:C308->;$col)
		If ($col=2)
			If (IT_AltKeyIsDown )
				AL_SetSort (Self:C308->;-5)
			Else 
				AL_SetSort (Self:C308->;5)
			End if 
		Else 
			AL_SetSort (Self:C308->;$col)
		End if 
		$el:=Find in array:C230(at_STR_CategoriasAnot_Nombres;$currentCategoria)
		AL_SetLine (Self:C308->;$el)
		
	: (alProEvt=5)
		$menuRef:=Create menu:C408("CategoríaAnotacion")
		APPEND MENU ITEM:C411($menuRef;"Positiva;Neutra;Negativa")
		SET MENU ITEM PARAMETER:C1004($menuRef;1;"+")
		SET MENU ITEM ICON:C984($menuRef;1;31932)
		SET MENU ITEM PARAMETER:C1004($menuRef;2;"=")
		SET MENU ITEM ICON:C984($menuRef;2;31931)
		SET MENU ITEM PARAMETER:C1004($menuRef;3;"-")
		SET MENU ITEM ICON:C984($menuRef;3;31930)
		
		$col:=AL_GetColumn (Self:C308->)
		$line:=AL_GetLine (Self:C308->)
		If ($col=2)
			$currentType:=ai_TipoAnotacion{$line}
			Case of 
				: ($currentType=1)
					$typeParam:="+"
				: ($currentType=0)
					$typeParam:="="
				: ($currentType=-1)
					$typeParam:="-"
			End case 
			$parameter:=Dynamic pop up menu:C1006($menuRef;$typeParam)
			
			RELEASE MENU:C978($menuRef)
			
			If ($parameter#"")
				$currentType:=ai_TipoAnotacion{$line}
				Case of 
					: ($currentType=1)
						$OldType_Text:="Positiva"
					: ($currentType=0)
						$OldType_Text:="Neutra"
					: ($currentType=-1)
						$OldType_Text:="Negativa"
				End case 
				Case of 
					: ($parameter="+")
						$newType:=1
						$newType_Text:="Positiva"
						GET PICTURE FROM LIBRARY:C565(31932;$icon)
					: ($parameter="=")
						$newType_Text:="Neutra"
						$newType:=0
						GET PICTURE FROM LIBRARY:C565(31931;$icon)
					: ($parameter="-")
						$newType:=-1
						$newType_Text:="Negativa"
						GET PICTURE FROM LIBRARY:C565(31930;$icon)
				End case 
				If ($newType#$currentType)
					  //lectura y despliegue de las anotyaciones de la categoría seleccionada
					ARRAY TEXT:C222(atSTR_Anotaciones_motivo;0)
					ARRAY LONGINT:C221(aiSTR_Anotaciones_puntaje;0)
					ARRAY LONGINT:C221(aiSTR_Anotaciones_Registradas;0)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
					$totalRecords:=0
					For ($i;1;Size of array:C274(<>atSTR_Anotaciones_categorias))
						If (<>aiID_Matriz{$i}=aiSTR_IDCategoria{$line})
							If (<>atSTR_Anotaciones_motivo{$i}#"")
								QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Motivo:3;=;<>atSTR_Anotaciones_motivo{$i})
								AT_Insert (0;1;->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje;->aiSTR_Anotaciones_registradas)
								atSTR_Anotaciones_motivo{Size of array:C274(atSTR_Anotaciones_motivo)}:=<>atSTR_Anotaciones_motivo{$i}
								aiSTR_Anotaciones_puntaje{Size of array:C274(atSTR_Anotaciones_motivo)}:=<>aiSTR_Anotaciones_motivo_puntaj{$i}
								aiSTR_Anotaciones_registradas{Size of array:C274(atSTR_Anotaciones_motivo)}:=$records
								$totalRecords:=$totalRecords+$records
							End if 
						End if 
					End for 
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					AL_UpdateArrays (xALP_Motivos;-2)
					AL_SetLine (xALP_Motivos;0)
					
					If (Size of array:C274(atSTR_Anotaciones_motivo)>0)
						Case of 
							: ($totalRecords>0)
								  //$msg:="Ya existen anotaciones registradas con motivos de esta categoría.\rSi cambia el ti"+"po cambiará también el puntaje asignado a todos los motivos de esta categoría y e"+"ste cambio será aplicado también a las anotaciones ya registradas con estcategor"+"ía."+"\r¿Está usted realmente seguro de querer cambiar el tipo de la categoría de anotac"+"i"+"ón?"
								  //$msg:=$msg+"\r¿Está usted realmente seguro de querer cambiar el tipo de la categoría de anotac"+"i"+"ón?"
								OK:=CD_Dlog (0;__ ("Ya existen anotaciones registradas con motivos de esta categoría.\rSi cambia el tipo cambiará también el puntaje asignado a todos los motivos de esta categoría y este cambio será aplicado también a las anotaciones ya registradas con esta categoría.\r"+"¿"+"tá usted realmente seguro de querer cambiar el tipo de la categoría de anotación?");__ ("");__ ("No");__ ("Si"))
								If (OK=2)
									ai_TipoAnotacion{$line}:=$newType
									ap_TipoAnotacion{$line}:=$icon
									Case of 
										: (ai_TipoAnotacion{$line}=-1)
											ai_STR_CategoriasAnot_Puntaje{$line}:=1
											$signo:="-"
										: (ai_TipoAnotacion{$line}=0)
											ai_STR_CategoriasAnot_Puntaje{$line}:=0
											$signo:="="
										: (ai_TipoAnotacion{$line}=1)
											ai_STR_CategoriasAnot_Puntaje{$line}:=1
											$signo:="+"
									End case 
									AL_UpdateArrays (Self:C308->;-1)
									$pID:=IT_UThermometer (1;0;__ ("Aplicando cambio de tipo de anotaciones..."))
									CREATE EMPTY SET:C140([Alumnos_Anotaciones:11];"Cambios")
									For ($i;1;Size of array:C274(<>atSTR_Anotaciones_categorias))
										If (<>aiID_Matriz{$i}=aiSTR_IDCategoria{$line})
											If (<>atSTR_Anotaciones_motivo{$i}#"")
												<>aiSTR_Anotaciones_puntaje{$i}:=ai_STR_CategoriasAnot_Puntaje{$line}
												<>aiSTR_Anotaciones_motivo_puntaj{$i}:=ai_STR_CategoriasAnot_Puntaje{$line}
												$el:=Find in array:C230(atSTR_Anotaciones_motivo;<>atSTR_Anotaciones_motivo{$i})
												If ($el>0)
													aiSTR_Anotaciones_puntaje{$el}:=ai_STR_CategoriasAnot_Puntaje{$line}
												End if 
												QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Motivo:3;=;<>atSTR_Anotaciones_motivo{$i})
												CREATE SET:C116([Alumnos_Anotaciones:11];"temp")
												UNION:C120("Cambios";"temp";"Cambios")
												SET_ClearSets ("temp")
												ARRAY LONGINT:C221($a_aiPuntos;0)
												ARRAY TEXT:C222($a_atSigno;0)
												C_LONGINT:C283($v_puntaje)
												C_TEXT:C284($v_signo)
												$v_puntaje:=ai_STR_CategoriasAnot_Puntaje{$line}*$newType
												$v_signo:=$signo
												AT_RedimArrays (Records in selection:C76([Alumnos_Anotaciones:11]);->$a_aiPuntos;->$a_atSigno)
												AT_Populate (->$a_aiPuntos;->$v_puntaje)
												AT_Populate (->$a_atSigno;->$v_signo)
												$result:=KRL_Array2Selection (->$a_aiPuntos;->[Alumnos_Anotaciones:11]Puntos:9;->$a_atSigno;->[Alumnos_Anotaciones:11]Signo:7)
											End if 
										End if 
									End for 
									IT_UThermometer (-2;$pID)
									$pID:=IT_UThermometer (1;0;__ ("Recontabilizando anotaciones..."))
									USE SET:C118("Cambios")
									DISTINCT VALUES:C339([Alumnos_Anotaciones:11]Alumno_Numero:6;$aIds)
									For ($i;1;Size of array:C274($aIds))
										AL_TotalizaAnotaciones ($aIds{$i})
									End for 
									IT_UThermometer (-2;$pID)
									LOG_RegisterEvt ("Cambio de tipo de anotación para los motivos de la categoría "+at_STR_CategoriasAnot_Nombres{$line}+": De "+Char:C90(34)+$OldType_Text+Char:C90(34)+" a "+Char:C90(34)+$newType_Text+Char:C90(34))
								End if 
								
							: ($totalRecords=0)
								  //$msg:="Ya existen anotaciones registradas con motivos de esta categoría.\rSi cambia el ti"+"po cambiará también el puntaje asignado a todos los motivos de esta categoría."+"\r¿Está usted realmente seguro de querer cambiar el tipo de la categoría deotac"+"i"+"ón?"
								  //$msg:=$msg+"\r¿Está usted realmente seguro de querer cambiar el tipo de la categoría de anotac"+"i"+"ón?"
								OK:=CD_Dlog (0;__ ("Ya existen anotaciones registradas con motivos de esta categoría.\rSi cambia el tipo cambiará también el puntaje asignado a todos los motivos de esta categoría.\r¿Está usted realmente seguro de querer cambiar el tipo de la categoría de anotación?");__ ("");__ ("No");__ ("Si"))
								If (OK=2)
									ai_TipoAnotacion{$line}:=$newType
									ap_TipoAnotacion{$line}:=$icon
									Case of 
										: (ai_TipoAnotacion{$line}=-1)
											ai_STR_CategoriasAnot_Puntaje{$line}:=1
										: (ai_TipoAnotacion{$line}=0)
											ai_STR_CategoriasAnot_Puntaje{$line}:=0
										: (ai_TipoAnotacion{$line}=1)
											ai_STR_CategoriasAnot_Puntaje{$line}:=1
									End case 
									
									For ($i;1;Size of array:C274(<>atSTR_Anotaciones_categorias))
										If (<>aiID_Matriz{$i}=aiSTR_IDCategoria{$line})
											If (<>atSTR_Anotaciones_motivo{$i}#"")
												<>aiSTR_Anotaciones_puntaje{$i}:=ai_STR_CategoriasAnot_Puntaje{$line}
												<>aiSTR_Anotaciones_motivo_puntaj{$i}:=ai_STR_CategoriasAnot_Puntaje{$line}
												$el:=Find in array:C230(atSTR_Anotaciones_motivo;<>atSTR_Anotaciones_motivo{$i})
												If ($el>0)
													aiSTR_Anotaciones_puntaje{$el}:=ai_STR_CategoriasAnot_Puntaje{$line}
												End if 
											End if 
										End if 
									End for 
								End if 
						End case 
						
					Else 
						ai_TipoAnotacion{$line}:=$newType
						ap_TipoAnotacion{$line}:=$icon
						AL_UpdateArrays (Self:C308->;-1)
						Case of 
							: (ai_TipoAnotacion{$line}=-1)
								ai_STR_CategoriasAnot_Puntaje{$line}:=1
								AL_SetEnterable (xALP_Motivos;2;0)
								AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;1)
								AL_SetCellColor (xALP_categoria;3;$line;0;0;$aInt2;"Red")
								AL_SetForeColor (xALP_Motivos;3;"";0;"Red")
							: (ai_TipoAnotacion{$line}=0)
								ai_STR_CategoriasAnot_Puntaje{$line}:=0
								AL_SetEnterable (xALP_Motivos;2;1)
								AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;0)
								AL_SetCellColor (xALP_categoria;3;$line;0;0;$aInt2;"Blue")
								AL_SetForeColor (xALP_Motivos;3;"";0;"Blue")
							: (ai_TipoAnotacion{$line}=1)
								ai_STR_CategoriasAnot_Puntaje{$line}:=1
								AL_SetEnterable (xALP_Motivos;2;1)
								AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;1)
								AL_SetCellColor (xALP_categoria;3;$line;0;0;$aInt2;"Green")
								AL_SetForeColor (xALP_Motivos;3;"";0;"Green")
						End case 
					End if 
				End if 
			End if 
			Case of 
				: (ai_TipoAnotacion{$line}=-1)
					AL_SetEnterable (xALP_Motivos;2;1)
					AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;1)
					AL_SetForeColor (xALP_categoria;3;"";0;"Red")
					AL_SetForeColor (xALP_Motivos;1;"";0;"Red")
					AL_SetForeColor (xALP_Motivos;2;"";0;"Red")
					AL_SetForeColor (xALP_Motivos;3;"";0;"Red")
					AL_SetStyle (xALP_Motivos;2;"Tahoma";9;1)
				: (ai_TipoAnotacion{$line}=0)
					AL_SetEnterable (xALP_Motivos;2;1)
					AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;0)
					AL_SetForeColor (xALP_categoria;3;"";0;"Blue")
					AL_SetForeColor (xALP_Motivos;2;"";0;"Blue")
				: (ai_TipoAnotacion{$line}=1)
					AL_SetEnterable (xALP_Motivos;2;1)
					AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;1)
					AL_SetForeColor (xALP_categoria;3;"";0;"Green")
					AL_SetForeColor (xALP_Motivos;1;"";0;"Green")
					AL_SetForeColor (xALP_Motivos;2;"";0;"Green")
					AL_SetForeColor (xALP_Motivos;3;"";0;"Green")
					AL_SetStyle (xALP_Motivos;2;"Tahoma";9;1)
			End case 
			AL_UpdateArrays (xALP_categoria;-2)
			AL_UpdateArrays (xALP_Motivos;-2)
		End if 
		
	: (alProEvt=1)
		$line:=AL_GetLine (Self:C308->)
		Case of 
			: (ai_TipoAnotacion{$line}=-1)
				AL_SetEnterable (xALP_Motivos;2;1)
				AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;1)
				AL_SetForeColor (xALP_categoria;3;"";0;"Red")
				AL_SetForeColor (xALP_Motivos;1;"";0;"Red")
				AL_SetForeColor (xALP_Motivos;2;"";0;"Red")
				AL_SetForeColor (xALP_Motivos;3;"";0;"Red")
				AL_SetStyle (xALP_Motivos;2;"Tahoma";9;1)
			: (ai_TipoAnotacion{$line}=0)
				AL_SetEnterable (xALP_Motivos;2;0)
				AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;0)
				AL_SetForeColor (xALP_categoria;3;"";0;"Blue")
				AL_SetForeColor (xALP_Motivos;1;"";0;"Blue")
				AL_SetForeColor (xALP_Motivos;2;"";0;"Blue")
				AL_SetForeColor (xALP_Motivos;3;"";0;"Blue")
			: (ai_TipoAnotacion{$line}=1)
				AL_SetEnterable (xALP_Motivos;2;1)
				AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;1)
				AL_SetForeColor (xALP_categoria;3;"";0;"Green")
				AL_SetForeColor (xALP_Motivos;1;"";0;"Green")
				AL_SetForeColor (xALP_Motivos;2;"";0;"Green")
				AL_SetForeColor (xALP_Motivos;3;"";0;"Green")
				AL_SetStyle (xALP_Motivos;2;"Tahoma";9;1)
		End case 
		
		ARRAY TEXT:C222(atSTR_Anotaciones_motivo;0)
		ARRAY LONGINT:C221(aiSTR_Anotaciones_puntaje;0)
		ARRAY LONGINT:C221(aiSTR_Anotaciones_Registradas;0)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
		For ($i;1;Size of array:C274(<>atSTR_Anotaciones_categorias))
			If (<>aiID_Matriz{$i}=aiSTR_IDCategoria{$line})
				If (<>atSTR_Anotaciones_motivo{$i}#"")
					QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Motivo:3;=;<>atSTR_Anotaciones_motivo{$i};*)
					QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11=<>gYear)
					AT_Insert (0;1;->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje;->aiSTR_Anotaciones_registradas)
					atSTR_Anotaciones_motivo{Size of array:C274(atSTR_Anotaciones_motivo)}:=<>atSTR_Anotaciones_motivo{$i}
					aiSTR_Anotaciones_puntaje{Size of array:C274(atSTR_Anotaciones_motivo)}:=<>aiSTR_Anotaciones_motivo_puntaj{$i}
					aiSTR_Anotaciones_registradas{Size of array:C274(atSTR_Anotaciones_motivo)}:=$records
				End if 
			End if 
		End for 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		AL_UpdateArrays (xALP_Motivos;-2)
		AL_SetLine (xALP_Motivos;0)
		
End case 

$line:=AL_GetLine (xALP_categoria)
IT_SetButtonState ($line>0;->bDeleteCategoria)
$line:=AL_GetLine (xALP_motivos)
IT_SetButtonState ($line>0;->bDeleteMotivo)