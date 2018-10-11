C_POINTER:C301($y_calcularDescuento;$y_calculaSoloAfectos;$y_calculaTodos;$y_generaCargosPorCuenta)
ACTpgs_DescuentosXTramo ("ObtienePunteros2ObjetosConfiguracion";->$y_calcularDescuento;->$y_calculaSoloAfectos;->$y_calculaTodos;->$y_generaCargosPorCuenta)
If (Self:C308->=1)
	$y_calculaSoloAfectos->:=0
End if 

LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)
