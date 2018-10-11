ARRAY TEXT:C222($aSubvencionados;5)
AT_Inc (0)
$aSubvencionados{AT_Inc }:="Derecho de Matrícula"
$aSubvencionados{AT_Inc }:="Cobro Mensual"
$aSubvencionados{AT_Inc }:="Exención Sistema de Becas"
$aSubvencionados{AT_Inc }:="Aportes o Donaciones"
$aSubvencionados{AT_Inc }:="Cuotas Extraordinarias Centro de Padres"
For ($i;1;Size of array:C274($aSubvencionados))
	CREATE RECORD:C68([xxACT_ItemsCategorias:98])
	[xxACT_ItemsCategorias:98]ID:2:=ACTcfgcat_RetornaLastID 
	[xxACT_ItemsCategorias:98]Nombre:1:=$aSubvencionados{$i}
	[xxACT_ItemsCategorias:98]Posicion:3:=SQ_SeqNumber (->[xxACT_ItemsCategorias:98]Posicion:3)
	SAVE RECORD:C53([xxACT_ItemsCategorias:98])
	APPEND TO LIST:C376(hl_Categorias;[xxACT_ItemsCategorias:98]Nombre:1;[xxACT_ItemsCategorias:98]ID:2)
End for 
_O_REDRAW LIST:C382(hl_Categorias)