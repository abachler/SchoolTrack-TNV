C_OBJECT:C1216($o_fechasLimites)
C_POINTER:C301($y_fechas)
$o_fechasLimites:=OB_Create 

For ($i;1;5)  //periodos posibles actuales
	$y_fechas:=Get pointer:C304("ad_fechaP"+String:C10($i))
	If (Size of array:C274($y_fechas->)>0)
		OB_SET ($o_fechasLimites;$y_fechas;"LimiteIngresoParciales_P"+String:C10($i))
	End if 
End for 

AS_AplicaFechaLimiteParciales (->alBWR_recordNumber;$o_fechasLimites)
CANCEL:C270
