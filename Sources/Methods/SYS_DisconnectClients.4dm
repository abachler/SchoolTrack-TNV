//%attributes = {}
  //SYS_DisconnectClients

  //`xShell, Alberto Bachler
  //Metodo: SYS_DisconnectClients
  //Por Administrator
  //Creada el 01/04/2005, 05:30:56
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_LONGINT:C283($minutes;$1;$attempts;$3)
C_BOOLEAN:C305($allowInitiatingClient;$2;$0)
C_TIME:C306($timeOut)
ARRAY TEXT:C222($clients;0)
ARRAY LONGINT:C221($methods;0)

  //****INICIALIZACIONES****
$minutes:=3
$allowInitiatingClient:=False:C215
$clientsDisconnected:=False:C215
Case of 
	: (Count parameters:C259=2)
		$minutes:=$1
		$allowInitiatingClient:=$2
	: (Count parameters:C259=1)
		$minutes:=$1
End case 
$timeout:=Current time:C178(*)+($minutes*60)

  //****CUERPO****
If (Not:C34(Semaphore:C143("DisconnectingClients")))
	$uThermPID:=IT_UThermometer (1;0;__ ("Desconectando clientes (")+String:C10($minutes)+__ (" minutos de espera)..."))
	
	
	
	GET REGISTERED CLIENTS:C650($clients;$methods)
	If (Size of array:C274($clients)>0)
		GET REGISTERED CLIENTS:C650($clients;$methods)
		For ($i;1;Size of array:C274($clients))
			If ($allowInitiatingClient)
				If ($clients{$i}#<>RegisteredName)
					EXECUTE ON CLIENT:C651($clients{$i};"USR_ForceQuit";$minutes)
				End if 
			Else 
				EXECUTE ON CLIENT:C651($clients{$i};"USR_ForceQuit";$minutes)
			End if 
		End for 
		
		Repeat 
			GET REGISTERED CLIENTS:C650($clients;$methods)
			If ($allowInitiatingClient)
				If (Size of array:C274($clients)=1)
					If ($clients{1}=<>RegisteredName)
						$clientsDisconnected:=True:C214
						$intentos:=4
					End if 
				End if 
			Else 
				If (Size of array:C274($clients)=0)
					$clientsDisconnected:=True:C214
					$intentos:=4
				End if 
			End if 
			DELAY PROCESS:C323(Current process:C322;60)
		Until ((Current time:C178(*)>=$timeout) | ($clientsDisconnected))
		
		  //espera de 5 segundos para dar a tiempo a los cliente de desregistrar y salir
		$delay:=5*60
		DELAY PROCESS:C323(Current process:C322;$delay)
		
		  //reverificación a la salida del bucle
		GET REGISTERED CLIENTS:C650($clients;$methods)
		If ($allowInitiatingClient)
			If (Size of array:C274($clients)=1)
				If ($clients{1}=<>RegisteredName)
					$clientsDisconnected:=True:C214
				End if 
			End if 
		Else 
			If (Size of array:C274($clients)=0)
				$clientsDisconnected:=True:C214
			End if 
		End if 
		
	Else 
		$clientsDisconnected:=True:C214
	End if 
	
	$p:=Execute on server:C373("STWA2_DisconnectAllClients";Pila_256K;"DisSTWA")  //20180131 RCH Ticket 
	
	CLEAR SEMAPHORE:C144("DisconnectingClients")
	$ignore:=IT_UThermometer (-2;$uThermPID)
End if 
$0:=$clientsDisconnected

  //****LIMPIEZA****








