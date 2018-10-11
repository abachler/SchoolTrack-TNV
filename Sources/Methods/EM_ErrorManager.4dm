//%attributes = {}
  //EM_ErrorManager
C_BOOLEAN:C305(vbEM_LogError;vbEM_DisplayAlertOnError)
C_TEXT:C284($1;$2)
$Message:=$1

Case of 
	: ($message="SetMode")
		$mode:=$2
		Case of 
			: ($mode="Alert")
				vbEM_DisplayAlertOnError:=True:C214
				vbEM_LogError:=False:C215
			: ($mode="Log")
				vbEM_DisplayAlertOnError:=False:C215
				vbEM_LogError:=True:C214
			: ($mode="Both")
				vbEM_DisplayAlertOnError:=True:C214
				vbEM_LogError:=True:C214
			: ($mode="")
				vbEM_DisplayAlertOnError:=False:C215
				vbEM_LogError:=False:C215
		End case 
	: ($message="Install")
		error:=0
		vl_ErrorCode:=0
		If (Count parameters:C259=2)
			$method:=$2
		Else 
			$method:="EM_GenericInterruption"
		End if 
		vtEM_CurrentMethodName:=""
		vtEM_FailedInstruction:=""
		ON ERR CALL:C155($method)
		EM_ErrorManager ("SetMode";"Both")
	: ($message="Clear")
		ON ERR CALL:C155("")
		error:=0
		vtEM_CurrentMethodName:=""
		vtEM_FailedInstruction:=""
		vl_ErrorCode:=0
	: ($message="SetCurrentMethod")
		vtEM_CurrentMethodName:=$2
	: ($message="InstallFailedInstruction")
		vtEM_FailedInstruction:=$2
	: ($message="ClearFailedInstruction")
		vtEM_FailedInstruction:=""
	: ($message="LogError")
		CREATE RECORD:C68([xShell_ErrorLog:34])
		[xShell_ErrorLog:34]EntryDate:5:=Current date:C33(*)
		[xShell_ErrorLog:34]EntryTime:6:=Current time:C178(*)
		PROCESS PROPERTIES:C336(Current process:C322;$processName;$procState;$procTime)
		[xShell_ErrorLog:34]ErrorMsg:7:="Error "+String:C10(vl_ErrorCode)+"\rMétodo "+vtEM_CurrentMethodName+"\rProceso"+$processName
		If (vtEM_FailedInstruction#"")
			[xShell_ErrorLog:34]ErrorMsg:7:=[xShell_ErrorLog:34]ErrorMsg:7+"\rInstrucción"+vtEM_FailedInstruction
		End if 
		If (Application type:C494=4D Server:K5:6)
			[xShell_ErrorLog:34]UserName:1:="Application Server"
			[xShell_ErrorLog:34]MachineName:2:=Current machine:C483
			[xShell_ErrorLog:34]MachineOwner:3:=Current system user:C484
		Else 
			[xShell_ErrorLog:34]UserName:1:=USR_CurrentUser 
			[xShell_ErrorLog:34]MachineName:2:=Current machine:C483
			[xShell_ErrorLog:34]MachineOwner:3:=Current system user:C484
		End if 
		SYS_GetMemory 
		[xShell_ErrorLog:34]EnvironementInfo:8:="Máquina: "+SYS_GetMachineType +"\r"
		[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Sistema Operativo: "+SYS_GetOS +"\r"
		[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Memoria utilizada "+String:C10(vl_MemoriaUtilizada)+" Mb\r"
		[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Memoria instalada "+String:C10(vlPhysicalMemory)+" Mb\r"
		[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Memoria disponible "+String:C10(vlFreeMemory)+" Mb\r"
		[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Cache "+String:C10(vl_Cache)+" Mb\r"
		[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Cache utilizado "+String:C10(vl_CacheUtilizada)+" Mb\r"
		SAVE RECORD:C53([xShell_ErrorLog:34])
		
	: ($message="DisplayAlert")
		$msg:="Se produjo un error de tipo "+String:C10(vl_ErrorCode)+" cuando se ejecutaba el método "+vtEM_CurrentMethodName+"\r\r- Botón enviar mail envia un mensaje a soporte con los detalles del error.\r"
		$msg:=$msg+"- Botón Registrar registra los detalles del error sin mostrar nuevamente esta ale"+"rta."
		$answer:=CD_Dlog (0;$msg;"";"OK";"Enviar mail";"Registrar")
		Case of 
			: ($answer=2)
			: ($answer=3)
				CREATE RECORD:C68([xShell_ErrorLog:34])
				[xShell_ErrorLog:34]EntryDate:5:=Current date:C33(*)
				[xShell_ErrorLog:34]EntryTime:6:=Current time:C178(*)
				PROCESS PROPERTIES:C336(Current process:C322;$processName;$procState;$procTime)
				[xShell_ErrorLog:34]ErrorMsg:7:="Error "+String:C10(vl_ErrorCode)+"\rMétodo "+vtEM_CurrentMethodName+"\rProceso"+$processName
				If (vtEM_FailedInstruction#"")
					[xShell_ErrorLog:34]ErrorMsg:7:=[xShell_ErrorLog:34]ErrorMsg:7+"\rInstrucción"+vtEM_FailedInstruction
				End if 
				If (Application type:C494=4D Server:K5:6)
					[xShell_ErrorLog:34]UserName:1:="Application Server"
					[xShell_ErrorLog:34]MachineName:2:=Current machine:C483
					[xShell_ErrorLog:34]MachineOwner:3:=Current system user:C484
				Else 
					[xShell_ErrorLog:34]UserName:1:=USR_CurrentUser 
					[xShell_ErrorLog:34]MachineName:2:=Current machine:C483
					[xShell_ErrorLog:34]MachineOwner:3:=Current system user:C484
				End if 
				SYS_GetMemory 
				[xShell_ErrorLog:34]EnvironementInfo:8:="Máquina: "+SYS_GetMachineType +"\r"
				[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Sistema Operativo: "+SYS_GetOS +"\r"
				[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Memoria utilizada "+String:C10(vl_MemoriaUtilizada)+" Mb\r"
				[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Memoria instalada "+String:C10(vlPhysicalMemory)+" Mb\r"
				[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Memoria disponible "+String:C10(vlFreeMemory)+" Mb\r"
				[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Cache "+String:C10(vl_Cache)+" Mb\r"
				[xShell_ErrorLog:34]EnvironementInfo:8:=[xShell_ErrorLog:34]EnvironementInfo:8+"Cache utilizado "+String:C10(vl_CacheUtilizada)+" Mb\r"
				
				SAVE RECORD:C53([xShell_ErrorLog:34])
				EM_ErrorManager ("SetMode";"Log")
		End case 
End case 



