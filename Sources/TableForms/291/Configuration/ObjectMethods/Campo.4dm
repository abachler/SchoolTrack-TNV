C_BOOLEAN:C305($vb_valor)
$vb_valor:=Self:C308->

  // Modificado por: SaulPonceOrtega (07-10-2018)
If (Not:C34($vb_valor))
	C_LONGINT:C283($l_cero;$l_idParaTramo)
	ACTcfgit_OpcionesGenerales ("almacenaCambioEnGlosaParaTramoDelItem";->[xxACT_Items:179]ID:1;->$l_cero)
	$l_idParaTramo:=Num:C11(ACTcfgit_OpcionesGenerales ("retornaIdParaTramoDeEsteItem";->[xxACT_Items:179]ID:1))
	ACTcfgit_OpcionesGenerales ("actualizaListaParaItemSeleccionado";->$l_idParaTramo)
End if 
ACTcfgit_OpcionesGenerales ("deshabilitaLista";->$vb_valor)

Self:C308->:=(Num:C11(ACTcfgit_OpcionesGenerales ("UtilizaTramos";->$vb_valor))=1)