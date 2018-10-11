//%attributes = {}
  // Método: 4Dx_SetDebugLogLocal
  //
  // 
  // creado por Alberto Bachler Klein
  // el 07/03/18, 11:48:03
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($1)

C_LONGINT:C283($l_mode)

If (False:C215)
	C_LONGINT:C283(4Dx_SetDebugLog ;$1)
End if 

If (Count parameters:C259=0)
	$l_mode:=1
Else 
	$l_mode:=$1
End if 


If ($l_mode>=1)
	$l_currentMode:=Get database parameter:C643(Debug log recording:K37:34)
	If ($l_currentMode>0)
		SET DATABASE PARAMETER:C642(Circular log limitation:K37:76;0)
		SET DATABASE PARAMETER:C642(Debug log recording:K37:34;0)
	End if 
	
	Case of 
		: (Not:C34($l_mode ?? 2))
			$l_mode:=$l_mode ?+ 2
	End case 
	
	
	SET DATABASE PARAMETER:C642(Circular log limitation:K37:76;50)
	SET DATABASE PARAMETER:C642(Debug log recording:K37:34;$l_mode)
Else 
	SET DATABASE PARAMETER:C642(Circular log limitation:K37:76;0)
	SET DATABASE PARAMETER:C642(Debug log recording:K37:34;0)
End if 
