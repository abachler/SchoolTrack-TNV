//%attributes = {}
  //MNU_InternalMsn

If (Process number:C372("Mensajeria Interna")>0)
	BRING TO FRONT:C326(Process number:C372("Mensajeria Interna"))
Else 
	$InternalMsn:=New process:C317("MSN_ClientInterface";Pila_256K;"Mensajeria Interna")
End if 