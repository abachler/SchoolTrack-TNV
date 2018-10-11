Case of 
	: (alProEvt=-5)
		AL_GetDrgArea (xALP_Motivos;$destinationArea)
		AL_GetDrgDstTyp (xALP_Motivos;$destinationType)
		Case of 
			: ($destinationArea=xALP_categoria)
				$lineCategoria:=AL_GetLine (xALP_categoria)  //`fila origen
				AL_GetDrgSrcRow (xALP_Motivos;$sourcerow)
				AL_GetDrgDstCol (xALP_categoria;$col)
				AL_GetDrgDstRow (xALP_categoria;$row)
				Case of 
					: ($row>Size of array:C274(at_STR_CategoriasAnot_Nombres)) | (AL_GetLine (xALP_categoria)=$row)
						BEEP:C151
						BEEP:C151
					: ((ai_TipoAnotacion{$lineCategoria}=1) & (ai_TipoAnotacion{$row}=0))
						CD_Dlog (0;__ ("No se puede asignar un motivo de Anotación Positiva  a una Categoría de Anotaciones Neutra");__ ("");__ ("Aceptar"))
					: ((ai_TipoAnotacion{$lineCategoria}=-1) & (ai_TipoAnotacion{$row}=0))
						CD_Dlog (0;__ ("No se puede asignar un motivo de Anotación Negativa a una Categoría de Anotaciones Neutras");__ ("");__ ("Aceptar"))
					: ((ai_TipoAnotacion{$lineCategoria}=0) & (ai_TipoAnotacion{$row}=1))
						CD_Dlog (0;__ ("No se puede asignar un Motivo de Anotación Neutro a una Categoría de Anotaciones Positivas");__ ("");__ ("Aceptar"))
					: ((ai_TipoAnotacion{$lineCategoria}=-1) & (ai_TipoAnotacion{$row}=1))
						CD_Dlog (0;__ ("No se puede asignar un Motivo de Anotación Negativa a una Categoría de Anotaciones Positivas");__ ("");__ ("Aceptar"))
					: ((ai_TipoAnotacion{$lineCategoria}=0) & (ai_TipoAnotacion{$row}=-1))
						CD_Dlog (0;__ ("No se puede asignar un Motivo de Anotación Neutro a una Categoría de Anotaciones Negativas");__ ("");__ ("Aceptar"))
					: ((ai_TipoAnotacion{$lineCategoria}=1) & (ai_TipoAnotacion{$row}=-1))
						CD_Dlog (0;__ ("No se puede asignar un Motivo de Anotación Positiva a una Categoría de Anotaciones Negativas");__ ("");__ ("Aceptar"))
						
					Else 
						$oldCategoria:=at_STR_CategoriasAnot_Nombres{$lineCategoria}
						$newCategoria:=at_STR_CategoriasAnot_Nombres{$row}
						$res:=CD_Dlog (0;__ ("¿Desea realmente mover la anotación desde la categoría ")+$oldCategoria+__ (" a la categoría ")+$newCategoria+__ ("?");__ ("");__ ("Aceptar");__ ("Cancelar"))
						If ($res=1)
							$posOrigen:=Find in array:C230(<>atSTR_Anotaciones_motivo;atSTR_Anotaciones_motivo{$sourcerow})
							<>aiID_Matriz{$posOrigen}:=aiSTR_IDCategoria{$row}
							QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8=at_STR_CategoriasAnot_Nombres{$lineCategoria};*)
							QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Motivo:3=atSTR_Anotaciones_motivo{$sourcerow})
							If (Records in selection:C76([Alumnos_Anotaciones:11])>0)
								$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando anotaciones..."))
								READ WRITE:C146([Alumnos_Anotaciones:11])
								FIRST RECORD:C50([Alumnos_Anotaciones:11])
								For ($j;1;Records in selection:C76([Alumnos_Anotaciones:11]))
									[Alumnos_Anotaciones:11]Categoria:8:=at_STR_CategoriasAnot_Nombres{$row}
									SAVE RECORD:C53([Alumnos_Anotaciones:11])
									$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$j/Records in selection:C76([Alumnos_Anotaciones:11]);__ ("Actualizando anotaciones: ")+String:C10($j)+__ (" de ")+String:C10(Records in selection:C76([Alumnos_Anotaciones:11])))
									NEXT RECORD:C51([Alumnos_Anotaciones:11])
								End for 
								READ ONLY:C145([Alumnos_Anotaciones:11])
								$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
							End if 
							  //MONO 205385
							$t_logCambios:=__ ("Cambio en Motivo de anotación ^0 pasa de categoría ^1 a ser ^2";atSTR_Anotaciones_motivo{$sourcerow};$oldCategoria;$newCategoria)  //MONO 205385
							APPEND TO ARRAY:C911(at_logCambios;$t_logCambios)
							  //MONO 205385
							  //AT_Delete ($sourcerow;1;-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
							AT_Delete ($sourcerow;1;->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje;->aiSTR_Anotaciones_registradas)  //MONO 205385
							AL_UpdateArrays (xALP_Motivos;-2)
							
							CFG_STR_SaveConfiguration ("Conducta")  //MONO 205385
						End if 
				End case 
		End case 
End case 

$line:=AL_GetLine (xALP_categoria)
IT_SetButtonState ($line>0;->bDeleteCategoria)
  //ASM Ticket 206681
If ($line>0)
	ARRAY INTEGER:C220($aInt2;2;0)
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
End if 

$line:=AL_GetLine (xALP_motivos)
IT_SetButtonState ($line>0;->bDeleteMotivo)