//%attributes = {"executedOnServer":true}
  // CMT_LimpiaConfiguracion()
  //
  //
  // creado por: Alberto Bachler Klein: 22-12-16, 12:12:16
  // -----------------------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($l_borrado)


If (False:C215)
	C_LONGINT:C283(CMT_LimpiaConfiguracion ;$0)
End if 

QUERY:C277([CMT_Transferencia:158];[CMT_Transferencia:158]Aplicacion:2=String:C10(CommTrack))
KRL_RelateSelection (->[CMT_Modificaciones:159]id_Transferencia:2;->[CMT_Transferencia:158]Id:1;"")
$l_borrado:=KRL_DeleteSelection (->[CMT_Modificaciones:159])
If ($l_borrado=1)
	$l_borrado:=KRL_DeleteSelection (->[CMT_Transferencia:158])
End if 
KRL_UnloadReadOnly (->[CMT_Transferencia:158])
KRL_UnloadReadOnly (->[CMT_Modificaciones:159])

$0:=$l_borrado