C_BLOB:C604($blob)
$result:=Pasteboard data size:C400("SAOB")
If ($result>0)
	GET PASTEBOARD DATA:C401("SAOB";$blob)
	CLEAR LIST:C377(hl_Observaciones)
	hl_Observaciones:=BLOB to list:C557($blob)
Else 
	$result:=Pasteboard data size:C400("TEXT")
	If ($result>0)
		$text:=Get text from pasteboard:C524
		$lines:=ST_countlines ($text)
		ARRAY TEXT:C222($aCategoria;$lines)
		ARRAY TEXT:C222($aObservacion;$lines)
		$lastCategoria:=""
		HL_ClearList (hl_Observaciones)
		hl_Observaciones:=New list:C375
		
		For ($i;1;$lines)
			$lineText:=ST_GetLine ($text;$i)
			Case of 
				: (ST_CountWords ($lineText;1;"\t")=2)
					$Categoria:=ST_GetWord ($lineText;1;"\t")
					$Observacion:=ST_GetWord ($lineText;2;"\t")
				: (ST_CountWords ($lineText;1;"\t")=1)
					$categoría:=""
					$Observacion:=$lineText
			End case 
			  // verifico si existe la categoría, si no existe se crea
			If ($observación#"")
				If ($Categoria#"")
					$posCategoria:=HL_FindElement (hl_Observaciones;$Categoria)
					If ($posCategoria=-1)
						$nextCategoriaID:=0
						For ($j;1;Count list items:C380(hl_observaciones))
							GET LIST ITEM:C378(hl_observaciones;$j;$ref;$itemtext)
							If ($ref<$nextCategoriaID)
								$nextCategoriaID:=$ref
							End if 
						End for 
						$nextCategoriaID:=$nextCategoriaID-1
						APPEND TO LIST:C376(hl_observaciones;$Categoria;$nextCategoriaID)
						$refCategoria:=$nextCategoriaID
						$sublist:=0
					Else 
						GET LIST ITEM:C378(hl_observaciones;$posCategoria;$refCategoria;$itemText;$sublist)
					End if 
					HL_ExpandAll (hl_observaciones)
					$nextRefObservación:=HL_GetNextItemRefNumber (hl_observaciones)
					If ($sublist=0)
						$subList:=New list:C375
						APPEND TO LIST:C376($sublist;$Observacion;$nextRefObservación)
						SET LIST ITEM:C385(hl_observaciones;$refCategoria;$Categoria;$refCategoria;$sublist;True:C214)
					Else 
						APPEND TO LIST:C376($sublist;$Observacion;$nextRefObservación)
						SET LIST ITEM:C385(hl_observaciones;$refCategoria;$Categoria;$refCategoria;$sublist;True:C214)
					End if 
				Else 
					HL_ExpandAll (hl_observaciones)
					$nextRefObservación:=HL_GetNextItemRefNumber (hl_observaciones)
					APPEND TO LIST:C376(hl_observaciones;$Observacion;$nextRefObservación)
				End if 
			End if 
		End for 
	Else 
		CD_Dlog (0;__ ("No hay ninguna configuración de observaciones disponible para pegar."))
	End if 
	
	HL_ExpandAll (hl_observaciones)
	For ($i;1;Count list items:C380(hl_observaciones))
		GET LIST ITEM:C378(hl_observaciones;$i;$itemRef;$itemText)
		If ($itemRef<0)
			SET LIST ITEM PROPERTIES:C386(hl_observaciones;$itemRef;True:C214;1;0)
		Else 
			SET LIST ITEM PROPERTIES:C386(hl_observaciones;$itemRef;True:C214;0;0)
		End if 
	End for 
	SET LIST PROPERTIES:C387(hl_observaciones;2;0;16;1)
	_O_REDRAW LIST:C382(hl_observaciones)
End if 



