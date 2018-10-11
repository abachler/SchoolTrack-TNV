//%attributes = {}
  //Metodo: WDW_FindWindowByName
  //Por abachler
  //Creada el 04/10/2006, 12:04:57
  // ----------------------------------------------------
  // Descripción
  // Retorna la referencia de la ventana si existe una ventana abierta con el nombre pasado $1
  // El argumento opcional $2 permite filtrar las ventanas según el tipo del proceso en que se originó
  // para el tipo de proceso en que se origina la ventana ver comando Process Properties o las constantes del tema Process Type
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_TEXT:C284($1;$windowName;$procName;$wTitle)
C_LONGINT:C283($processFilter;$process;$procState;$procTime;$uniqueID;$processType;$0)
C_BOOLEAN:C305($procVisible;$filterByProcess)

$0:=-1
$windowName:=$1
If (Count parameters:C259=2)
	$processFilter:=$2
	$filterByProcess:=True:C214
End if 


  //CUERPO
WINDOW LIST:C442($aWindows)
For ($i;1;Size of array:C274($aWindows))
	$wTitle:=Get window title:C450($aWindows{$i})
	If ($wTitle=$windowName)
		If ($filterByProcess)
			$process:=Window process:C446($aWindows{$i})
			PROCESS PROPERTIES:C336($process;$procName;$procState;$procTime;$procVisible;$uniqueID;$processType)
			If ($processType=$processFilter)
				$0:=$aWindows{$i}
				$i:=Size of array:C274($aWindows)+1
			End if 
		Else 
			$0:=$aWindows{$i}
			$i:=Size of array:C274($aWindows)+1
		End if 
	End if 
End for 









