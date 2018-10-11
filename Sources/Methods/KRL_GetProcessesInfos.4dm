//%attributes = {}
  //KRL_GetProcessesInfos

C_BOOLEAN:C305($procVisible)
C_LONGINT:C283($unique)
C_LONGINT:C283($origin)


Case of 
	: (Application type:C494=4D Remote mode:K5:5)
		ARRAY LONGINT:C221(<>alXSkrl_ProcessNumber;0)
		ARRAY TEXT:C222(<>atXSkrl_ProcessName;0)
		ARRAY TEXT:C222(<>atXSkrl_ProcessState;0)
		ARRAY TEXT:C222(<>atXSkrl_ProcessTime;0)
		ARRAY LONGINT:C221(<>alXSkrl_ProcessState;0)
		$pId:=Execute on server:C373(Current method name:C684;Pila_256K;"LecturaProcesoClientes")
		DELAY PROCESS:C323(Current process:C322;60)
		$executing:=Test semaphore:C652("LecturaProcesoClientes")
		While ($executing)
			DELAY PROCESS:C323(Current process:C322;15)
			$executing:=Test semaphore:C652("LecturaProcesoClientes")
		End while 
		GET PROCESS VARIABLE:C371(-1;<>alXSkrl_ProcessNumber;<>alXSkrl_ProcessNumber;<>atXSkrl_ProcessName;<>atXSkrl_ProcessName;<>atXSkrl_ProcessState;<>atXSkrl_ProcessState;<>atXSkrl_ProcessTime;<>atXSkrl_ProcessTime;<>alXSkrl_ProcessState;<>alXSkrl_ProcessState)
		
		  //procesos cliente o standalone
		$size:=Count tasks:C335
		ARRAY LONGINT:C221(alXSkrl_ProcessNumber;$size)
		ARRAY TEXT:C222(atXSkrl_ProcessName;$size)
		ARRAY TEXT:C222(atXSkrl_ProcessState;$size)
		ARRAY TEXT:C222(atXSkrl_ProcessTime;$size)
		ARRAY LONGINT:C221(alXSkrl_ProcessState;$size)
		For ($i;1;$size)
			PROCESS PROPERTIES:C336($i;$procName;$procState;$procTime;$procVisible)
			alXSkrl_ProcessNumber{$i}:=$i
			atXSkrl_ProcessName{$i}:=$procName
			alXSkrl_ProcessState{$i}:=$procState
			Case of 
				: ($procState=-0)
					atXSkrl_ProcessState{$i}:=__ ("En ejecución")
				: ($procState=1)
					atXSkrl_ProcessState{$i}:=__ ("Suspendido")
				: ($procState=2)
					atXSkrl_ProcessState{$i}:=__ ("Esperando acción del usuario")
				: ($procState=3)
					atXSkrl_ProcessState{$i}:=__ ("Esperando I/O")
				: ($procState=4)
					atXSkrl_ProcessState{$i}:=__ ("Esperando semáforo interno")
				: ($procState=5)
					atXSkrl_ProcessState{$i}:=__ ("Pausado")
				: ($procState=6)
					atXSkrl_ProcessState{$i}:=__ ("Diálogo invisible")
				: ($procState=-1)
					atXSkrl_ProcessState{$i}:=__ ("Abortado")
				: ($procState=-100)
					atXSkrl_ProcessState{$i}:=__ ("Inexistente")
			End case 
			atXSkrl_ProcessTime{$i}:=String:C10(Round:C94($procTime/60;0);"#####0s")
		End for 
		For ($i;$size;1;-1)
			If ((alXSkrl_ProcessState{$i}=Aborted:K13:1) | (alXSkrl_ProcessState{$i}=Does not exist:K13:3))
				AT_Delete ($i;1;->alXSkrl_ProcessNumber;->atXSkrl_ProcessState;->atXSkrl_ProcessName;->atXSkrl_ProcessTime;->alXSkrl_ProcessState)
			End if 
		End for 
		$currentArrSize:=Size of array:C274(atXSkrl_ProcessState)
		
		
		AT_Insert (0;Size of array:C274(<>alXSkrl_ProcessNumber);->alXSkrl_ProcessNumber;->atXSkrl_ProcessState;->atXSkrl_ProcessName;->atXSkrl_ProcessTime;->alXSkrl_ProcessState)
		For ($i;1;Size of array:C274(<>alXSkrl_ProcessNumber))
			alXSkrl_ProcessNumber{$currentArrSize+$i}:=<>alXSkrl_ProcessNumber{$i}
			atXSkrl_ProcessState{$currentArrSize+$i}:=<>atXSkrl_ProcessState{$i}
			atXSkrl_ProcessName{$currentArrSize+$i}:=<>atXSkrl_ProcessName{$i}
			atXSkrl_ProcessTime{$currentArrSize+$i}:=<>atXSkrl_ProcessTime{$i}
			alXSkrl_ProcessState{$currentArrSize+$i}:=<>alXSkrl_ProcessState{$i}
		End for 
		
		
	: (Application type:C494=4D Server:K5:6)
		$semaphore:=Semaphore:C143("LecturaProcesoClientes")
		  //procesos cliente o standalone
		$size:=Count tasks:C335
		ARRAY LONGINT:C221(<>alXSkrl_ProcessNumber;$size)
		ARRAY TEXT:C222(<>atXSkrl_ProcessName;$size)
		ARRAY TEXT:C222(<>atXSkrl_ProcessState;$size)
		ARRAY TEXT:C222(<>atXSkrl_ProcessTime;$size)
		ARRAY LONGINT:C221(<>alXSkrl_ProcessState;$size)
		ARRAY LONGINT:C221($aOrigin;$size)
		For ($i;1;$size)
			PROCESS PROPERTIES:C336($i;$procName;$procState;$procTime;$procVisible;$unique;$origin)
			<>alXSkrl_ProcessNumber{$i}:=$i*-1
			<>atXSkrl_ProcessName{$i}:=$procName
			<>alXSkrl_ProcessState{$i}:=$procState
			$aOrigin{$i}:=$origin
			Case of 
				: ($procState=-0)
					<>atXSkrl_ProcessState{$i}:=__ ("En ejecución")
				: ($procState=1)
					<>atXSkrl_ProcessState{$i}:=__ ("Suspendido")
				: ($procState=2)
					<>atXSkrl_ProcessState{$i}:=__ ("Esperando acción del usuario")
				: ($procState=3)
					<>atXSkrl_ProcessState{$i}:=__ ("Esperando I/O")
				: ($procState=4)
					<>atXSkrl_ProcessState{$i}:=__ ("Esperando semáforo interno")
				: ($procState=5)
					<>atXSkrl_ProcessState{$i}:=__ ("Pausado")
				: ($procState=6)
					<>atXSkrl_ProcessState{$i}:=__ ("Diálogo invisible")
				: ($procState=-1)
					<>atXSkrl_ProcessState{$i}:=__ ("Abortado")
				: ($procState=-100)
					<>atXSkrl_ProcessState{$i}:=__ ("Inexistente")
			End case 
			<>atXSkrl_ProcessTime{$i}:=String:C10(Round:C94($procTime/60;0);"#####0s")
		End for 
		
		For ($i;$size;1;-1)
			If ((<>alXSkrl_ProcessState{$i}=Aborted:K13:1) | (<>alXSkrl_ProcessState{$i}=Does not exist:K13:3) | ($aOrigin{$i}#4))
				AT_Delete ($i;1;-><>alXSkrl_ProcessNumber;-><>atXSkrl_ProcessState;-><>atXSkrl_ProcessName;-><>atXSkrl_ProcessTime;-><>alXSkrl_ProcessState)
			End if 
		End for 
		CLEAR SEMAPHORE:C144("LecturaProcesoClientes")
	Else 
		  //procesos cliente o standalone
		$size:=Count tasks:C335
		ARRAY LONGINT:C221(alXSkrl_ProcessNumber;$size)
		ARRAY TEXT:C222(atXSkrl_ProcessName;$size)
		ARRAY TEXT:C222(atXSkrl_ProcessState;$size)
		ARRAY TEXT:C222(atXSkrl_ProcessTime;$size)
		ARRAY LONGINT:C221(alXSkrl_ProcessState;$size)
		For ($i;1;$size)
			PROCESS PROPERTIES:C336($i;$procName;$procState;$procTime;$procVisible)
			alXSkrl_ProcessNumber{$i}:=$i
			atXSkrl_ProcessName{$i}:=$procName
			alXSkrl_ProcessState{$i}:=$procState
			Case of 
				: ($procState=-0)
					atXSkrl_ProcessState{$i}:=__ ("En ejecución")
				: ($procState=1)
					atXSkrl_ProcessState{$i}:=__ ("Suspendido")
				: ($procState=2)
					atXSkrl_ProcessState{$i}:=__ ("Esperando acción del usuario")
				: ($procState=3)
					atXSkrl_ProcessState{$i}:=__ ("Esperando I/O")
				: ($procState=4)
					atXSkrl_ProcessState{$i}:=__ ("Esperando semáforo interno")
				: ($procState=5)
					atXSkrl_ProcessState{$i}:=__ ("Pausado")
				: ($procState=6)
					atXSkrl_ProcessState{$i}:=__ ("Diálogo invisible")
				: ($procState=-1)
					atXSkrl_ProcessState{$i}:=__ ("Abortado")
				: ($procState=-100)
					atXSkrl_ProcessState{$i}:=__ ("Inexistente")
			End case 
			atXSkrl_ProcessTime{$i}:=String:C10(Round:C94($procTime/60;0);"#####0s")
		End for 
		
		For ($i;$size;1;-1)
			If ((alXSkrl_ProcessState{$i}=Aborted:K13:1) | (alXSkrl_ProcessState{$i}=Does not exist:K13:3))
				AT_Delete ($i;1;->alXSkrl_ProcessNumber;->atXSkrl_ProcessState;->atXSkrl_ProcessName;->atXSkrl_ProcessTime;->alXSkrl_ProcessState)
			End if 
		End for 
End case 