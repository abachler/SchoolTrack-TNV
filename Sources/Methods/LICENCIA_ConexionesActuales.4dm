//%attributes = {}
  // Licencia_ConexionesActuales()
  // Por: Alberto Bachler K.: 29-08-14, 12:15:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

ARRAY LONGINT:C221($at_metodos;0)
ARRAY TEXT:C222($at_clientes;0)

If (False:C215)
	C_LONGINT:C283(Licencia_ConexionesActuales ;$0)
End if 

If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Server:K5:6))
	GET REGISTERED CLIENTS:C650($at_clientes;$at_metodos)
	$0:=Size of array:C274($at_clientes)
Else 
	$0:=1
End if 