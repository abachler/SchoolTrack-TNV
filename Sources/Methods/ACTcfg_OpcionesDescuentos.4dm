//%attributes = {}
  //ACTcfg_OpcionesDescuentos
C_TEXT:C284($t_accion;$1;$0;$t_retorno)
C_POINTER:C301(${2})
C_POINTER:C301($y_pointer)

$t_accion:=$1
If (Count parameters:C259>=2)
	$y_pointer:=$2
End if 

Case of 
		
	: ($t_accion="DeclaraArreglosCalc")
		ARRAY LONGINT:C221(alACT_DIId;0)
		ARRAY LONGINT:C221(alACT_DIIdItem;0)
		ARRAY REAL:C219(arACT_DIMonto;0)
		ARRAY REAL:C219(arACT_PctDcto;0)
		ARRAY BOOLEAN:C223(abACT_SobreTotal;0)
		
	: ($t_accion="InicializaArreglosCalc")
		AT_Initialize (->alACT_DIId;->alACT_DIIdItem;->arACT_DIMonto;->arACT_PctDcto;->abACT_SobreTotal)
		
	: ($t_accion="DeclaraArreglos")
		ARRAY LONGINT:C221(alACTcfg_Ids;0)
		ARRAY TEXT:C222(atACTcfg_Nombres;0)
		ARRAY REAL:C219(arACTcfg_PctMax;0)
		ARRAY TEXT:C222(atACTcfg_Items;0)
		ARRAY LONGINT:C221(alACTcfg_Items;0)
		ARRAY BOOLEAN:C223(abACTcfg_aplicaATotal;0)
		
	: ($t_accion="CargaConfDctoMaximo")
		C_LONGINT:C283(lACTcfgdctos_maximoDescuento)
		C_LONGINT:C283(lACTcfgdctos_maximoDescuentoOrg)
		lACTcfgdctos_maximoDescuento:=Num:C11(PREF_fGet (0;"ACT_DescuentoMaximo";String:C10(lACTcfgdctos_maximoDescuento)))
		
	: ($t_accion="CargaConf")
		ACTcfg_OpcionesDescuentos ("DeclaraArreglos")
		
		READ ONLY:C145([ACT_CFG_DctosIndividuales:229])
		
		ALL RECORDS:C47([ACT_CFG_DctosIndividuales:229])
		ORDER BY:C49([ACT_CFG_DctosIndividuales:229];[ACT_CFG_DctosIndividuales:229]Orden:8;>)
		
		SET FIELD RELATION:C919([ACT_CFG_DctosIndividuales:229]Id_Item_de_Cargo:7;Automatic:K51:4;Manual:K51:3)
		SELECTION TO ARRAY:C260([ACT_CFG_DctosIndividuales:229]ID:1;alACTcfg_Ids;[ACT_CFG_DctosIndividuales:229]Nombre:5;atACTcfg_Nombres;[ACT_CFG_DctosIndividuales:229]Porcentaje_Maximo:6;arACTcfg_PctMax;[ACT_CFG_DctosIndividuales:229]Id_Item_de_Cargo:7;alACTcfg_Items;[xxACT_Items:179]Glosa:2;atACTcfg_Items;[ACT_CFG_DctosIndividuales:229]Aplica_a_total:9;abACTcfg_aplicaATotal)
		SET FIELD RELATION:C919([ACT_CFG_DctosIndividuales:229]Id_Item_de_Cargo:7;Structure configuration:K51:2;Structure configuration:K51:2)
		
		ACTcfg_OpcionesDescuentos ("CargaConfDctoMaximo")
		
	: ($t_accion="InsertaLinea")
		C_LONGINT:C283($l_orden)
		$l_orden:=Size of array:C274(alACTcfg_Ids)+1
		ACTcfg_OpcionesDescuentos ("GuardaConf")  //20170129 RCH
		$l_id:=Num:C11(ACT_DctosIndividuales_Cuentas ("Insertar";->$l_orden))
		If ($l_id>0)
			ACTcfg_OpcionesDescuentos ("CargaConf")
			$l_orden:=Find in array:C230(alACTcfg_Ids;$l_id)
			EDIT ITEM:C870(atACTcfg_Nombres;$l_orden)
		Else 
			CD_Dlog (0;"Error al agregar elemento.")
		End if 
		
	: ($t_accion="ValidaDatos")
		C_LONGINT:C283($l_recs)
		ARRAY LONGINT:C221(DA_Return;0)
		alACTcfg_Items{0}:=0
		$l_recs:=AT_SearchArray (->alACTcfg_Items;"=";->DA_Return)
		If ($l_recs#0)
			CD_Dlog (0;"Hay líneas que no tienen asociado un ítem de cargo. Esos descuentos no serán utilizados.")
		End if 
		
		If (lACTcfgdctos_maximoDescuento<0)
			lACTcfgdctos_maximoDescuento:=0
		End if 
		
		C_LONGINT:C283($l_indice)
		For ($l_indice;1;Size of array:C274(arACTcfg_PctMax))
			If (arACTcfg_PctMax{$l_indice}>100)
				arACTcfg_PctMax{$l_indice}:=100
			End if 
			If (arACTcfg_PctMax{$l_indice}<0)
				arACTcfg_PctMax{$l_indice}:=0
			End if 
		End for 
		
		
	: ($t_accion="EliminaLinea")
		If (alACTcfg_Ids{lb_desctoIndividual}>0)
			If (lb_desctoIndividual<=Size of array:C274(alACTcfg_Ids))
				C_LONGINT:C283($l_recs)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recs)
				SET QUERY LIMIT:C395(1)
				READ ONLY:C145([ACT_DctosIndividuales_Cuentas:228])
				QUERY:C277([ACT_DctosIndividuales_Cuentas:228];[ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5=alACTcfg_Ids{lb_desctoIndividual})
				SET QUERY LIMIT:C395(0)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($l_recs=0)
					$l_ok:=Num:C11(ACT_DctosIndividuales_Cuentas ("Eliminar";->alACTcfg_Ids{lb_desctoIndividual}))
					If ($l_ok=1)
						LISTBOX DELETE ROWS:C914(*;"lb_desctoIndividual";lb_desctoIndividual;1)
					Else 
						Case of 
							: ($l_ok=0)
								CD_Dlog (0;__ ("El registro está en uso, no es posible eliminarlo."))
							: ($l_ok=-1)
								CD_Dlog (0;__ ("El descuento está siendo usado, no es posible eliminarlo."))
						End case 
					End if 
				Else 
					CD_Dlog (0;__ ("No es posible eliminar el descuento ")+ST_Qte (atACTcfg_Nombres{lb_desctoIndividual})+__ (" debido a que está siendo utilizado en las Cuentas Corrientes."))
				End if 
			Else 
				CD_Dlog (0;__ ("El descuento no puede ser eliminado."))
			End if 
		Else 
			BEEP:C151
		End if 
		
	: ($t_accion="GuardaConf")
		C_LONGINT:C283($l_indice)
		For ($l_indice;1;Size of array:C274(alACTcfg_Ids))
			KRL_FindAndLoadRecordByIndex (->[ACT_CFG_DctosIndividuales:229]ID:1;->alACTcfg_Ids{$l_indice};True:C214)
			If (([ACT_CFG_DctosIndividuales:229]Nombre:5#atACTcfg_Nombres{$l_indice}) | ([ACT_CFG_DctosIndividuales:229]Porcentaje_Maximo:6#arACTcfg_PctMax{$l_indice}) | ([ACT_CFG_DctosIndividuales:229]Id_Item_de_Cargo:7#alACTcfg_Items{$l_indice}) | ([ACT_CFG_DctosIndividuales:229]Orden:8#$l_indice) | ([ACT_CFG_DctosIndividuales:229]Aplica_a_total:9#abACTcfg_aplicaATotal{$l_indice}))
				
				  // Modificado por: Saúl Ponce (29/11/2017) Ticket Nº 192899, evita error al modificar el orden de los descuentos
				If (True:C214)
					QUERY:C277([ACT_CFG_DctosIndividuales:229];[ACT_CFG_DctosIndividuales:229]Orden:8=$l_indice)
					[ACT_CFG_DctosIndividuales:229]Orden:8:=(-100000*$l_indice)  // temporal
					SAVE RECORD:C53([ACT_CFG_DctosIndividuales:229])
					
					KRL_FindAndLoadRecordByIndex (->[ACT_CFG_DctosIndividuales:229]ID:1;->alACTcfg_Ids{$l_indice};True:C214)
					[ACT_CFG_DctosIndividuales:229]Orden:8:=(-200000*$l_indice)  // temporal
					SAVE RECORD:C53([ACT_CFG_DctosIndividuales:229])
				End if 
				
				If (ok=1)
					
					[ACT_CFG_DctosIndividuales:229]Nombre:5:=atACTcfg_Nombres{$l_indice}
					[ACT_CFG_DctosIndividuales:229]Porcentaje_Maximo:6:=arACTcfg_PctMax{$l_indice}
					[ACT_CFG_DctosIndividuales:229]Id_Item_de_Cargo:7:=alACTcfg_Items{$l_indice}
					[ACT_CFG_DctosIndividuales:229]Orden:8:=$l_indice
					[ACT_CFG_DctosIndividuales:229]Aplica_a_total:9:=abACTcfg_aplicaATotal{$l_indice}
					
					If (KRL_FieldChanges (->[ACT_CFG_DctosIndividuales:229]Nombre:5))
						LOG_RegisterEvt ("Cambio en nombre de Configuración de Descuento Individual. Cambió de: "+Old:C35([ACT_CFG_DctosIndividuales:229]Nombre:5)+" a: "+[ACT_CFG_DctosIndividuales:229]Nombre:5+".")
					End if 
					
					If (KRL_FieldChanges (->[ACT_CFG_DctosIndividuales:229]Porcentaje_Maximo:6))
						LOG_RegisterEvt ("Cambio en porcentaje máximo de descuento de Configuración de Descuento Individual. Cambió de: "+String:C10(Old:C35([ACT_CFG_DctosIndividuales:229]Porcentaje_Maximo:6))+" a: "+String:C10([ACT_CFG_DctosIndividuales:229]Porcentaje_Maximo:6)+".")
					End if 
					
					If (KRL_FieldChanges (->[ACT_CFG_DctosIndividuales:229]Id_Item_de_Cargo:7))
						LOG_RegisterEvt ("Cambio en id de ítem asociado de Configuración de Descuento Individual. Cambió de: "+String:C10(Old:C35([ACT_CFG_DctosIndividuales:229]Id_Item_de_Cargo:7))+" a: "+String:C10([ACT_CFG_DctosIndividuales:229]Id_Item_de_Cargo:7)+".")
					End if 
					
					If (KRL_FieldChanges (->[ACT_CFG_DctosIndividuales:229]Orden:8))
						LOG_RegisterEvt ("Cambio en orden de Configuración de Descuento Individual. Cambió de: "+String:C10(Old:C35([ACT_CFG_DctosIndividuales:229]Orden:8))+" a: "+String:C10([ACT_CFG_DctosIndividuales:229]Orden:8)+".")
					End if 
					
					If (KRL_FieldChanges (->[ACT_CFG_DctosIndividuales:229]Aplica_a_total:9))
						LOG_RegisterEvt ("Cambio en opción aplicar a total. Cambió de: "+String:C10(Old:C35([ACT_CFG_DctosIndividuales:229]Aplica_a_total:9))+" a: "+String:C10([ACT_CFG_DctosIndividuales:229]Aplica_a_total:9)+".")
					End if 
					
					SAVE RECORD:C53([ACT_CFG_DctosIndividuales:229])
				End if 
			End if 
			KRL_UnloadReadOnly (->[ACT_CFG_DctosIndividuales:229])
		End for 
		
		If (lACTcfgdctos_maximoDescuentoOrg#lACTcfgdctos_maximoDescuento)
			LOG_RegisterEvt ("Cambio en configuración de número máximo de descuentos. Número anterior: "+String:C10(lACTcfgdctos_maximoDescuentoOrg)+", número asignado: "+String:C10(lACTcfgdctos_maximoDescuento)+".")
		End if 
		PREF_Set (0;"ACT_DescuentoMaximo";String:C10(lACTcfgdctos_maximoDescuento))
		
		ACTcfg_OpcionesDescuentos ("DeclaraArreglos")
		
	: ($t_accion="SeleccionaDescuento")
		ACTcfg_OpcionesDescuentos ("CargaConf")
		
		ARRAY POINTER:C280(<>aChoicePtrs;0)
		ARRAY POINTER:C280(<>aChoicePtrs;2)
		C_POINTER:C301($ptr)
		<>aChoicePtrs{1}:=->atACTcfg_Nombres
		<>aChoicePtrs{2}:=->alACTcfg_Ids
		TBL_ShowChoiceList (1;"Seleccione el descuento a asignar";0)
		If (choiceIdx>0)
			$t_retorno:=String:C10(alACTcfg_Ids{choiceIdx})
		End if 
		AT_Initialize (-><>aChoicePtrs)
		
	: ($t_accion="ObtieneNombreXid")
		READ ONLY:C145([ACT_CFG_DctosIndividuales:229])
		$t_retorno:=KRL_GetTextFieldData (->[ACT_CFG_DctosIndividuales:229]ID:1;$y_pointer;->[ACT_CFG_DctosIndividuales:229]Nombre:5)
		
	: ($t_accion="creaDctoxCtaxDefecto")  // Saul Ponce (23-08-2018) Ticket Nº 214989, crear el descuento x cta durante la inicialización ACT
		C_TEXT:C284($t_log)
		ACTdcto_LeeDctosXCuenta 
		If (Records in selection:C76([ACT_CFG_DctosIndividuales:229])=1)
			$t_log:="Creación de"+ST_Qte ("Descuento por cuenta")+"(ID-1), en la configuración de"+ST_Qte ("Descuentos Individuales")
		Else 
			$t_log:="Error durante la creación de "+ST_Qte ("Descuento por cuenta")+" (ID -1), en la configuración de "+ST_Qte ("Descuentos Individuales")
		End if 
		$t_log:=$t_log+"."
		LOG_RegisterEvt ($t_log)
End case 

$0:=$t_retorno