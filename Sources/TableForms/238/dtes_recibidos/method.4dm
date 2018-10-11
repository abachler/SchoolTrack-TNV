Case of 
	: (Form event:C388=On Load:K2:1)
		
		  //busqueda
		
		C_REAL:C285(vrACT_folio)
		C_DATE:C307(vdACT_fechaEmision)
		C_DATE:C307(vdACT_fechaRecepcion)
		C_TEXT:C284($t_dts)
		C_LONGINT:C283(vlACT_RSSel)
		
		C_DATE:C307(vdACT_fechaEjecucion)
		C_TIME:C306(vhACT_horaEjecucion)
		
		C_LONGINT:C283(l_totalListado)
		
		C_TEXT:C284(vtACT_TextoFiltro)
		
		ACTcfg_OpcionesRazonesSociales ("LoadConfig")
		vlACT_RSSel:=alACTcfg_Razones{aTACTcfg_Razones}
		
		ACTdteRec_Generales ("SetFechaHora")
		
		ACTdteRec_CreaArreglosBusqueda 
		
		If (Size of array:C274(atACTdteRec_Recepcion)>1)
			ACTdteRec_LlenaArreglos (vlACT_RSSel;"";"";0;!00-00-00!;!00-00-00!;"";atACTdteRec_Recepcion{2})
		Else 
			ACTdteRec_LlenaArreglos (vlACT_RSSel)
		End if 
		
		  //ACTdteRec_CreaArreglosBusqueda 
		
		ACTdteRec_Generales ("InicializaOpcionesBusqueda")
		
		  //20160624 RCH Para recibir todos los documentos... Se deja oculto para que lo usen solo en casos especiales
		OBJECT SET VISIBLE:C603(*;"importaRec@";Shift down:C543)
		
	: (Form event:C388=On Close Box:K2:21)
		ACTcfg_DeclaraArreglos ("ACTdteRecibidos_Listado")
		ACTcfg_DeclaraArreglos ("ACTdteRecibidos_Busqueda")
		CANCEL:C270
		
End case 
