$line:=AL_GetLine (xALP_categoria)
$idMatriz:=aiSTR_IDCategoria{$line}
C_LONGINT:C283($anotacionesAñoAnterior;$anotacionesAñoActual;$l_resp)
  //MONO 205385
C_TEXT:C284($t_categoriaEliminar)
$t_categoriaEliminar:=at_STR_CategoriasAnot_Nombres{$line}

QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8=at_STR_CategoriasAnot_Nombres{$line};*)
QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11#<>gYear)
$anotacionesAñoAnterior:=Records in selection:C76([Alumnos_Anotaciones:11])

QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8=at_STR_CategoriasAnot_Nombres{$line};*)
QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11=<>gYear)
CREATE SET:C116([Alumnos_Anotaciones:11];"anotacionesAñoActual")
$anotacionesAñoActual:=Records in selection:C76([Alumnos_Anotaciones:11])

If ($anotacionesAñoActual=0)
	If (Size of array:C274(atSTR_Anotaciones_motivo)>0)
		$l_resp:=CD_Dlog (0;__ ("Esta categoría tiene motivos de anotación definidos pero no utilizados.\r\r¿Desea eliminar la categoría y sus motivos?");__ ("");__ ("Eliminar");__ ("No"))
	Else 
		$l_resp:=1
	End if 
	
	If ($l_resp=1)
		If ($anotacionesAñoAnterior>0)
			$l_resp:=CD_Dlog (0;__ ("Esta categoría tiene anotaciones registradas a alumnos de años anteriores.\r\r¿Está seguro que desea eliminar la categoría?");__ ("");__ ("Eliminar");__ ("No"))
		End if 
	End if 
	If ($l_resp=1)  //MONO 205385
		$size:=Size of array:C274(at_STR_CategoriasAnot_Nombres)
		For ($i;Size of array:C274(<>atSTR_Anotaciones_categorias);1;-1)
			If (<>aiID_Matriz{$i}=$idMatriz)
				AT_Delete ($i;1;-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
			End if 
		End for 
		AT_Delete ($line;1;->at_STR_CategoriasAnot_Nombres;->ai_STR_CategoriasAnot_Puntaje;->aiSTR_IDCategoria;->ai_TipoAnotacion;->ap_TipoAnotacion)
		AL_UpdateArrays (xALP_categoria;-2)
		Case of 
			: ($line=1)
				If (Size of array:C274(at_STR_CategoriasAnot_Nombres)>0)
					AL_SetLine (xALP_categoria;1)
				End if 
			: ($line>1)
				If ($line=$size)
					AL_SetLine (xALP_categoria;$line-1)
				Else 
					AL_SetLine (xALP_categoria;$line)
				End if 
		End case 
		$line:=AL_GetLine (xALP_categoria)
		ARRAY TEXT:C222(atSTR_Anotaciones_motivo;0)
		ARRAY LONGINT:C221(aiSTR_Anotaciones_puntaje;0)
		ARRAY LONGINT:C221(aiSTR_Anotaciones_registradas;0)
		AL_UpdateArrays (xALP_Motivos;-2)
		For ($i;1;Size of array:C274(<>aiID_Matriz))
			If (<>aiID_Matriz{$i}=aiSTR_IDCategoria{$line})
				If (<>atSTR_Anotaciones_motivo{$i}#"")
					AT_Insert (0;1;->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje)
					atSTR_Anotaciones_motivo{Size of array:C274(atSTR_Anotaciones_motivo)}:=<>atSTR_Anotaciones_motivo{$i}
					aiSTR_Anotaciones_puntaje{Size of array:C274(atSTR_Anotaciones_motivo)}:=<>aiSTR_Anotaciones_motivo_puntaj{$i}
				End if 
			End if 
		End for 
		$t_logCambios:=__ ("Se Elimina la Categoría de Anotaciones ^0";$t_categoriaEliminar)  //MONO 205385
		APPEND TO ARRAY:C911(at_logCambios;$t_logCambios)
	End if 
Else 
	CD_Dlog (0;__ ("No puede eliminar este item, la categoría posee anotaciones registradas ");__ ("");__ ("Aceptar"))
End if 
AL_UpdateArrays (xALP_categoria;-2)
AL_SetLine (xALP_categoria;$line)


