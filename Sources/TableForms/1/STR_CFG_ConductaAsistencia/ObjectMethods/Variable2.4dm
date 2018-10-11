C_TEXT:C284($t_anotacionEliminar)  //MONO 205385
C_BOOLEAN:C305($b_eliminar)  //MONO 205385

$pos:=Find in array:C230(<>aiID_Matriz;AL_GetLine (xALP_categoria))
$line:=AL_GetLine (xALP_Motivos)

If (aiSTR_Anotaciones_registradas{$line}>0)
	$b_eliminar:=False:C215
	CD_Dlog (0;__ ("Existen anotaciones registradas con este motivo.\rEl motivo de anotación no puede ser eliminado"))
Else 
	$b_eliminar:=True:C214
End if 

If ($b_eliminar)
	$posicionEnMatriz:=Find in array:C230(<>atSTR_Anotaciones_motivo;atSTR_Anotaciones_motivo{$line})
	$t_anotacionEliminar:=atSTR_Anotaciones_motivo{$line}+" - "+__ ("Puntaje:")+" "+String:C10(aiSTR_Anotaciones_puntaje{$line})
	$line:=AL_GetLine (xALP_Motivos)
	AT_Delete ($line;1;->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje;->aiSTR_Anotaciones_registradas)
	AT_Delete ($posicionEnMatriz;1;-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
	AL_UpdateArrays (xALP_Motivos;-2)
	AL_SetLine (xALP_Motivos;$line)
	$t_logCambios:=__ ("Se Elimina el Motivo de Anotación ^0";$t_anotacionEliminar)+"\n"  //MONO 205385
	APPEND TO ARRAY:C911(at_logCambios;$t_logCambios)
End if 