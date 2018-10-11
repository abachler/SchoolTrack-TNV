//%attributes = {}
  //Metodo: KRL_ExecuteOnConnectedClients
  //Por abachler
  //Creada el 04/10/2006, 16:27:46
  // ----------------------------------------------------
  // Descripción
  // Ejecuta el método cuyo nombre es pasado en $1 en todos los clientes conectados con excepción del cliente que hace el llamado
  // 
  // ----------------------------------------------------
  // Parámetros
  // $1: Nombre del método
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_TEXT:C284($methodname;$1)
ARRAY TEXT:C222($aClients;0)
ARRAY TEXT:C222($aMethods;0)
$methodname:=$1



  //CUERPO
If (Application type:C494=4D Remote mode:K5:5)
	GET REGISTERED CLIENTS:C650($clients;$methods)
	For ($i;1;Size of array:C274($clients))
		If ($clients{$i}#<>RegisteredName)
			EXECUTE ON CLIENT:C651($clients{$i};$methodName)
		End if 
	End for 
End if 

  //LIMPIEZA





