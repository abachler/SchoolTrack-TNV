//%attributes = {}
  //PREF_SaveParametersBD 
  //Guarda en preferencias los puertos de conexion de 4D y el web además guarda la configuración de time out de los clientes 4D

_O_C_STRING:C293(50;$vs_valor)

If (Application type:C494=4D Server:K5:6)
	PREF_Set (0;"Puerto_TCP";String:C10(Get database parameter:C643(Port ID:K37:15;$vs_valor)))
	PREF_Set (0;"ConnectionTimeOut";String:C10(Get database parameter:C643(4D Server timeout:K37:13;$vs_valor)))
	PREF_Set (0;"ClientServerPort";String:C10(Get database parameter:C643(Client Server port ID:K37:35;$vs_valor)))
End if 
