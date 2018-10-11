//%attributes = {}
  //xALPSet_ACT_TiposdeDoc

AL_RemoveArrays (ALP_TiposdeDoc;1;14)

C_LONGINT:C283($Error)
C_LONGINT:C283($indexMultiRol;$indexImpresoras;$indexmodelos;vlACT_indexRazonSocial;vlACT_indexSincronizar)

vlACT_indexRazonSocial:=0
vlACT_indexSincronizar:=0
  //specify arrays to display
AT_Inc (0)
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"apACT_DocPorDefecto";"";15;"1")
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"atACT_Cats";__ ("Categoría");67;"")
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"atACT_NombreDoc";__ ("Documento");130;"")
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"atACT_Tipo";__ ("Tipo");74;"")
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"apACT_Afecta";__ ("Afecta a\rIVA");41;"";0;0)
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"alACT_Proxima";__ ("Próximo");47;"#########")
If (cb_UtilizaMultiNum=1)
	$indexMultiRol:=AT_Inc 
	Case of 
		: ((btnUsuario=1))
			$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;$indexMultiRol;"atACT_idNumeracion";__ ("Usuario");60;"")
		Else 
			$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;$indexMultiRol;"atACT_idNumeracion";__ ("RBD");60;"")
	End case 
End if 
$indexImpresoras:=AT_Inc 
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;$indexImpresoras;"atACT_Impresora";__ ("Impresora");134;"")
$indexmodelos:=AT_Inc 
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;$indexmodelos;"atACT_ModeloDoc";__ ("Modelo");128;"")
If (cs_MultiRazones=1)
	vlACT_indexRazonSocial:=AT_Inc 
	$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;vlACT_indexRazonSocial;"atACT_RazonSocial";__ ("Razón Social\rAsociada");128;"")
End if 
If (cb_Sincroniza=1)
	vlACT_indexSincronizar:=AT_Inc 
	$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;vlACT_indexSincronizar;"atACT_DTSinc";__ ("Categoría y/o Numeración\rAsociada");150;"")
End if 

$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"alACT_IDDT";"IDDT";77;"")
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"alACT_IDCat";"IdCat";77;"")
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"abACT_Afecta";"Afecta";77;"")
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"abACT_DocPorDefecto";"DocPorDefecto";77;"")
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"abACT_DocComplete";"DocCompleto";77;"")
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"aiACT_Tipo";"tipo";77;"")
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"alACT_RazonSocial";"idRazonSocial";77;"")
$err:=ALP_DefaultColSettings (ALP_TiposdeDoc;AT_Inc ;"alACT_IdDTSinc";"idCategoriaSincronizada";77;"")

AL_SetEnterable (ALP_TiposdeDoc;2;2;atACT_Categorias)
AL_SetEnterable (ALP_TiposdeDoc;3;1)
AL_SetEnterable (ALP_TiposdeDoc;4;2;atACT_Tipos)
AL_SetFormat (ALP_TiposdeDoc;5;"1";0;0;0;0)
AL_SetEnterable (ALP_TiposdeDoc;6;1)
If ($indexMultiRol#0)
	AL_SetEnterable (ALP_TiposdeDoc;$indexMultiRol;2;atACT_RBDList)
End if 
AL_SetEnterable (ALP_TiposdeDoc;$indexImpresoras;2;atACT_Impresoras)
AL_SetEnterable (ALP_TiposdeDoc;$indexmodelos;2;atACT_ModelosDoc)
If (vlACT_indexRazonSocial#0)
	AL_SetColLock (ALP_TiposdeDoc;6)
	AL_SetEnterable (ALP_TiposdeDoc;vlACT_indexRazonSocial;2;atACTcfg_Razones)
End if 
If (vlACT_indexSincronizar#0)
	AL_SetColLock (ALP_TiposdeDoc;6)
	AL_SetEnterable (ALP_TiposdeDoc;vlACT_indexSincronizar;2;atACT_NombreDoc2)
End if 

  //general options
ALP_SetDefaultAppareance (ALP_TiposdeDoc;9;1;6;2;6)
AL_SetColOpts (ALP_TiposdeDoc;1;1;1;8;0)
AL_SetRowOpts (ALP_TiposdeDoc;0;1;0;0;1;0)
AL_SetCellOpts (ALP_TiposdeDoc;0;1;1)
AL_SetMainCalls (ALP_TiposdeDoc;"";"")
AL_SetCallbacks (ALP_TiposdeDoc;"xALP_CBIN_ACT_Boletas";"xALP_CB_ACT_Boletas")
AL_SetScroll (ALP_TiposdeDoc;0;0)
AL_SetEntryOpts (ALP_TiposdeDoc;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (ALP_TiposdeDoc;0;30;0)

  //dragging options

AL_SetDrgSrc (ALP_TiposdeDoc;1;"";"";"")
AL_SetDrgSrc (ALP_TiposdeDoc;2;"";"";"")
AL_SetDrgSrc (ALP_TiposdeDoc;3;"";"";"")
AL_SetDrgDst (ALP_TiposdeDoc;1;"";"";"")
AL_SetDrgDst (ALP_TiposdeDoc;1;"";"";"")
AL_SetDrgDst (ALP_TiposdeDoc;1;"";"";"")

