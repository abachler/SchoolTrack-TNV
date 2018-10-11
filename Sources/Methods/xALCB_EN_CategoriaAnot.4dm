//%attributes = {}
  //xALCB_EN_CategoriaAnot

C_LONGINT:C283($1;$2)
C_LONGINT:C283($Column;$line)

ARRAY INTEGER:C220($aInt2;2;0)
AL_GetCurrCell (xALP_categoria;$Column;$line)

Case of 
	: (ai_TipoAnotacion{$line}=-1)
		AL_SetEnterable (xALP_Motivos;2;1)
		AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;1)
		  //AL_SetCellColor (xALP_categoria;3;$line;0;0;$aInt2;"Red")
		AL_SetForeColor (xALP_categoria;3;"";0;"Red")
		AL_SetForeColor (xALP_Motivos;1;"";0;"Red")
		AL_SetForeColor (xALP_Motivos;2;"";0;"Red")
		AL_SetForeColor (xALP_Motivos;3;"";0;"Red")
		AL_SetStyle (xALP_Motivos;2;"Tahoma";9;1)
	: (ai_TipoAnotacion{$line}=0)
		AL_SetEnterable (xALP_Motivos;2;1)
		AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;0)
		  //AL_SetCellColor (xALP_categoria;3;$line;0;0;$aInt2;"Blue")
		AL_SetForeColor (xALP_categoria;3;"";0;"Blue")
		AL_SetForeColor (xALP_Motivos;2;"";0;"Blue")
	: (ai_TipoAnotacion{$line}=1)
		AL_SetEnterable (xALP_Motivos;2;1)
		AL_SetCellEnter (xALP_categoria;3;$line;0;0;$aInt2;1)
		AL_SetForeColor (xALP_categoria;3;"";0;"Green")
		  //AL_SetCellColor (xALP_categoria;3;$line;0;0;$aInt2;"Green")
		AL_SetForeColor (xALP_Motivos;1;"";0;"Green")
		AL_SetForeColor (xALP_Motivos;2;"";0;"Green")
		AL_SetForeColor (xALP_Motivos;3;"";0;"Green")
		AL_SetStyle (xALP_Motivos;2;"Tahoma";9;1)
End case 

  //
  //AL_SetCellColor (xALP_categoria;3;$i;0;0;$aInt2;"Red")
  //AL_SetCellStyle (xALP_categoria;3;$i;0;0;$aInt2;1)
  //
  //AL_SetCellColor (xALP_categoria;3;$i;0;0;$aInt2;"Blue")
  //AL_SetCellStyle (xALP_categoria;3;$i;0;0;$aInt2;1)
  //
  //AL_SetCellColor (xALP_categoria;3;$i;0;0;$aInt2;"Green")

ARRAY TEXT:C222(atSTR_Anotaciones_motivo;0)
ARRAY LONGINT:C221(aiSTR_Anotaciones_puntaje;0)
ARRAY LONGINT:C221(aiSTR_Anotaciones_Registradas;0)
SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
For ($i;1;Size of array:C274(<>atSTR_Anotaciones_categorias))
	If (<>aiID_Matriz{$i}=aiSTR_IDCategoria{$line})
		If (<>atSTR_Anotaciones_motivo{$i}#"")
			QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Motivo:3;=;<>atSTR_Anotaciones_motivo{$i})
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