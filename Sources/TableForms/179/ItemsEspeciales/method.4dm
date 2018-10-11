Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ACTcfg_pctsXFechaPago (2)
		ACTcfgcar_SetObjects ("SetPrivilegios")
		OBJECT SET ENTERABLE:C238(*;"obj_NoEdit@";False:C215)
		
		
		C_LONGINT:C283(hl_listaIntereses;$vl_item)
		hl_listaIntereses:=New list:C375
		APPEND TO LIST:C376(hl_listaIntereses;__ ("Cuenta en contabilidad");1)
		APPEND TO LIST:C376(hl_listaIntereses;__ ("Contra cuenta en contabilidad");2)
		SELECT LIST ITEMS BY POSITION:C381(hl_listaIntereses;1)
		$vl_item:=Selected list items:C379(hl_listaIntereses)
		OBJECT SET VISIBLE:C603(*;"cc1_@";($vl_item=1))
		OBJECT SET VISIBLE:C603(*;"ccc@";($vl_item=2))
		
		ACTint_OpcionesGenerales   //20160908 RCH
		
		OBJECT SET ENABLED:C1123(*;"vr_afectoIVAIE";<>bint_AfectoExentoSegunCargo=0)
		
		  //20170506 RCH
		ACTdesc_OpcionesGenerales ("OnLoadConf")
		
	: (Form event:C388=On Clicked:K2:4)
		ACTcfgcar_SetObjects ("SetPrivilegios")
		OBJECT SET ENTERABLE:C238(*;"obj_NoEdit@";False:C215)
		
		OBJECT SET ENABLED:C1123(*;"vr_afectoIVAIE";<>bint_AfectoExentoSegunCargo=0)
		
		  //20170507 RCH
		Case of 
			: (vl_idIE=-1)
				$y_pointerCalculaExento:=OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_CalcularExento")
				OBJECT SET ENABLED:C1123(*;"o_csIE_DiasCalculoExento";($y_pointerCalculaExento->=1))
				OBJECT SET ENABLED:C1123(*;"o_csIESoloAfectosExento";($y_pointerCalculaExento->=1))
				OBJECT SET ENABLED:C1123(*;"o_csIE_ModificaExento";($y_pointerCalculaExento->=1))
				
				OBJECT SET ENABLED:C1123(*;"o_lIE_PctExento";($y_pointerCalculaExento->=1))
				OBJECT SET ENABLED:C1123(*;"o_lIE_DiasExento";($y_pointerCalculaExento->=1))
				
			: (vl_idIE=-10)
				$y_pointerCalculaAfecto:=OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_CalcularAfecto")
				OBJECT SET ENABLED:C1123(*;"o_csIE_DiasCalculoAfecto";($y_pointerCalculaAfecto->=1))
				OBJECT SET ENABLED:C1123(*;"o_csIESoloAfectosAfecto";($y_pointerCalculaAfecto->=1))
				OBJECT SET ENABLED:C1123(*;"o_csIE_ModificaAfecto";($y_pointerCalculaAfecto->=1))
				
				OBJECT SET ENABLED:C1123(*;"o_lIE_PctAfecto";($y_pointerCalculaAfecto->=1))
				OBJECT SET ENABLED:C1123(*;"o_lIE_DiasAfecto";($y_pointerCalculaAfecto->=1))
				
		End case 
		
	: (Form event:C388=On Close Box:K2:21)
		ACTcfg_SaveItemCargosEsp 
		ACTcfg_pctsXFechaPago (1)
		
		ACTint_OpcionesGenerales ("GuardaBlob")  //20160908 RCH
		
		ACTdesc_OpcionesGenerales ("GuardaConfiguracion")  //20170506 RCH
		
		CLEAR LIST:C377(hl_listaIntereses)
		
		CANCEL:C270
		
End case 