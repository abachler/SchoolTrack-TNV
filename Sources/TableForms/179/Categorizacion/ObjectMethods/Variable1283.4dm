C_LONGINT:C283($recs)
SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Nombre:1="Nueva Categoría@")
SET QUERY DESTINATION:C396(Into current selection:K19:1)
CREATE RECORD:C68([xxACT_ItemsCategorias:98])
[xxACT_ItemsCategorias:98]ID:2:=ACTcfgcat_RetornaLastID 
[xxACT_ItemsCategorias:98]Nombre:1:="Nueva Categoría"
If ($recs>0)
	[xxACT_ItemsCategorias:98]Nombre:1:=[xxACT_ItemsCategorias:98]Nombre:1+" "+String:C10($recs)
End if 
[xxACT_ItemsCategorias:98]Posicion:3:=SQ_SeqNumber (->[xxACT_ItemsCategorias:98]Posicion:3)
SAVE RECORD:C53([xxACT_ItemsCategorias:98])
APPEND TO LIST:C376(hl_Categorias;[xxACT_ItemsCategorias:98]Nombre:1;[xxACT_ItemsCategorias:98]ID:2)
_O_REDRAW LIST:C382(hl_Categorias)
ACTcfg_HabilitaBtnsCategoriasIt 