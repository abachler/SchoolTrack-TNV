Case of 
	: (Form event:C388=On Load:K2:1)
		ACTcfgit_OpcionesGenerales ("LlenaArreglosLB")
		If ((<>gCountryCode="cl") & ([xxACT_Items:179]Moneda:10="UF@"))
			OBJECT SET FORMAT:C236([xxACT_Items:179]Monto:7;"|Despliegue_UF")
		Else 
			OBJECT SET FORMAT:C236([xxACT_Items:179]Monto:7;"|Despliegue_ACT")
		End if 
		
		OBJECT SET ENABLED:C1123(*;"cs_aplicaDescuento";[xxACT_Items:179]Utiliza_tramos:38)
		If (Not:C34([xxACT_Items:179]Utiliza_tramos:38))
			[xxACT_Items:179]Aplicar_desctos_tramos:40:=False:C215
		End if 
		
		  ////20150311 JVP codigo para el requerimiento 151665 se agrego un nuevo campo en la table xxact_items
		OBJECT SET ENABLED:C1123(*;"cs_aplicaDescuento1";[xxACT_Items:179]Aplicar_desctos_tramos:40)
		If (Not:C34([xxACT_Items:179]Utiliza_tramos:38))
			[xxACT_Items:179]Tramo_desc_sobre_desc:47:=False:C215
		End if 
		
		
		
		  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		C_LONGINT:C283($l_posItem;$l_cuantosItems;$l_idItem;$l_idParaTramo)
		C_POINTER:C301($y_control)
		$l_idItem:=[xxACT_Items:179]ID:1
		$l_cuantosItems:=Num:C11(ACTcfgit_OpcionesGenerales ("BuscaItemsADesplegar"))
		If ($l_cuantosItems>0)
			$l_idParaTramo:=Num:C11(ACTcfgit_OpcionesGenerales ("retornaIdParaTramoDeEsteItem";->[xxACT_Items:179]ID:1))
			$l_posItem:=Find in array:C230(al_IdsItems;$l_idParaTramo)
			If ($l_posItem>-1)
				at_GlosasItems:=$l_posItem
				$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramo")
				$y_control->:=at_GlosasItems{$l_posItem}
				$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramoId")
				$y_control->:=al_IdsItems{$l_posItem}
			End if 
			
		End if 
		KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItem)
		
		
		
		
		
	: (Form event:C388=On Clicked:K2:4)
		OBJECT SET ENABLED:C1123(*;"cs_aplicaDescuento";[xxACT_Items:179]Utiliza_tramos:38)
		If (Not:C34([xxACT_Items:179]Utiliza_tramos:38))
			[xxACT_Items:179]Aplicar_desctos_tramos:40:=False:C215
		End if 
		  //este objeto se vera si esta activado el descuento a cargos por tramo
		
		OBJECT SET ENABLED:C1123(*;"cs_aplicaDescuento1";[xxACT_Items:179]Aplicar_desctos_tramos:40)
		If (Not:C34([xxACT_Items:179]Utiliza_tramos:38))
			[xxACT_Items:179]Tramo_desc_sobre_desc:47:=False:C215
		End if 
		
End case 