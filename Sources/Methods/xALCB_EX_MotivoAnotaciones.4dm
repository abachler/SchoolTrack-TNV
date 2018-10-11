//%attributes = {}
  //xALCB_EX_MotivoAnotaciones

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Column;$line)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_Motivos;$Column;$line)
	$cell:=AL_GetCellMod (xALP_Motivos)
	$lineCategoria:=AL_GetLine (xALP_categoria)
	
	
	
	Case of 
		: ($column=2)
			Case of 
				: ((ai_TipoAnotacion{$lineCategoria}=0) & (aiSTR_Anotaciones_puntaje{$line}#0))
					CD_Dlog (0;__ ("No puede asignar puntaje a los motivos de anotación de una categoría Neutra");__ ("");__ ("Aceptar"))
				: ((ai_TipoAnotacion{$lineCategoria}#0) & (aiSTR_Anotaciones_puntaje{$line}=0))
					CD_Dlog (0;__ ("Lo motivos de anotación de la categoría ")+at_STR_CategoriasAnot_Nombres{$lineCategoria}+__ (" deben tener un puntaje distinto de 0.");__ ("");__ ("Aceptar"))
					aiSTR_Anotaciones_puntaje{$line}:=aiSTR_Anotaciones_puntaje{0}
					AL_UpdateArrays (xALP_Motivos;-1)
				Else 
					If (aiSTR_Anotaciones_puntaje{$line}#aiSTR_Anotaciones_puntaje{0})
						WDW_OpenDialogInDrawer (->[xxSTR_Constants:1];"STR_DLG_Consulta_Motivo")
						If (ok=1)
							$posicionEnMatriz:=Find in array:C230(<>atSTR_Anotaciones_motivo;atSTR_Anotaciones_motivo{$line})
							<>aiSTR_Anotaciones_motivo_puntaj{$posicionEnMatriz}:=aiSTR_Anotaciones_puntaje{$line}
							Case of 
								: (r1=1)
									  //`Nada
								: (r2=1)
									QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8=at_STR_CategoriasAnot_Nombres{$lineCategoria};*)
									QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Motivo:3=atSTR_Anotaciones_motivo{$line})
									If (Records in selection:C76([Alumnos_Anotaciones:11])>0)
										$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando Puntaje..."))
										ARRAY LONGINT:C221($aRecNums;0)
										LONGINT ARRAY FROM SELECTION:C647([Alumnos_Anotaciones:11];$aRecNums;"")
										READ WRITE:C146([Alumnos_Anotaciones:11])
										For ($i;1;Size of array:C274($aRecNums))
											GOTO RECORD:C242([Alumnos_Anotaciones:11];$aRecNums{$i})
											If (ai_TipoAnotacion{$lineCategoria}=1)
												[Alumnos_Anotaciones:11]Puntos:9:=aiSTR_Anotaciones_puntaje{$line}
											Else 
												[Alumnos_Anotaciones:11]Puntos:9:=aiSTR_Anotaciones_puntaje{$line}*-1
											End if 
											SAVE RECORD:C53([Alumnos_Anotaciones:11])
											If (Dec:C9($i/20)=0)
												$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Actualizando el puntaje en las anotaciones ya registradas..."))
											End if 
										End for 
										UNLOAD RECORD:C212([Alumnos_Anotaciones:11])
										READ ONLY:C145([Alumnos_Anotaciones:11])
										$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
									End if 
							End case 
							AL_UpdateArrays (xALP_Motivos;-2)
						Else 
							aiSTR_Anotaciones_puntaje{$line}:=aiSTR_Anotaciones_puntaje{0}
							AL_UpdateArrays (xALP_Motivos;-2)
							AL_GotoCell (xALP_Motivos;$Column;$line)
							AL_SetCellHigh (xALP_Motivos;1;255)
						End if 
					End if 
			End case 
			  //MONO 205385
			If (aiSTR_Anotaciones_puntaje{0}#aiSTR_Anotaciones_puntaje{$line})
				$t_logCambios:=__ ("Cambio en puntaje en motivo anotación ^0 cambio el tipo de ^1 a ser ^2";atSTR_Anotaciones_motivo{$line};String:C10(aiSTR_Anotaciones_puntaje{0});String:C10(aiSTR_Anotaciones_puntaje{$line}))+"\n"  //MONO 205385
				APPEND TO ARRAY:C911(at_logCambios;$t_logCambios)
			End if 
		: ($column=1)
			$old:=atSTR_Anotaciones_motivo{0}
			If (Length:C16(atSTR_Anotaciones_motivo{$line})>255)
				BEEP:C151
				atSTR_Anotaciones_motivo{$line}:=Substring:C12(atSTR_Anotaciones_motivo{$line};1;255)
				CD_Dlog (0;__ ("El texto ingresado supera los 255 caracteres."))
			End if 
			If ($old#atSTR_Anotaciones_motivo{$line})
				$element:=Find in array:C230(<>atSTR_Anotaciones_motivo;atSTR_Anotaciones_motivo{$line})
				If ($element>0)
					CD_Dlog (0;__ ("El nombre del motivo ya existe.");__ ("");__ ("Aceptar"))
					atSTR_Anotaciones_motivo{$line}:=$old
					AL_UpdateArrays (xALP_Motivos;-2)
					AL_GotoCell (xALP_Motivos;$Column;$line)
					AL_SetCellHigh (xALP_Motivos;1;255)
				Else 
					$posicionEnMatriz:=Find in array:C230(<>atSTR_Anotaciones_motivo;$old)
					atSTR_Anotaciones_motivo{$line}:=Replace string:C233(atSTR_Anotaciones_motivo{$line};"\r";" ")  //ASM 20150907 Para evitar que se guarde un char (13) al copiar de otro archivo
					atSTR_Anotaciones_motivo{$line}:=Replace string:C233(atSTR_Anotaciones_motivo{$line};Char:C90(34);"")
					<>atSTR_Anotaciones_motivo{$posicionEnMatriz}:=atSTR_Anotaciones_motivo{$line}
					QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8=at_STR_CategoriasAnot_Nombres{$lineCategoria};*)
					QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Motivo:3=$old)
					If (Records in selection:C76([Alumnos_Anotaciones:11])>0)
						$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando el motivo en las anotaciones ya registradas..."))
						ARRAY LONGINT:C221($aRecNums;0)
						LONGINT ARRAY FROM SELECTION:C647([Alumnos_Anotaciones:11];$aRecNums;"")
						READ WRITE:C146([Alumnos_Anotaciones:11])
						SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11];$aRecNums)
						For ($i;1;Size of array:C274($aRecNums))
							READ WRITE:C146([Alumnos_Anotaciones:11])
							GOTO RECORD:C242([Alumnos_Anotaciones:11];$aRecNums{$i})
							[Alumnos_Anotaciones:11]Motivo:3:=atSTR_Anotaciones_motivo{$line}
							SAVE RECORD:C53([Alumnos_Anotaciones:11])
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Actualizando el motivo en las anotaciones ya registradas..."))
						End for 
						KRL_UnloadReadOnly (->[Alumnos_Anotaciones:11])
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					End if 
				End if 
			End if 
			  //MONO 205385
			If (atSTR_Anotaciones_motivo{0}#atSTR_Anotaciones_motivo{$line})
				$t_logCambios:=__ ("Cambio en Motivos Anotación, ^0 pasó a ser ^1";atSTR_Anotaciones_motivo{0};atSTR_Anotaciones_motivo{$line})+"\n"  //MONO 205385
				APPEND TO ARRAY:C911(at_logCambios;$t_logCambios)
			End if 
	End case 
End if 