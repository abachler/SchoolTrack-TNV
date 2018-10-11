//%attributes = {}
  //UD_v20140510_ACT_RecAut
  //este metodo se encarga de actualizar el nuevo campo que maneja los recargos automaticos
  //si el ítem de cargo está como no afecto a recargos automáticos se deja igual
  //si el ítem de cargo está como afecto a cargos automáticos, se asigna el valor 1 al campo

If (ACT_AccountTrackInicializado )
	
	C_LONGINT:C283($l_proc;$l_indice)
	ARRAY LONGINT:C221($alACT_recNumsItems;0)
	
	READ ONLY:C145([xxACT_Items:179])
	
	$l_proc:=IT_UThermometer (1;0;"Actualizando campo en ítems de cargo...")
	
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]NoAfecto_a_RecargosAut:37=False:C215)
	LONGINT ARRAY FROM SELECTION:C647([xxACT_Items:179];$alACT_recNumsItems;"")
	
	For ($l_indice;1;Size of array:C274($alACT_recNumsItems))
		READ WRITE:C146([xxACT_Items:179])
		GOTO RECORD:C242([xxACT_Items:179];$alACT_recNumsItems{$l_indice})
		[xxACT_Items:179]id_tipoRecargoAut:45:=1
		SAVE RECORD:C53([xxACT_Items:179])
		KRL_UnloadReadOnly (->[xxACT_Items:179])
	End for 
	
	IT_UThermometer (-2;$l_proc)
	
End if 
