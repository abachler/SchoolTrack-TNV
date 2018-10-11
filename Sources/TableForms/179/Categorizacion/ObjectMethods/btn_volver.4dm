C_POINTER:C301($y_orden;$y_nombre;$y_codigo;$y_id)
C_LONGINT:C283($l_bloqueados;$l_id)
C_BOOLEAN:C305($b_hayCambios)

$y_orden:=OBJECT Get pointer:C1124(Object named:K67:5;"alACT_CatOrden")
$y_nombre:=OBJECT Get pointer:C1124(Object named:K67:5;"atACT_CatlNombre")
$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"atACT_CatCodigo")
$y_id:=OBJECT Get pointer:C1124(Object named:K67:5;"alACT_CatID")

If (USR_GetMethodAcces ("ACTcfg_SaveItemdeCargo";0))
	For ($l_indice;1;Size of array:C274($y_id->))
		$l_id:=$y_id->{$l_indice}
		KRL_FindAndLoadRecordByIndex (->[xxACT_ItemsCategorias:98]ID:2;->$l_id;True:C214)
		If (([xxACT_ItemsCategorias:98]Codigo:5#$y_codigo->{$l_indice}) | ([xxACT_ItemsCategorias:98]Nombre:1#$y_nombre->{$l_indice}))
			If (ok=1)
				$b_hayCambios:=True:C214
				If ([xxACT_ItemsCategorias:98]Codigo:5#$y_codigo->{$l_indice})
					[xxACT_ItemsCategorias:98]Codigo:5:=$y_codigo->{$l_indice}
					LOG_RegisterEvt ("Cambio en código de categorías de ítems de cargo. Categoría "+[xxACT_ItemsCategorias:98]Nombre:1+", id: "+String:C10([xxACT_ItemsCategorias:98]ID:2)+", cambió de "+Old:C35([xxACT_ItemsCategorias:98]Codigo:5)+" a "+[xxACT_ItemsCategorias:98]Codigo:5+".")
				End if 
				If ([xxACT_ItemsCategorias:98]Nombre:1#$y_nombre->{$l_indice})
					[xxACT_ItemsCategorias:98]Nombre:1:=$y_nombre->{$l_indice}
					LOG_RegisterEvt ("Cambio en nombre de categorías de ítems de cargo. Categoría "+[xxACT_ItemsCategorias:98]Nombre:1+", id: "+String:C10([xxACT_ItemsCategorias:98]ID:2)+", cambió de "+Old:C35([xxACT_ItemsCategorias:98]Nombre:1)+" a "+[xxACT_ItemsCategorias:98]Nombre:1+".")
				End if 
				SAVE RECORD:C53([xxACT_ItemsCategorias:98])
			Else 
				$l_bloqueados:=$l_bloqueados+1
			End if 
			KRL_UnloadReadOnly (->[xxACT_ItemsCategorias:98])
		End if 
	End for 
End if 

If ($l_bloqueados>0)
	CD_Dlog (0;"Algunos registros estaban en uso. No fue posible actualizar todos los códigos")
End if 
If ($b_hayCambios)
	ACTic_CargaListas 
End if 
FORM GOTO PAGE:C247(1)