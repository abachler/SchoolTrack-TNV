C_LONGINT:C283($recs)
C_TEXT:C284($msg)

$line:=AL_GetLine (xALP_CatsDT)
SET QUERY LIMIT:C395(1)
SET QUERY DESTINATION:C396(Into variable:K19:4;$boletas)
QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12=alACT_IDsCats{$line})
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)
If ($boletas=1)
	  //$msg:=RP_GetIdxString (21500;49)
	  //$msg:=Replace string($msg;"^0";atACT_Categorias{$line})
	CD_Dlog (0;Replace string:C233(__ ("Existen documentos tributarios emitidos del tipo ^0. La categoría no puede ser eliminada.");__ ("^0");atACT_Categorias{$line}))
Else 
	$PDefecto:=Find in array:C230(abACT_PorDefecto;True:C214)
	If ($PDefecto#-1)
		If ((abACT_PorDefecto{$line}=False:C215) | (Shift down:C543))  //al presionar shift la validación es saltada...
			QUERY:C277([Personas:7];[Personas:7]ACT_DocumentoTributario:45=alACT_IDsCats{$line})
			ARRAY LONGINT:C221(alACT_DummyDefecto;Records in selection:C76([Personas:7]))
			DummyDefecto:=alACT_IDsCats{$PDefecto}
			AT_Populate (->alACT_DummyDefecto;->DummyDefecto)
			KRL_Array2Selection (->alACT_DummyDefecto;->[Personas:7]ACT_DocumentoTributario:45)
			AT_Initialize (->alACT_DummyDefecto)
			alACT_IDCat{0}:=alACT_IDsCats{$line}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->alACT_IDCat;"=";->$DA_Return)
			If (Size of array:C274($DA_Return)>0)
				If (abACT_PorDefecto{$line}=True:C214)
					$r:=CD_Dlog (0;__ ("Está a punto de eliminar la categoría por defecto. Dado que se necesita una categoría por defecto, se seleccionará la primera de la lista.\r\r")+__ ("Algunos documentos tributarios están en esta categoría. Si la elimina, aquellos documentos quedarán sin categoría.\r\r¿Desea realmente eliminar la categoría?");__ ("");__ ("No");__ ("Si"))
				Else 
					$r:=CD_Dlog (0;__ ("Algunos documentos tributarios están en esta categoría. Si la elimina, aquellos documentos quedarán sin categoría.\r\r¿Desea realmente eliminar la categoría?");__ ("");__ ("No");__ ("Si"))
				End if 
				If ($r=2)
					If (vlACT_CatVR=alACT_IDsCats{$line})
						vlACT_CatVR:=0
						vtACT_CatVR:=__ ("Seleccionar...")
					End if 
					AL_UpdateArrays (xALP_CatsDT;0)
					AT_Delete ($line;1;->atACT_Categorias;->alACT_IDsCats;->abACT_ReqDatos;->apACT_ReqDatos;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento)
					If (Size of array:C274(apACT_PorDefecto)>=1)
						For ($t;1;Size of array:C274(atACT_Categorias))
							apACT_PorDefecto{$t}:=apACT_PorDefecto{$t}*0
							abACT_PorDefecto{$t}:=False:C215
						End for 
						GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_PorDefecto{1})
						abACT_PorDefecto{1}:=True:C214
					End if 
					AL_UpdateArrays (xALP_CatsDT;-2)
					If (Size of array:C274(alACT_IDsCats)>0)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$Recs)
						QUERY:C277([Personas:7];[Personas:7]ACT_DocumentoTributario:45=alACT_IDsCats{1})
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						$totalRecs:=Records in table:C83([Personas:7])
						If ($totalRecs>0)
							$pct:=($recs/$totalRecs)*100
						Else 
							$pct:=0
						End if 
					End if 
					$msg:=__ ("Categoría utilizada por el ˆ0 de los Apoderados.")
					vtACT_EstadisticaCat:=Replace string:C233($msg;"ˆ0";String:C10($pct;"##0,##%"))
					For ($i;1;Size of array:C274($DA_Return))
						alACT_IDCat{$DA_Return{$i}}:=0
						apACT_DocPorDefecto{$DA_Return{$i}}:=apACT_DocPorDefecto{$DA_Return{$i}}*0
						abACT_DocPorDefecto{$DA_Return{$i}}:=False:C215
						atACT_Cats{$DA_Return{$i}}:=__ ("Seleccionar...")
					End for 
					If (vlACT_CatVR=alACT_IDsCats{$line})
						vlACT_CatVR:=0
						vtACT_CatVR:=__ ("Seleccionar...")
					End if 
					xALPSet_ACT_TiposdeDoc 
					ACTcfg_SetDocRowsColor 
					If (Size of array:C274(atACT_Categorias)=0)
						_O_DISABLE BUTTON:C193(Self:C308->)
					End if 
				End if 
			Else 
				If ($msg#"")
					$r:=CD_Dlog (0;$msg;__ ("");__ ("No");__ ("Si"))
					If ($r=2)
						If (vlACT_CatVR=alACT_IDsCats{$line})
							vlACT_CatVR:=0
							vtACT_CatVR:=__ ("Seleccionar...")
						End if 
						AL_UpdateArrays (xALP_CatsDT;0)
						AT_Delete ($line;1;->atACT_Categorias;->alACT_IDsCats;->abACT_ReqDatos;->apACT_ReqDatos;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento)
						If (Size of array:C274(apACT_PorDefecto)>=1)
							For ($t;1;Size of array:C274(atACT_Categorias))
								apACT_PorDefecto{$t}:=apACT_PorDefecto{$t}*0
								abACT_PorDefecto{$t}:=False:C215
							End for 
							GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_PorDefecto{1})
							abACT_PorDefecto{1}:=True:C214
						End if 
						AL_UpdateArrays (xALP_CatsDT;-2)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$Recs)
						QUERY:C277([Personas:7];[Personas:7]ACT_DocumentoTributario:45=alACT_IDsCats{1})
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						$totalRecs:=Records in table:C83([Personas:7])
						If ($totalRecs>0)
							$pct:=($recs/$totalRecs)*100
						Else 
							$pct:=0
						End if 
						$msg:=__ ("Categoría utilizada por el ˆ0 de los Apoderados.")
						vtACT_EstadisticaCat:=Replace string:C233($msg;"ˆ0";String:C10($pct;"##0,##%"))
						xALPSet_ACT_TiposdeDoc 
						If (Size of array:C274(atACT_Categorias)=0)
							_O_DISABLE BUTTON:C193(Self:C308->)
						End if 
					End if 
				Else 
					If (vlACT_CatVR=alACT_IDsCats{$line})
						vlACT_CatVR:=0
						vtACT_CatVR:=__ ("Seleccionar...")
					End if 
					AL_UpdateArrays (xALP_CatsDT;0)
					AT_Delete ($line;1;->atACT_Categorias;->alACT_IDsCats;->abACT_ReqDatos;->apACT_ReqDatos;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento)
					AL_UpdateArrays (xALP_CatsDT;-2)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$Recs)
					QUERY:C277([Personas:7];[Personas:7]ACT_DocumentoTributario:45=alACT_IDsCats{1})
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					$totalRecs:=Records in table:C83([Personas:7])
					If ($totalRecs>0)
						$pct:=($recs/$totalRecs)*100
					Else 
						$pct:=0
					End if 
					$msg:=__ ("Categoría utilizada por el ˆ0 de los Apoderados.")
					vtACT_EstadisticaCat:=Replace string:C233($msg;"ˆ0";String:C10($pct;"##0,##%"))
					xALPSet_ACT_TiposdeDoc 
					ACTcfg_SetDocRowsColor 
					If (Size of array:C274(atACT_Categorias)=0)
						_O_DISABLE BUTTON:C193(Self:C308->)
					End if 
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("No es posible eliminar la categoría de Documento Tributario por defecto."))
		End if 
	Else 
		CD_Dlog (0;__ ("Antes de eliminar una categoría de Documento Tributario debe marcar otra categoría por derfecto."))
	End if 
End if 