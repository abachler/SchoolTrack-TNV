  //$line:=AL_GetLine (xALP_Divisas)
  //If ($line=0)
  //$line:=Size of array(atACT_NombreMoneda)
  //End if 
  //If ($line=1)
  //$line:=2
  //End if 
  //$line:=$line+1
AL_ExitCell (xALP_Divisas)
C_LONGINT:C283($vl_idNuevaMoneda)
AL_UpdateArrays (xALP_Divisas;0)
$vl_idNuevaMoneda:=Num:C11(ACTcfgmyt_OpcionesGenerales ("AgregaMoneda"))
  //AT_Insert ($line+1;1;->atACT_NombreMoneda;->arACT_ValorMoneda;->atACT_SimboloMoneda)
  //atACT_NombreMoneda{$line+1}:="Nueva Moneda"
  //arACT_ValorMoneda{$line+1}:=1
$line:=Find in array:C230(alACT_IdRegistro;$vl_idNuevaMoneda)
AL_UpdateArrays (xALP_Divisas;-2)
ALP_SetAlternateLigneColor (xALP_Divisas;Size of array:C274(atACT_NombreMoneda))
GOTO OBJECT:C206(xALP_Divisas)
AL_GotoCell (xALP_Divisas;1;$line)
AL_SetCellHigh (xALP_Divisas;1;80)
ACTcfg_ColorUndelDivisas 
AL_UpdateArrays (xALP_Divisas;-1)
vtACT_MonedaSel:=atACT_NombreMoneda{$line}
