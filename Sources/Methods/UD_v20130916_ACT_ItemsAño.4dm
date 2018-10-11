//%attributes = {}
  //UD_v20130916_ACT_ItemsAño

If (ACT_AccountTrackInicializado )
	
	ARRAY LONGINT:C221($alACT_idsItems;0)
	ARRAY LONGINT:C221($alACT_añosCargos;0)
	ARRAY TEXT:C222($atACT_años;0)
	C_LONGINT:C283($l_indice;$l_indiceAños;$l_proc)
	
	READ ONLY:C145([xxACT_Items:179])
	READ ONLY:C145([ACT_Cargos:173])
	
	STR_ReadGlobals 
	
	$l_proc:=IT_UThermometer (1;0;"Asignando período a ítems de cargo...")
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1>0)
	
	SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$alACT_idsItems)
	
	For ($l_indice;1;Size of array:C274($alACT_idsItems))
		
		ARRAY LONGINT:C221($alACT_añosCargos;0)
		ARRAY TEXT:C222($atACT_años;0)
		
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$alACT_idsItems{$l_indice})
		DISTINCT VALUES:C339([ACT_Cargos:173]Año:14;$alACT_añosCargos)
		For ($l_indiceAños;1;Size of array:C274($alACT_añosCargos))
			If (<>gCountryCode="mx")
				APPEND TO ARRAY:C911($atACT_años;String:C10($alACT_añosCargos{$l_indiceAños})+"-"+String:C10($alACT_añosCargos{$l_indiceAños}+1))
			Else 
				APPEND TO ARRAY:C911($atACT_años;String:C10($alACT_añosCargos{$l_indiceAños}))
			End if 
		End for 
		If (Size of array:C274($alACT_añosCargos)=0)
			APPEND TO ARRAY:C911($alACT_añosCargos;<>gYear)
			APPEND TO ARRAY:C911($atACT_años;<>gNombreAgnoEscolar)
		End if 
		SORT ARRAY:C229($alACT_añosCargos;$atACT_años;<)
		
		If (Size of array:C274($alACT_añosCargos)>0)
			READ WRITE:C146([xxACT_Items:179])
			KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$alACT_idsItems{$l_indice};True:C214)
			If (ok=1)
				[xxACT_Items:179]Periodo:42:=$atACT_años{1}
				SAVE RECORD:C53([xxACT_Items:179])
			End if 
			KRL_UnloadReadOnly (->[xxACT_Items:179])
		End if 
		
	End for 
	
	IT_UThermometer (-2;$l_proc)
End if 