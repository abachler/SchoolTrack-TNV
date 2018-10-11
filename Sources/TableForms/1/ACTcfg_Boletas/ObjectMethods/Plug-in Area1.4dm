C_LONGINT:C283($recs)

Case of 
	: (alProEvt=1)
		$Col:=AL_GetColumn (Self:C308->)
		$row:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($row>0);->bDelCat)
		If ($row>0)
			Case of 
				: ($col=1)
					For ($i;1;Size of array:C274(apACT_PorDefecto))
						apACT_PorDefecto{$i}:=apACT_PorDefecto{$i}*0
						abACT_PorDefecto{$i}:=False:C215
					End for 
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_PorDefecto{$row})
					abACT_PorDefecto{$row}:=True:C214
					
					LOG_RegisterEvt ("Cambio en configuración de Documentos Tributarios: Opción de categoría por defecto fue cambiada a: "+String:C10(abACT_PorDefecto{$row})+", para la categoría: "+atACT_Categorias{$row}+".")
				: ($col=3)
					If (abACT_ReqDatos{$row}=True:C214)
						abACT_ReqDatos{$row}:=False:C215
						GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ReqDatos{$row})
					Else 
						abACT_ReqDatos{$row}:=True:C214
						GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ReqDatos{$row})
					End if 
					  //20130210 RCH Req Aleman Pto Montt
				: ($col=4)
					If (abACT_EmiteAfectoExento{$row}=True:C214)
						abACT_EmiteAfectoExento{$row}:=False:C215
						GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_EmiteAfectoExento{$row})
					Else 
						abACT_EmiteAfectoExento{$row}:=True:C214
						GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_EmiteAfectoExento{$row})
					End if 
					LOG_RegisterEvt ("Cambio en configuración de Documentos Tributarios: Opción de emitir montos afectos y exentos en un mismo documento fue cambiada a: "+String:C10(abACT_EmiteAfectoExento{$row})+", para la categoría: "+atACT_Categorias{$row}+".")
			End case 
			AL_UpdateArrays (Self:C308->;-1)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$Recs)
			QUERY:C277([Personas:7];[Personas:7]ACT_DocumentoTributario:45=alACT_IDsCats{$row})
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$totalRecs:=Records in table:C83([Personas:7])
			If ($totalRecs>0)
				$pct:=($recs/$totalRecs)*100
			Else 
				$pct:=0
			End if 
			$msg:=__ ("Categoría utilizada por el ˆ0 de los Apoderados.")
			vtACT_EstadisticaCat:=Replace string:C233($msg;"ˆ0";String:C10($pct;"##0,##%"))
		Else 
			vtACT_EstadisticaCat:=__ ("Ninguna categoría seleccionada.")
		End if 
End case 