//%attributes = {}
  //xALP_ACT_CB_Cats

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_CatsDT;$col;$line)
	Case of 
		: ($col=2)
			COPY ARRAY:C226(atACT_Categorias;$atACT_Categorias)
			$atACT_Categorias{0}:=atACT_Categorias{$line}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->$atACT_Categorias;"=";->$DA_Return)
			If (Size of array:C274($DA_Return)=1)
				C_LONGINT:C283($vl_exId;$vl_newId)
				$el:=Find in array:C230(atACT_CategoriasDctos;atACT_Categorias{$line})
				If ($el#-1)
					$vl_exId:=alACT_IDsCats{$line}
					$vl_newId:=alACT_CategoriasDctos{$el}
					If ($vl_exId#$vl_newId)
						$vb_continuar:=True:C214
						SET QUERY DESTINATION:C396(Into variable:K19:4;$numApdos)
						QUERY:C277([Personas:7];[Personas:7]ACT_DocumentoTributario:45=$vl_exId)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						If ($numApdos>0)
							$resp:=CD_Dlog (0;__ ("Existen ")+String:C10($numApdos)+__ (" apoderados que tienen asignado el tipo de documento ")+atACT_Categorias{0}+__ (", dicho tipo será cambiado a ")+atACT_Categorias{$line}+__ ("\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
							If ($resp=2)
								$vb_continuar:=False:C215
								atACT_Categorias{$line}:=atACT_Categorias{0}
							End if 
						End if 
						If ($vb_continuar)
							atACT_Cats{0}:=atACT_Categorias{0}
							ARRAY LONGINT:C221($DA_Return;0)
							AT_SearchArray (->atACT_Cats;"=";->$DA_Return)
							For ($i;1;Size of array:C274($DA_Return))
								atACT_Cats{$DA_Return{$i}}:=atACT_Categorias{$line}
							End for 
							
							alACT_IDCat{0}:=$vl_exId
							ARRAY LONGINT:C221($DA_Return;0)
							AT_SearchArray (->alACT_IDCat;"=";->$DA_Return)
							For ($i;1;Size of array:C274($DA_Return))
								alACT_IDCat{$DA_Return{$i}}:=$vl_newId
							End for 
							alACT_IDsCats{$line}:=$vl_newId
							
							atACT_Cats{0}:=atACT_Categorias{0}
							ARRAY LONGINT:C221($DA_Return;0)
							AT_SearchArray (->atACT_Cats;"=";->$DA_Return)
							For ($i;1;Size of array:C274($DA_Return))
								atACT_Cats{$DA_Return{$i}}:=atACT_Categorias{$line}
							End for 
							
							ARRAY LONGINT:C221(al_idsApoderados;0)
							READ ONLY:C145([Personas:7])
							QUERY:C277([Personas:7];[Personas:7]ACT_DocumentoTributario:45=$vl_exId)
							If (Records in selection:C76([Personas:7])>0)
								SELECTION TO ARRAY:C260([Personas:7]No:1;al_idsApoderados)
								C_BLOB:C604($xBlob)
								BLOB_Variables2Blob (->$xBlob;0;->al_idsApoderados;->$vl_exId;->$vl_newId)
								BM_CreateRequest ("AsignaIDDocTrib";"";"";$xBlob)
								ARRAY LONGINT:C221(al_idsApoderados;0)
							End if 
							
							ARRAY LONGINT:C221(al_idsTerceros;0)
							READ ONLY:C145([ACT_Terceros:138])
							QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]id_CatDocTrib:55=$vl_exId)
							If (Records in selection:C76([ACT_Terceros:138])>0)
								SELECTION TO ARRAY:C260([ACT_Terceros:138]Id:1;al_idsTerceros)
								C_BLOB:C604($xBlob)
								BLOB_Variables2Blob (->$xBlob;0;->al_idsTerceros;->$vl_exId;->$vl_newId)
								BM_CreateRequest ("AsignaIDDocTribTercero";"";"";$xBlob)
								ARRAY LONGINT:C221(al_idsTerceros;0)
							End if 
							
							ARRAY LONGINT:C221(al_idsBoletas;0)
							READ ONLY:C145([ACT_Boletas:181])
							QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12=$vl_exId)
							If (Records in selection:C76([ACT_Boletas:181])>0)
								SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;al_idsBoletas)
								C_BLOB:C604($xBlob)
								BLOB_Variables2Blob (->$xBlob;0;->al_idsBoletas;->$vl_exId;->$vl_newId)
								BM_CreateRequest ("AsignaIDDocTribDts";"";"";$xBlob)
								ARRAY LONGINT:C221(al_idsBoletas;0)
							End if 
							
						End if 
					End if 
				End if 
			Else 
				atACT_Categorias{$line}:=atACT_Categorias{0}
				CD_Dlog (0;__ ("Ya existe una categoría con este nombre, no es posible crear otra."))
			End if 
	End case 
End if 