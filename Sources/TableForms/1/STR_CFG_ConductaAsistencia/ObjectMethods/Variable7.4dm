POST KEY:C465(Character code:C91("2");256)

  //$line:=AL_GetLine (xALP_categoria)
  //$lineAnotacion:=AL_GetLine (xALP_Motivos)
  //If ($line=0)
  //CD_Dlog (0;"Debe seleccionar la categoría";"";"Aceptar")
  //Else 
  //$posicion:=$line
  //SORT ARRAY(◊aiID_Matriz;>)
  //For ($i;1;Size of array(◊aiID_Matriz))
  //If (◊aiID_Matriz{$i}=$line)
  //$posicion:=$i
  //End if 
  //End for 
  //vPosicion:=$posicion
  //◊aiID_Matriz{0}:=$line
  //AT_SearchArray (->◊aiID_Matriz;"=")
  //If (Size of array(DA_Return)=1) & (Size of array(atSTR_Anotaciones_motivo)=0)
  //AT_Insert (0;1;->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje;->aiSTR_Anotaciones_registradas)
  //aiSTR_Anotaciones_puntaje{Size of array(aiSTR_Anotaciones_puntaje)}:=ai_STR_CategoriasAnot_Puntaje{$line}
  //Else 
  //vPosicion:=$posicion+1
  //SORT ARRAY(◊aiID_Matriz;◊atSTR_Anotaciones_categorias;◊atSTR_Anotaciones_motivo;◊aiSTR_Anotaciones_puntaje;◊aiSTR_Anotaciones_motivo_puntaj;>)
  //AT_Insert (0;1;->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje;->aiSTR_Anotaciones_registradas)
  //AT_Insert (vPosicion;1;->◊aiID_Matriz;->◊atSTR_Anotaciones_categorias;->◊atSTR_Anotaciones_motivo;->◊aiSTR_Anotaciones_puntaje;->◊aiSTR_Anotaciones_motivo_puntaj)
  //aiSTR_Anotaciones_puntaje{Size of array(aiSTR_Anotaciones_puntaje)}:=ai_STR_CategoriasAnot_Puntaje{$line}
  //◊aiID_Matriz{vPosicion}:=aiSTR_IDCategoria{$line}
  //◊atSTR_Anotaciones_categorias{vPosicion}:=at_STR_CategoriasAnot_Nombres{$line}
  //◊aiSTR_Anotaciones_puntaje{vPosicion}:=ai_STR_CategoriasAnot_Puntaje{$line}
  //End if 
  //AT_Initialize (->DA_Return)
  //AL_UpdateArrays (xALP_Motivos;-2)
  //GOTO AREA(xALP_Motivos)
  //AL_GotoCell (xALP_Motivos;1;Size of array(atSTR_Anotaciones_motivo))
  //AL_SetCellHigh (xALP_Motivos;1;80)
  //End if 
