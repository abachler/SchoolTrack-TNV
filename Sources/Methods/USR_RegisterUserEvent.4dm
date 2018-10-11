//%attributes = {}
  // Método: USR_RegisterUserEvent
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 06/09/10, 12:33:53
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

C_LONGINT:C283($userEvent;$1;$tabNum;$2)
C_TEXT:C284($parameters;$3;$tabName)
C_TEXT:C284(vsBWR_CurrentModule;$module;$4)
C_LONGINT:C283($userID;$5)

$module:=vsBWR_CurrentModule
$userName:=<>tUSR_CurrentUserName
$userID:=<>lUSR_CurrentUserID

Case of 
	: (Count parameters:C259=5)  //Para STWA JHB 20130530
		$module:=$4
		$userID:=$5
		$userName:=USR_GetUserName ($userID)
		$parameters:=$3
		$tabNum:=$2
		$userEvent:=$1
	: (Count parameters:C259=3)
		$parameters:=$3
		$tabNum:=$2
		$userEvent:=$1
	: (Count parameters:C259=2)
		$tabNum:=$2
		$userEvent:=$1
	: (Count parameters:C259=1)
		$userEvent:=$1
End case 


If ($userID>0)
	CREATE RECORD:C68([xShell_UserEvents:282])
	[xShell_UserEvents:282]UserID:1:=$userID
	[xShell_UserEvents:282]UserName:2:=$userName
	[xShell_UserEvents:282]Module:4:=$module
	[xShell_UserEvents:282]Event:6:=$userEvent
	[xShell_UserEvents:282]TabNum:5:=$tabNum
	[xShell_UserEvents:282]Parameters:7:=$parameters
	[xShell_UserEvents:282]DTS:3:=DTS_MakeFromDateTime 
	SAVE RECORD:C53([xShell_UserEvents:282])
End if 



