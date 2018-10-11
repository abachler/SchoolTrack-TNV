If (Self:C308->>0)
	[xxACT_Items:179]Moneda:10:=Self:C308->{Self:C308->}
	If ([xxACT_Items:179]Moneda:10#Old:C35([xxACT_Items:179]Moneda:10))
		
		  // Modificado por: Saúl Ponce (09-12-2016)
		  // Para determinar qué hacer con la info contable que ya exista configurada al cambiar de moneda el item
		  // El usuario puede seleccionar conservar la info de la moneda del item o de la moneda del país.
		
		If (BLOB size:C605([xxACT_Items:179]xCentro_Costo:41)>0) | (BLOB size:C605([xxACT_Items:179]ContaMonedaPagoPais:50)>0)
			
			C_LONGINT:C283($w)
			C_TEXT:C284($vt_msj)
			C_POINTER:C301($vy_campoBlob)
			C_BOOLEAN:C305($vb_todosIguales)
			C_LONGINT:C283($vl_total;$vl_resp)
			
			ARRAY BOOLEAN:C223(abACT_CCXN_UsarConfItemT1;0)
			ARRAY TEXT:C222(atACT_CCXN_NivelT1;0)
			ARRAY TEXT:C222(atACT_CCXN_CentroCostoT1;0)
			ARRAY TEXT:C222(atACT_CCXN_CentroCostoContraT1;0)
			ARRAY LONGINT:C221(alACT_CCXN_NivelIDT1;0)
			ARRAY TEXT:C222(atACT_CCXN_CodAuxT1;0)
			ARRAY TEXT:C222(atACT_CCXN_CodAuxCCT1;0)
			ARRAY TEXT:C222(atACT_CCXN_CodPlanCtasT1;0)
			ARRAY TEXT:C222(atACT_CCXN_CodPlanCCtasT1;0)
			
			$vl_total:=0
			
			  // leer la info asociada a la moneda del items
			ACTitems_LeeCentrosCostoXNivel ([xxACT_Items:179]ID:1;->[xxACT_Items:179]xCentro_Costo:41)
			
			COPY ARRAY:C226(abACT_CCXN_UsarConfItem;abACT_CCXN_UsarConfItemT1)
			COPY ARRAY:C226(atACT_CCXN_Nivel;atACT_CCXN_NivelT1)
			COPY ARRAY:C226(atACT_CCXN_CentroCosto;atACT_CCXN_CentroCostoT1)
			COPY ARRAY:C226(atACT_CCXN_CentroCostoContra;atACT_CCXN_CentroCostoContraT1)
			COPY ARRAY:C226(alACT_CCXN_NivelID;alACT_CCXN_NivelIDT1)
			COPY ARRAY:C226(atACT_CCXN_CodAux;atACT_CCXN_CodAuxT1)
			COPY ARRAY:C226(atACT_CCXN_CodAuxCC;atACT_CCXN_CodAuxCCT1)
			COPY ARRAY:C226(atACT_CCXN_CodPlanCtas;atACT_CCXN_CodPlanCtasT1)
			COPY ARRAY:C226(atACT_CCXN_CodPlanCCtas;atACT_CCXN_CodPlanCCtasT1)
			
			  // leer la info asociada a la moneda del pais
			ACTitems_LeeCentrosCostoXNivel ([xxACT_Items:179]ID:1;->[xxACT_Items:179]ContaMonedaPagoPais:50)
			
			$vl_total:=($vl_total+AT_IsEqual (->abACT_CCXN_UsarConfItemT1;->abACT_CCXN_UsarConfItem))
			$vl_total:=($vl_total+AT_IsEqual (->atACT_CCXN_NivelT1;->atACT_CCXN_Nivel))
			$vl_total:=($vl_total+AT_IsEqual (->atACT_CCXN_CentroCostoT1;->atACT_CCXN_CentroCosto))
			$vl_total:=($vl_total+AT_IsEqual (->atACT_CCXN_CentroCostoContraT1;->atACT_CCXN_CentroCostoContra))
			$vl_total:=($vl_total+AT_IsEqual (->alACT_CCXN_NivelIDT1;->alACT_CCXN_NivelID))
			$vl_total:=($vl_total+AT_IsEqual (->atACT_CCXN_CodAuxT1;->atACT_CCXN_CodAux))
			$vl_total:=($vl_total+AT_IsEqual (->atACT_CCXN_CodAuxCCT1;->atACT_CCXN_CodAuxCC))
			$vl_total:=($vl_total+AT_IsEqual (->atACT_CCXN_CodPlanCtasT1;->atACT_CCXN_CodPlanCtas))
			$vl_total:=($vl_total+AT_IsEqual (->atACT_CCXN_CodPlanCCtasT1;->atACT_CCXN_CodPlanCCtas))
			
			
			If ($vl_total<9)  // si son iguales los arrays (todos) es porque los blobs son iguales
				
				$vt_msj:=__ ("Existe ingresada una configuración contable para "+ST_Qte ("moneda item")+" y otra diferente para "+ST_Qte ("moneda país")+".")
				$vt_msj:=$vt_msj+("\r"*2)+__ ("¿Cuál desea conservar como configuración contable?")
				$vl_resp:=CD_Dlog (2;$vt_msj;"";__ ("Eliminar Todo");__ ("Moneda País");__ ("Moneda Item"))
				
				LOG_RegisterEvt ("Cambio de moneda para el item ID "+String:C10([xxACT_Items:179]ID:1)+". Cambió de "+Old:C35([xxACT_Items:179]Moneda:10)+" a "+[xxACT_Items:179]Moneda:10+".")
				
				If ($vl_resp=3)  // moneda item
					SET BLOB SIZE:C606([xxACT_Items:179]ContaMonedaPagoPais:50;0)
					LOG_RegisterEvt ("El item "+String:C10([xxACT_Items:179]ID:1)+" conservó la "+ST_Qte ("Configuración de Contabilidad")+" de la pestaña "+ST_Qte ("Moneda Item")+".")
				Else 
					If ($vl_resp=2)  // moneda pais
						SET BLOB SIZE:C606([xxACT_Items:179]xCentro_Costo:41;0)
						[xxACT_Items:179]xCentro_Costo:41:=[xxACT_Items:179]ContaMonedaPagoPais:50
						LOG_RegisterEvt ("El item "+String:C10([xxACT_Items:179]ID:1)+" conservó la "+ST_Qte ("Configuración de Contabilidad")+" de la pestaña "+ST_Qte ("Moneda País")+".")
					Else 
						If ($vl_resp=1)  // eliminar todo
							SET BLOB SIZE:C606([xxACT_Items:179]xCentro_Costo:41;0)
							SET BLOB SIZE:C606([xxACT_Items:179]ContaMonedaPagoPais:50;0)
							LOG_RegisterEvt (ST_Qte ("Configuración de Contabilidad")+" eliminada completamente para el item ID "+String:C10([xxACT_Items:179]ID:1)+".")
						End if 
					End if 
				End if 
				
				READ WRITE:C146([xxACT_Items:179])
				SAVE RECORD:C53([xxACT_Items:179])
				
			End if 
			
		End if 
		
		[xxACT_Items:179]Monto:7:=0
	End if 
	ACTcfg_HabilitaOpcionesItem 
	REDRAW WINDOW:C456
	ACTcfgit_OpcionesGenerales ("ValidaCambioMontoOMoneda")
End if 