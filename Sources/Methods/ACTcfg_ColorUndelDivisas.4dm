//%attributes = {}
  //ACTcfg_ColorUndelDivisas 


ARRAY INTEGER:C220($aInt2D;2;0)

For ($i;1;Size of array:C274(atACT_NombreMoneda))
	$vl_idMoneda:=alACT_IdRegistro{$i}
	If ((KRL_GetBooleanFieldData (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;->[xxACT_Monedas:146]Es_Moneda_Oficial:5)) | ($vl_idMoneda=-6))
		AL_SetCellEnter (xALP_Divisas;1;$i;5;$i;$aInt2D;0)
		AL_SetCellColor (xALP_Divisas;1;$i;5;$i;$aInt2D;"Red";0;"";0)
	End if 
End for 
$posDef:=Find in array:C230(abACT_MonedaXDef_Base;True:C214)
If ($posDef#-1)
	AL_SetCellEnter (xALP_Divisas;1;$posDef;5;$posDef;$aInt2D;0)
	AL_SetCellColor (xALP_Divisas;1;$posDef;5;$posDef;$aInt2D;"Red";0;"Light Gray";0)
End if 
