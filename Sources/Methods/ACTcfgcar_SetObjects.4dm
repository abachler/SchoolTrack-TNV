//%attributes = {}
  //ACTcfgcar_SetObjects

C_TEXT:C284($vt_accion;$1)
$vt_accion:=$1

Case of 
	: ($vt_accion="SetPrivilegios")
		If (USR_GetMethodAcces ("ACTcfg_SaveItemdeCargo";0))
			OBJECT SET VISIBLE:C603(*;"bt_privItems@";False:C215)
			OBJECT SET ENTERABLE:C238(*;"@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"bt_privItems@";True:C214)
			OBJECT SET ENTERABLE:C238(*;"@";False:C215)
		End if 
		OBJECT SET ENTERABLE:C238(vtXS_PrefTitle;False:C215)
		
		If (vbACTcfg_EnItemsEsp)
			  //vr_afectoIVAIE
			  //vr_noDctoTIE
			If (vr_noDctoTIE=1)
				vr_afectoIVAIE:=0
				_O_DISABLE BUTTON:C193(vr_afectoIVAIE)
			Else 
				_O_ENABLE BUTTON:C192(vr_afectoIVAIE)
			End if 
			REDRAW WINDOW:C456
		Else 
			
			  //set dctos
			If ([xxACT_Items:179]EsDescuento:6)
				[xxACT_Items:179]Afecto_a_descuentos:4:=False:C215
				[xxACT_Items:179]Interés:19:=0
				[xxACT_Items:179]Reembolsable:18:=False:C215
				[xxACT_Items:179]AfectoDsctoIndividual:17:=False:C215
				IT_SetEnterable (False:C215;0;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Afecto_IVA:12;->[xxACT_Items:179]Interés:19;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]TasaInteresMensual:25;->[xxACT_Items:179]AfectoInteres:26;->[xxACT_Items:179]TipoInteres:29)
			Else 
				IT_SetEnterable (True:C214;0;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Afecto_IVA:12;->[xxACT_Items:179]Interés:19;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]TasaInteresMensual:25;->[xxACT_Items:179]AfectoInteres:26;->[xxACT_Items:179]TipoInteres:29)
			End if 
			
			  //set IVA y No incluir en dt
			If ([xxACT_Items:179]No_incluir_en_DocTributario:31)
				[xxACT_Items:179]Afecto_IVA:12:=False:C215
				OBJECT SET ENTERABLE:C238([xxACT_Items:179]Afecto_IVA:12;False:C215)
			Else 
				If (Not:C34([xxACT_Items:179]EsDescuento:6))
					OBJECT SET ENTERABLE:C238([xxACT_Items:179]Afecto_IVA:12;True:C214)
				End if 
			End if 
			
		End if 
End case 