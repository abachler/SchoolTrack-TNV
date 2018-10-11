//%attributes = {}
  //ACTbol_SeleccionItemsNC
C_REAL:C285($vr_monto)

vt_accion:=$1
If (Count parameters:C259=2)
	$vy_pointer1:=$2
End if 
Case of 
		
	: (vt_accion="GuardaItemMontoNotaCredito")
		$vr_monto:=$vy_pointer1->
		APPEND TO ARRAY:C911(alACT_idCargoSel;[ACT_Cargos:173]ID:1)
		APPEND TO ARRAY:C911(arACT_montoCargoSel;$vr_monto)
		
		If ([ACT_Cargos:173]TasaIVA:21>0)
			vr_montoItemIncluirExento:=vr_montoItemIncluirExento+$vr_monto
		Else 
			vr_montoItemIncluirAfecto:=vr_montoItemIncluirAfecto+$vr_monto
		End if 
	: (vt_accion="DeclaraArreglos")
		
		ARRAY LONGINT:C221(alACT_idCargoSel;0)
		ARRAY REAL:C219(arACT_montoCargoSel;0)
		
		ARRAY TEXT:C222(atACT_Item;0)
		ARRAY TEXT:C222(atACT_NombreCuenta;0)
		ARRAY REAL:C219(arACT_MontoItems;0)
		ARRAY BOOLEAN:C223(abACT_Afecto;0)
		ARRAY BOOLEAN:C223(abACT_ItemsSeleccionado;0)
		ARRAY LONGINT:C221(al_RecNumCargosSel;0)
		ARRAY REAL:C219(ar_MontoIvaCargoSel;0)
		
	: (vt_accion="CargaArreglosNotaDeCredito")
		
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([xxACT_Items:179])
		
		For ($l_indice;1;Size of array:C274(alACT_idCargoSel))
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=alACT_idCargoSel{$l_indice})
			KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
			KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16)
			If ([xxACT_Items:179]Glosa_de_Impresión:20#"")
				APPEND TO ARRAY:C911(atACT_Item;[xxACT_Items:179]Glosa_de_Impresión:20)
			Else 
				APPEND TO ARRAY:C911(atACT_Item;[ACT_Cargos:173]Glosa:12)
			End if 
			APPEND TO ARRAY:C911(atACT_NombreCuenta;[Alumnos:2]apellidos_y_nombres:40)
			APPEND TO ARRAY:C911(abACT_Afecto;Choose:C955([ACT_Cargos:173]Monto_IVA:20>0;True:C214;False:C215))
			APPEND TO ARRAY:C911(abACT_ItemsSeleccionado;True:C214)
			APPEND TO ARRAY:C911(al_RecNumCargosSel;Record number:C243([ACT_Cargos:173]))
			
			
			If ([ACT_Cargos:173]Monto_IVA:20>0)
				$vt_monedaCargo:=ST_GetWord (ACT_DivisaPais ;1;";")
				$vr_afecto:=Round:C94(arACT_montoCargoSel{$l_indice}/<>vrACT_FactorIVA;<>vlACT_Decimales)
				APPEND TO ARRAY:C911(ar_MontoIvaCargoSel;arACT_montoCargoSel{$l_indice}-$vr_afecto)
				APPEND TO ARRAY:C911(arACT_MontoItems;arACT_montoCargoSel{$l_indice})
			Else 
				APPEND TO ARRAY:C911(ar_MontoIvaCargoSel;0)
				APPEND TO ARRAY:C911(arACT_MontoItems;arACT_montoCargoSel{$l_indice})
			End if 
			
		End for 
		
	: (vt_accion="AgregarCargosSeleccionados")
		ARRAY LONGINT:C221(al_recNumsCargos;0)
		For ($l_indice;1;Size of array:C274(abACT_ItemsSeleccionado))
			If (abACT_ItemsSeleccionado{$l_indice})
				APPEND TO ARRAY:C911(al_recNumsCargos;al_RecNumCargosSel{$l_indice})
			End if 
		End for 
		
End case 