//%attributes = {}
  //ACTcfgcat_RetornaLastID

C_LONGINT:C283($vl_idItemCategoria;$vl_existe;$0)

$vl_idItemCategoria:=SQ_SeqNumber (->[xxACT_ItemsCategorias:98]ID:2)-MAXLONG:K35:2
SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_existe)
QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$vl_idItemCategoria)
While ($vl_existe#0)
	$vl_idItemCategoria:=SQ_SeqNumber (->[xxACT_ItemsCategorias:98]ID:2)-MAXLONG:K35:2
	QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$vl_idItemCategoria)
End while 
SET QUERY DESTINATION:C396(Into current selection:K19:1)

$0:=$vl_idItemCategoria