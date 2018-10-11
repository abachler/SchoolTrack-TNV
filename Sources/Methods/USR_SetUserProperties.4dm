//%attributes = {}
  //USR_SetUserProperties

If (False:C215)
	  // Project method: XSug_SetUserProperties
	  // Module: 
	  // Purpose: Set User properties
	  // Syntax: XSug_SetUserProperties()
	  // Parameters: $1=userID(&L); $2=userName(&T); $3=startup method(&T); 
	  //$4=password(&T); $5=login number (&L); $6=last login(&D); $7=membersip (array 
	  //pointer)
	  // Result: 0 if failed
	  //            any other number if succesful
	
	  // HISTORY
	  // ============================================
	  // Created on: 12/1/02  07:50, by Alberto Bachler
	  // 
	  // 
End if 


  // DECLARATIONS
  // ============================================
C_LONGINT:C283($1;$id;$5;$nbLogin;$0)
C_TEXT:C284($2;$3;$4;$name;$Startup;$password)
C_DATE:C307($6;$lastLogin)
C_POINTER:C301($7;$membershipsArray)
  // INITIALIZATION
  // ============================================
$id:=$1
$name:=$2
$Startup:=$3
$password:=$4
$nbLogin:=$5
$lastLogin:=$6
If (Count parameters:C259=7)
	$membershipsArray:=$7
End if 


  // MAIN CODE
  // ============================================
If (<>vbUSR_Use4DSecurity)
	If (Count parameters:C259=7)
		$id:=Set user properties:C612($id;$name;$startup;$password;$nbLogin;$lastLogin;$membersArray->)
	Else 
		$id:=Set user properties:C612($id;$name;$startup;$password;$nbLogin;$lastLogin)
	End if 
Else 
	$el:=Find in array:C230(<>alUSR_UserIds;$id)
	If ($el>0)
		READ WRITE:C146([xShell_Users:47])
		GOTO RECORD:C242([xShell_Users:47];<>alUSR_USERSRECNUMS{$el})
		While (Locked:C147([xShell_Users:47]))
			DELAY PROCESS:C323(Current process:C322;10)
			LOAD RECORD:C52([xShell_Users:47])
		End while 
		[xShell_Users:47]login:9:=$name
		[xShell_Users:47]Startup_method:17:=$Startup
		[xShell_Users:47]Nb_sesions:8:=$nbLogin
		[xShell_Users:47]SessionDate:5:=$lastLogin
		If (Count parameters:C259=7)
			BLOB_Variables2Blob (->[xShell_Users:47]xGroups:18;0;$membershipsArray)
		End if 
		SAVE RECORD:C53([xShell_Users:47])
		$id:=[xShell_Users:47]No:1
		KRL_ReloadAsReadOnly (->[xShell_UserGroups:17])
	End if 
End if 

$0:=$id

  // END OF METHOD