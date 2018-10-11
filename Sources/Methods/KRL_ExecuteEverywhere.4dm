//%attributes = {}
  //KRL_ExecuteEverywhere

$method:=$1

EXECUTE FORMULA:C63($method)
If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373($method;Pila_256K;"EjecucionTotal")
	KRL_ExecuteOnConnectedClients ($method)
End if 