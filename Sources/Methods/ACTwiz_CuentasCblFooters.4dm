//%attributes = {}
  //ACTwiz_CuentasCblFooters

ARRAY INTEGER:C220($aselected;0)
$err:=AL_GetSelect (xALP_CuentasCbl;$aselected)
$debec:=AT_GetSumArray (->acampo2)
$haberc:=AT_GetSumArray (->acampo3)

If (Size of array:C274($aselected)>0)
	$debesel:=0
	$habersel:=0
	For ($i;1;Size of array:C274($aselected))
		$debesel:=$debesel+acampo2{$aselected{$i}}
		$habersel:=$habersel+acampo3{$aselected{$i}}
	End for 
	$footerdebe:=String:C10($debec;"|Despliegue_ACT")+"\r"+String:C10($debesel;"|Despliegue_ACT")
	$footerhaber:=String:C10($haberc;"|Despliegue_ACT")+"\r"+String:C10($habersel;"|Despliegue_ACT")
Else 
	$footerdebe:=String:C10($debec;"|Despliegue_ACT")+"\r"+"0"
	$footerhaber:=String:C10($haberc;"|Despliegue_ACT")+"\r"+"0"
End if 
AL_SetFooters (xALP_CuentasCbl;2;2;$footerdebe;$footerhaber)
$debecc:=AT_GetSumArray (->acampocc2)
$habercc:=AT_GetSumArray (->acampocc3)
AL_SetFooters (xALP_ContraCuentasCbl;2;2;String:C10($debecc;"|Despliegue_ACT");String:C10($habercc;"|Despliegue_ACT"))

vrACT_Descuadre:=($debec+$debecc)-($haberc+$habercc)
IT_SetButtonState ((vrACT_Descuadre#0);->bCuadrar)
REDRAW WINDOW:C456
ARRAY INTEGER:C220($aInteger2D;2;0)
For ($i;1;Size of array:C274(aenccuenta))
	If (aenccuenta{$i}#0)
		AL_SetRowColor (xALP_CuentasCbl;$i;"Red";0)
		AL_SetRowStyle (xALP_CuentasCbl;$i;2)
		  //AL_SetCellEnter (xALP_CuentasCbl;1;$i;39;$i;$aInteger2D;0)
	Else 
		AL_SetRowColor (xALP_CuentasCbl;$i;"Black";0)
		AL_SetRowStyle (xALP_CuentasCbl;$i;0)
		  //AL_SetCellEnter (xALP_CuentasCbl;1;$i;39;$i;$aInteger2D;1)
	End if 
End for 

$lineas:=Size of array:C274(acampo1)+Size of array:C274(acampocc1)
IT_SetButtonState (($lineas>0);->bGenerarACbl)