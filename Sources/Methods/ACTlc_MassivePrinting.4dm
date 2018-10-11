//%attributes = {}
  //ACTlc_MassivePrinting

C_BOOLEAN:C305($allow)
If (Size of array:C274(alACT_CatIDBol)>0)
	$allow:=ACTcfg_SearchCatDocs (alACT_CatIDBol{1})  //en principio siempre debe ser una categoría
Else 
	$allow:=False:C215
End if 
If ($allow)
	For ($i;1;Size of array:C274(aACT_Ptrs))
		If (abACT_PrintBol{$i})
			CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_de_Pago:176];aACT_Ptrs{$i}->)
			CREATE SET:C116([ACT_Documentos_de_Pago:176];"lcs2Print")
			ARRAY TEXT:C222(atACTlc_Folio;Records in set:C195("lcs2Print"))
			SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176]NoSerie:12;atACTlc_Folio)  //para contar el no de documentto.
			ACTlc_PrintLetras ("lcs2Print";alACT_DocIDBol{$i})
			CLEAR SET:C117("lcs2Print")
			AT_Initialize (->atACTlc_Folio)
		End if 
	End for 
Else 
	CD_Dlog (0;__ ("La configuración de los documentos no está completa. No es posible imprimir en este momento."))
End if 