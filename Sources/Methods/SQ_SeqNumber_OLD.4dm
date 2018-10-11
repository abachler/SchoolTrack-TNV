//%attributes = {}
  //SQ_SeqNumber_OLD

  //Metodo: SQ_SeqNumber
  //Por abachler
  //Creada el 12/4/96, 09:42
  // ----------------------------------------------------
  // Descripción
  // Retorna un número de secuencia para el campo pasado en argumento $1
  //
  // ----------------------------------------------------
  // Parámetros
  // Puntero sobre el campo para el que se desea obtener un número de secuencia
  // ----------------------------------------------------
  //MODIFICACIONES
  // //por ABK, 02/20/2008, 11:13:36
  //   si el llamado se hace desde una transacción el método se ejecuta en un proceso independiente para evitar el bloqueo en otras estaciones o procesos
  // //




  //DECLARACIONES & INICIALIZACIONES
C_POINTER:C301($1;$pointer)
C_REAL:C285($0;<>vl_CurrentSeqNumber)
C_LONGINT:C283($tableNum;$fieldNum)
_O_C_STRING:C293(31;$varName)
$pointer:=$1

  //CUERPO
If (In transaction:C397)
	  //Si estamos en transacción todos los registros cargados con acceso en escritura permanecen bloqueados hasta que la transacción es validada o cancelada, bloqueando
	  //el acceso a los registros para la misma tabla en la tabla [xShell_SequenceNumber] en otros procesos, lo que bloquea todo el sistema al ejecutarse la bucle (While..End While en línea 69..71)
	  //Para evitar este problema ejecutamos este mismo metodo en un proceso distinto. Como los procesos no pueden ser llamados como funciones asigno el sequence number obtenido a una variable 
	  //interproceso (◊vl_CurrentSeqNumber) que sólo será utilizada cuando estemos en un transacción. Debe necesariamente ser una variable interproceso ya que es necesario leer su valor
	  //en el proceso inicial. Para evitar que el valor de la variable sea sobreescrito en otro proceso pongo un semáforo que impide dos o más accesos simultaneos.
	  //
	  //La unica restricción es que si se cancela la transacción inicial, los sequence numbers son incrementados de todas maneras ya que se ejecutan en un proceso fuera de la transacción.
	While (Semaphore:C143("SequenceNumber"))  //pongo el semáforo para impedir la ejecución simultánea y el acceso a la variable desde dos procesos diferentes
		DELAY PROCESS:C323(Current process:C322;10)
	End while 
	<>vl_CurrentSeqNumber:=0  //inicializo la variable interproceso
	$pID:=Process number:C372(Current method name:C684)
	If ($pID#0)
		DELAY PROCESS:C323(Current process:C322;10)
	End if 
	$pID:=New process:C317("SQ_SeqNumberInProcess";Pila_256K;"SQ_SeqNumberInProcess";$pointer)
	While (<>vl_CurrentSeqNumber=0)  //esperamos que SQ_SeqNumber termine de ejecutarse
		DELAY PROCESS:C323(Current process:C322;10)
	End while 
	
	$0:=<>vl_CurrentSeqNumber  //asigno el valor de la variable interproceso al resultado de la función
	<>vl_CurrentSeqNumber:=0  //inicializo la variable interproceso
	
	CLEAR SEMAPHORE:C144("SequenceNumber")  //elimino el semáforo para liberar el acceso
	
Else 
	RESOLVE POINTER:C394($pointer;$varName;$tableNum;$fieldNum)
	READ WRITE:C146([xShell_SequenceNumbers:67])
	QUERY:C277([xShell_SequenceNumbers:67];[xShell_SequenceNumbers:67]Table_Number:1=$tableNum;*)
	QUERY:C277([xShell_SequenceNumbers:67]; & ;[xShell_SequenceNumbers:67]FieldNumber:4=$fieldNum)
	If (Records in selection:C76([xShell_SequenceNumbers:67])=0)  //if no record in sequences file
		CREATE RECORD:C68([xShell_SequenceNumbers:67])  //create the record
		[xShell_SequenceNumbers:67]Table_Number:1:=$tableNum
		[xShell_SequenceNumbers:67]FieldNumber:4:=$fieldnum
		If (Count parameters:C259=2)
			If ($2=True:C214)  //negatif number
				[xShell_SequenceNumbers:67]ID_Negatif:3:=-1  //first negatif number
				$0:=[xShell_SequenceNumbers:67]ID_Negatif:3
			Else 
				[xShell_SequenceNumbers:67]ID_Positif:2:=1  //first positif number
				$0:=[xShell_SequenceNumbers:67]ID_Positif:2
			End if 
		Else 
			[xShell_SequenceNumbers:67]ID_Positif:2:=1  //first positif number
			$0:=[xShell_SequenceNumbers:67]ID_Positif:2
		End if 
		SAVE RECORD:C53([xShell_SequenceNumbers:67])
		<>vl_CurrentSeqNumber:=$0
		
	Else 
		While (Locked:C147([xShell_SequenceNumbers:67]))  //loading record
			LOAD RECORD:C52([xShell_SequenceNumbers:67])
			DELAY PROCESS:C323(Current process:C322;10)
		End while 
		
		If (Count parameters:C259=2)
			If ($2=True:C214)  //negatif number
				[xShell_SequenceNumbers:67]ID_Negatif:3:=[xShell_SequenceNumbers:67]ID_Negatif:3-1  //decrement positif sequence number
				$0:=[xShell_SequenceNumbers:67]ID_Negatif:3
			Else 
				[xShell_SequenceNumbers:67]ID_Positif:2:=[xShell_SequenceNumbers:67]ID_Positif:2+1  //increment positif sequence number
				$0:=[xShell_SequenceNumbers:67]ID_Positif:2
				If ([xShell_SequenceNumbers:67]ID_Positif:2=0)
					[xShell_SequenceNumbers:67]ID_Positif:2:=1
				End if 
			End if 
		Else 
			[xShell_SequenceNumbers:67]ID_Positif:2:=[xShell_SequenceNumbers:67]ID_Positif:2+1  //increment positif sequence number
			If ([xShell_SequenceNumbers:67]ID_Positif:2=0)
				[xShell_SequenceNumbers:67]ID_Positif:2:=1
			End if 
			$0:=[xShell_SequenceNumbers:67]ID_Positif:2
		End if 
		SAVE RECORD:C53([xShell_SequenceNumbers:67])  //store the incremented sequence number
	End if 
	UNLOAD RECORD:C212([xShell_SequenceNumbers:67])
	<>vl_CurrentSeqNumber:=$0
End if 

  //LIMPIEZA









