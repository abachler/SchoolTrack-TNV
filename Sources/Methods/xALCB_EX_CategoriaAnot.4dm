//%attributes = {}
  //xALCB_EX_CategoriaAnot

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Column;$line)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_categoria;$Column;$line)
	$cell:=AL_GetCellMod (xALP_categoria)
	Case of 
		: ($Column=1)  //`Me modifico el nombre de la categoria y no era una nueva categoria
			
			  //20150415 RCH Se limpia debido a que en una base habia un \r al final del nombre de la categoria lo que hacía imposible seleccionar una anotación de ese tipo en STWA.
			at_STR_CategoriasAnot_Nombres{$line}:=ST_GetCleanString (at_STR_CategoriasAnot_Nombres{$line})
			at_STR_CategoriasAnot_Nombres{0}:=ST_GetCleanString (at_STR_CategoriasAnot_Nombres{0})
			
			$old:=at_STR_CategoriasAnot_Nombres{0}
			$element:=Find in array:C230(at_STR_CategoriasAnot_Nombres;at_STR_CategoriasAnot_Nombres{$line})
			  //AT_SearchArray (->at_STR_CategoriasAnot_Nombres;"=")
			If (($element>0) & ($element#$line))
				CD_Dlog (0;__ ("El nombre de la Categoria ya existe.");__ ("");__ ("Aceptar"))
				at_STR_CategoriasAnot_Nombres{$line}:=$old
				AL_UpdateArrays (xALP_categoria;-2)
				AL_GotoCell (xALP_categoria;$Column;$line)
				AL_SetCellHigh (xALP_categoria;1;120)
			Else 
				$el:=Find in array:C230(<>atSTR_Anotaciones_categorias;at_STR_CategoriasAnot_Nombres{0})
				If ($el>0)
					<>atSTR_Anotaciones_categorias{$el}:=at_STR_CategoriasAnot_Nombres{$line}
					If (ai_TipoAnotacion{$line}=1)
						<>aiSTR_Anotaciones_puntaje{$el}:=ai_STR_CategoriasAnot_Puntaje{$line}
					Else 
						<>aiSTR_Anotaciones_puntaje{$el}:=ai_STR_CategoriasAnot_Puntaje{$line}*-1
					End if 
				End if 
				If ($old#at_STR_CategoriasAnot_Nombres{$line})
					QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8=$old)
					If (Records in selection:C76([Alumnos_Anotaciones:11])>0)
						$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Modificando la categoría en las anotaciones ya registradas..."))
						ARRAY LONGINT:C221($aRecNums;0)
						LONGINT ARRAY FROM SELECTION:C647([Alumnos_Anotaciones:11];$aRecNums;"")
						READ WRITE:C146([Alumnos_Anotaciones:11])
						SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11];$aRecNums)
						For ($i;1;Size of array:C274($aRecNums))
							READ WRITE:C146([Alumnos_Anotaciones:11])
							GOTO RECORD:C242([Alumnos_Anotaciones:11];$aRecNums{$i})
							[Alumnos_Anotaciones:11]Categoria:8:=at_STR_CategoriasAnot_Nombres{$line}
							SAVE RECORD:C53([Alumnos_Anotaciones:11])
							If (Dec:C9($i/50)=0)
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Modificando la categoría en las anotaciones ya registradas..."))
							End if 
						End for 
						UNLOAD RECORD:C212([Alumnos_Anotaciones:11])
						READ ONLY:C145([Alumnos_Anotaciones:11])
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					End if 
				End if 
			End if 
			
			  //MONO 205385
			If (at_STR_CategoriasAnot_Nombres{0}#at_STR_CategoriasAnot_Nombres{$line})
				$t_logCambios:=__ ("Cambio en Categoría ^0 pasó a ser ^1";at_STR_CategoriasAnot_Nombres{0};at_STR_CategoriasAnot_Nombres{$line})+"\n"  //MONO 205385
				APPEND TO ARRAY:C911(at_logCambios;$t_logCambios)
			End if 
			
		: ($Column=2)  //MONO 205385
			
			  //MONO 205385
			If (ai_TipoAnotacion{0}#ai_TipoAnotacion{$line})
				$t_logCambios:=__ ("Cambio en Categoría ^0 cambio el tipo de ^1 a ser ^2";at_STR_CategoriasAnot_Nombres{$line};String:C10(ai_TipoAnotacion{0});String:C10(ai_TipoAnotacion{$line}))+"\n"  //MONO 205385
				APPEND TO ARRAY:C911(at_logCambios;$t_logCambios)
			End if 
			
			
		: (($cell=1) & ($Column=3))
			Case of 
					  //20120202 AS  para controlar el ingreso de puntaje
				: ((ai_STR_CategoriasAnot_Puntaje{$line}>999999) | (ai_STR_CategoriasAnot_Puntaje{$line}<0))
					ai_STR_CategoriasAnot_Puntaje{$line}:=ai_STR_CategoriasAnot_Puntaje{0}
					CD_Dlog (0;__ ("El puntaje de la categoría debe ser inferior a 1000000"))
					AL_UpdateArrays (xALP_categoria;-2)
					AL_GotoCell (xALP_categoria;$Column;$line)
					AL_SetCellHigh (xALP_categoria;1;120)
				: ((ai_TipoAnotacion{$line}=1) & (ai_STR_CategoriasAnot_Puntaje{$line}=0))
					ai_STR_CategoriasAnot_Puntaje{$line}:=ai_STR_CategoriasAnot_Puntaje{0}
					CD_Dlog (0;__ ("Las categorías de anotaciones positivas no pueden tener un puntaje igual a 0"))
					AL_UpdateArrays (xALP_categoria;-2)
					AL_GotoCell (xALP_categoria;$Column;$line)
					AL_SetCellHigh (xALP_categoria;1;120)
				: ((ai_TipoAnotacion{$line}=-1) & (ai_STR_CategoriasAnot_Puntaje{$line}=0))
					ai_STR_CategoriasAnot_Puntaje{$line}:=ai_STR_CategoriasAnot_Puntaje{0}
					CD_Dlog (0;__ ("Las categorías de anotaciones negativas no pueden tener un puntaje igual a 0"))
					AL_UpdateArrays (xALP_categoria;-2)
					AL_GotoCell (xALP_categoria;$Column;$line)
					AL_SetCellHigh (xALP_categoria;1;120)
				: ((ai_TipoAnotacion{$line}=0) & (ai_STR_CategoriasAnot_Puntaje{$line}#0))
					ai_STR_CategoriasAnot_Puntaje{$line}:=ai_STR_CategoriasAnot_Puntaje{0}
					CD_Dlog (0;__ ("Las categorías de anotaciones neutras no pueden tener un puntaje distinto de 0"))
					AL_UpdateArrays (xALP_categoria;-2)
					AL_GotoCell (xALP_categoria;$Column;$line)
					AL_SetCellHigh (xALP_categoria;1;120)
				Else 
					If (ai_STR_CategoriasAnot_Puntaje{0}#ai_STR_CategoriasAnot_Puntaje{$line})  //`Me modifico el valor por defecto de la categoría
						WDW_OpenDialogInDrawer (->[xxSTR_Constants:1];"STR_DLG_Consulta")
						If (ok=1)
							Case of 
								: (r1=1)
									  //`nada
								: (r2=1)
									For ($i;1;Size of array:C274(<>aiID_Matriz))
										If (<>aiID_Matriz{$i}=aiSTR_IDCategoria{$line})
											If (ai_TipoAnotacion{$line}=1)
												<>aiSTR_Anotaciones_motivo_puntaj{$i}:=ai_STR_CategoriasAnot_Puntaje{$line}
											Else 
												<>aiSTR_Anotaciones_motivo_puntaj{$i}:=ai_STR_CategoriasAnot_Puntaje{$line}
											End if 
										End if 
									End for 
									For ($i;1;Size of array:C274(aiSTR_Anotaciones_puntaje))
										aiSTR_Anotaciones_puntaje{$i}:=ai_STR_CategoriasAnot_Puntaje{$line}
									End for 
									AL_UpdateArrays (xALP_Motivos;-2)
									CFG_STR_SaveConfiguration ("Conducta")
								: (r3=1)
									QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8=at_STR_CategoriasAnot_Nombres{$line})
									If (Records in selection:C76([Alumnos_Anotaciones:11])>0)
										$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando Puntaje..."))
										READ WRITE:C146([Alumnos_Anotaciones:11])
										FIRST RECORD:C50([Alumnos_Anotaciones:11])
										For ($j;1;Records in selection:C76([Alumnos_Anotaciones:11]))
											If (ai_TipoAnotacion{$line}=1)
												[Alumnos_Anotaciones:11]Puntos:9:=ai_STR_CategoriasAnot_Puntaje{$line}
											Else 
												[Alumnos_Anotaciones:11]Puntos:9:=ai_STR_CategoriasAnot_Puntaje{$line}*-1
											End if 
											SAVE RECORD:C53([Alumnos_Anotaciones:11])
											$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$j/Records in selection:C76([Alumnos_Anotaciones:11]);__ ("Actualizando anotaciones: ")+String:C10($j)+__ (" de ")+String:C10(Records in selection:C76([Alumnos_Anotaciones:11])))
											NEXT RECORD:C51([Alumnos_Anotaciones:11])
										End for 
										READ ONLY:C145([Alumnos_Anotaciones:11])
										$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
									End if 
									For ($i;1;Size of array:C274(<>aiID_Matriz))
										If (<>aiID_Matriz{$i}=aiSTR_IDCategoria{$line})
											If (ai_TipoAnotacion{$line}=1)
												<>aiSTR_Anotaciones_motivo_puntaj{$i}:=ai_STR_CategoriasAnot_Puntaje{$line}
											Else 
												<>aiSTR_Anotaciones_motivo_puntaj{$i}:=ai_STR_CategoriasAnot_Puntaje{$line}
											End if 
										End if 
									End for 
									For ($i;1;Size of array:C274(aiSTR_Anotaciones_puntaje))
										aiSTR_Anotaciones_puntaje{$i}:=ai_STR_CategoriasAnot_Puntaje{$line}
									End for 
									AL_UpdateArrays (xALP_Motivos;-2)
									CFG_STR_SaveConfiguration ("Conducta")
							End case 
							AL_ExitCell (xALP_categoria)
							GOTO OBJECT:C206(xALP_motivos)
							AL_SetLine (xALP_categoria;$line)
						Else 
							$el:=Find in array:C230(<>atSTR_Anotaciones_categorias;at_STR_CategoriasAnot_Nombres{$line})
							If ($el>0)
								<>atSTR_Anotaciones_categorias{$el}:=at_STR_CategoriasAnot_Nombres{$line}
								If (ai_TipoAnotacion{$line}=1)
									<>aiSTR_Anotaciones_puntaje{$el}:=ai_STR_CategoriasAnot_Puntaje{$line}
								Else 
									<>aiSTR_Anotaciones_puntaje{$el}:=ai_STR_CategoriasAnot_Puntaje{$line}
								End if 
							End if 
							ai_STR_CategoriasAnot_Puntaje{$line}:=ai_STR_CategoriasAnot_Puntaje{0}
							AL_UpdateArrays (xALP_categoria;-2)
							AL_GotoCell (xALP_categoria;$Column;$line)
							AL_SetCellHigh (xALP_categoria;1;120)
						End if 
					End if 
			End case 
			  //MONO 205385
			If (t_cambioCategoria#String:C10(ai_STR_CategoriasAnot_Puntaje{$line}))
				$t_logCambios:=__ ("Cambio en Categoría ^0 cambio el puntaje de ^1 a ser ^2";at_STR_CategoriasAnot_Nombres{$line};t_cambioCategoria;String:C10(ai_STR_CategoriasAnot_Puntaje{$line}))+"\n"  //MONO 205385
				APPEND TO ARRAY:C911(at_logCambios;$t_logCambios)
			End if 
	End case 
End if 

