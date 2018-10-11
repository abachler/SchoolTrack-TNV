C_TEXT:C284($t_textoPopUpTareas)
If (at_proveedores{at_proveedores}="Colegium")
	$t_textoPopUpTareas:=$t_textoPopUpTareas+"("
End if 
$t_textoPopUpTareas:=$t_textoPopUpTareas+"Ver Código;(-;"

If (at_proveedores{at_proveedores}="Colegium")
	$t_textoPopUpTareas:=$t_textoPopUpTareas+"("
End if 
$t_textoPopUpTareas:=$t_textoPopUpTareas+"Eliminar Proveedor;(-;"

$t_textoPopUpTareas:=$t_textoPopUpTareas+"Cargar Proveedor"

$l_seleccionUsuario:=Pop up menu:C542($t_textoPopUpTareas)

Case of 
	: ($l_seleccionUsuario=1)
		ACTdte_OpcionesGenerales ("EditaProveedor")
		
		
	: ($l_seleccionUsuario=3)
		ACTdte_OpcionesGenerales ("EliminaProveedor")
		
	: ($l_seleccionUsuario=5)
		C_LONGINT:C283(vlACT_RSSel)
		ACTcfdi_OpcionesGenerales ("SaveConf";->vlACT_RSSel)
		ACTdte_OpcionesGenerales ("CargaProveedor")
		
		ACTcfdi_OpcionesGenerales ("OnLoadConf";->vlACT_RSSel)
		KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->vlACT_RSSel;True:C214)
		ACTcfgbol_OpcionesDTE ("OnLoadForm")
		
End case 