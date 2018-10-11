  //mostrar lissta de items y asociar a registro

If (lb_desctoIndividual<=Size of array:C274(atACTcfg_Items))
	If (alACTcfg_Ids{lb_desctoIndividual}>0)
		ARRAY TEXT:C222(atACT_itemsGlosa;0)
		ARRAY LONGINT:C221(alACT_itemsIds;0)
		
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]VentaRapida:3=False:C215;*)  //no venta rápida
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]EsRelativo:5=False:C215;*)  //no relativos
		ACTqry_Items ("NoEspeciales")
		
		SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_itemsGlosa;[xxACT_Items:179]ID:1;alACT_itemsIds)
		
		ARRAY POINTER:C280(<>aChoicePtrs;0)
		ARRAY POINTER:C280(<>aChoicePtrs;2)
		<>aChoicePtrs{1}:=->atACT_itemsGlosa
		<>aChoicePtrs{2}:=->alACT_itemsIds
		TBL_ShowChoiceList (0;"Seleccione el Ítem de Cargo";0)
		If (ok=1)
			alACTcfg_Items{lb_desctoIndividual}:=alACT_itemsIds{choiceidx}
			atACTcfg_Items{lb_desctoIndividual}:=atACT_itemsGlosa{choiceidx}
		End if 
	Else 
		BEEP:C151
	End if 
End if 