Case of 
	: (Form event:C388=On Load:K2:1)
		C_POINTER:C301($y_calcularDescuento)
		
		C_POINTER:C301($y_calcularDescuento;$y_calculaSoloAfectos;$y_calculaTodos;$y_generaCargosPorCuenta)
		ACTpgs_DescuentosXTramo ("ObtienePunteros2ObjetosConfiguracion";->$y_calcularDescuento;->$y_calculaSoloAfectos;->$y_calculaTodos;->$y_generaCargosPorCuenta)
		
		C_OBJECT:C1216($ob_preferencia)
		ACTpgs_DescuentosXTramo ("LeeConf";$y_calcularDescuento;$y_calculaSoloAfectos;$y_calculaTodos;$y_generaCargosPorCuenta)
		
		OBJECT SET ENABLED:C1123(*;"bDeleteDimension";$y_calcularDescuento->=1)
		OBJECT SET ENABLED:C1123(*;"bAddDimension";$y_calcularDescuento->=1)
		OBJECT SET ENABLED:C1123(*;"lb_tramosDctos";$y_calcularDescuento->=1)
		OBJECT SET ENABLED:C1123(*;"rb_CalcularitemsAfectos";$y_calcularDescuento->=1)
		OBJECT SET ENABLED:C1123(*;"rb_CalcularTodos";$y_calcularDescuento->=1)
		OBJECT SET ENABLED:C1123(*;"GeneraCargosSeparadosXCuenta";$y_calcularDescuento->=1)
		
	: (Form event:C388=On Clicked:K2:4)
		C_POINTER:C301($y_calcularDescuento;$y_calculaSoloAfectos;$y_calculaTodos;$y_generaCargosPorCuenta)
		
		ACTpgs_DescuentosXTramo ("ObtienePunteros2ObjetosConfiguracion";->$y_calcularDescuento;->$y_calculaSoloAfectos;->$y_calculaTodos;->$y_generaCargosPorCuenta)
		
		If (($y_calculaTodos->=1) & ($y_calculaSoloAfectos->=1))
			$y_calculaTodos->:=1
			$y_calculaSoloAfectos->:=0
		End if 
		
		OBJECT SET ENABLED:C1123(*;"bDeleteDimension";$y_calcularDescuento->=1)
		OBJECT SET ENABLED:C1123(*;"bAddDimension";$y_calcularDescuento->=1)
		OBJECT SET ENABLED:C1123(*;"lb_tramosDctos";$y_calcularDescuento->=1)
		OBJECT SET ENABLED:C1123(*;"rb_CalcularitemsAfectos";$y_calcularDescuento->=1)
		OBJECT SET ENABLED:C1123(*;"rb_CalcularTodos";$y_calcularDescuento->=1)
		OBJECT SET ENABLED:C1123(*;"GeneraCargosSeparadosXCuenta";$y_calcularDescuento->=1)
		
	: (Form event:C388=On Close Box:K2:21)
		  //Se guarda al presionar cerrar
		  //Con control. se fuerza el cierre de la ventana
		
End case 