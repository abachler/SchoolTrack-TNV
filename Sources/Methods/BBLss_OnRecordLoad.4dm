//%attributes = {}
  //BBLss_OnRecordLoad

If ([BBL_Subscripciones:117]ID:1=0)
	[BBL_Subscripciones:117]ID:1:=SQ_SeqNumber (->[BBL_Subscripciones:117]ID:1)
	[BBL_Subscripciones:117]ID_Media:26:=-2
	[BBL_Subscripciones:117]Media:25:=<>atBBL_Media{Find in array:C230(<>alBBL_IDMedia;[BBL_Subscripciones:117]ID_Media:26)}
End if 
QUERY:C277([BBL_Items:61];[BBL_Items:61]Número_de_suscripción:41=[BBL_Subscripciones:117]ID:1)
KRL_RelateSelection (->[BBL_Registros:66]Número_de_item:1;->[BBL_Items:61]Numero:1;"")
LISTBOX SORT COLUMNS:C916(*;"lb_Ejemplares";1;<)

If (Record number:C243([BBL_Subscripciones:117])=-3)
	SET WINDOW TITLE:C213(__ ("Nueva suscripción"))
Else 
	SET WINDOW TITLE:C213(__ ("Suscripciones: ")+[BBL_Subscripciones:117]Titulo:2)
End if 
