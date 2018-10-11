//%attributes = {}
  //ACTitems_CargaLista
ARRAY TEXT:C222(atACT_GlosaItem;0)
ARRAY LONGINT:C221(alACT_IdItem;0)

C_TEXT:C284($t_periodo)


If (Count parameters:C259>=1)
	$t_periodo:=$1
End if 

READ WRITE:C146([xxACT_Items:179])
QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1>0;*)
QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1<99999)

If ($t_periodo#__ ("Todos"))
	QUERY SELECTION:C341([xxACT_Items:179];[xxACT_Items:179]Periodo:42=$t_periodo)
End if 

SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;alACT_IdItem;[xxACT_Items:179]Glosa:2;atACT_GlosaItem)
SORT ARRAY:C229(atACT_GlosaItem;alACT_IdItem;>)
