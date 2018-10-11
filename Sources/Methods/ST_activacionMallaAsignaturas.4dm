//%attributes = {}
C_BOOLEAN:C305($0;$b_hecho)
C_LONGINT:C283($l_idasig;$vl_publicacion)
C_TEXT:C284($1)

ST_Deconcatenate (";";$1;->$l_idasig;->$vl_publicacion)

KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_idasig;True:C214)
If (ok=1)
	
	[Asignaturas:18]Publicar_en_SchoolNet:60:=$vl_publicacion
	SAVE RECORD:C53([Asignaturas:18])
	KRL_UnloadReadOnly (->[Asignaturas:18])
	$b_hecho:=True:C214
Else 
	If (Records in selection:C76([Asignaturas:18])=0)
		$b_hecho:=True:C214
	End if 
End if 
KRL_UnloadReadOnly (->[Asignaturas:18])

$0:=$b_hecho