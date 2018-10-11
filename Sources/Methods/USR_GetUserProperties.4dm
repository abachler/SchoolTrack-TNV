//%attributes = {}
  //USR_GetUserProperties

If (False:C215)
	  // Project method: XSug_GetUserProperties
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_GetUserProperties()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 10/1/02  12:23, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
C_LONGINT:C283($1;$id)
C_POINTER:C301($2;$3;$4;$5;$6;$7;$name;$Startup;$password)

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
	AT_Initialize ($membershipsArray)
End if 

$name->:=""
$Startup->:=""
$password->:=""
$nbLogin->:=0
$lastLogin->:=!00-00-00!

  // MAIN CODE
  // ============================================
ARRAY LONGINT:C221($tempLongArray;0)
If (<>vbUSR_Use4DSecurity)
	If (Count parameters:C259=7)
		GET USER PROPERTIES:C611($id;$name->;$startup->;$password->;$nbLogin->;$lastLogin->;$tempLongArray)
	Else 
		GET USER PROPERTIES:C611($id;$name->;$startup->;$password->;$nbLogin->;$lastLogin->)
	End if 
Else 
	$el:=Find in array:C230(<>alUSR_UserIds;$id)
	If ($el>0)
		READ ONLY:C145([xShell_Users:47])
		GOTO RECORD:C242([xShell_Users:47];<>alUSR_USERSRECNUMS{$el})
		$name->:=[xShell_Users:47]login:9
		$Startup->:=[xShell_Users:47]Startup_method:17
		$password->:=[xShell_Users:47]Password:3
		$nbLogin->:=[xShell_Users:47]Nb_sesions:8
		$lastLogin->:=[xShell_Users:47]SessionDate:5
		If (Count parameters:C259=7)
			BLOB_Blob2Vars (->[xShell_Users:47]xGroups:18;0;->$tempLongArray)
			If ((Type:C295($tempLongArray)#Type:C295($membershipsArray->)))  //evita errores de tipo si las membrecias en el blob fueron guardadas previamente con otro tipo de arreglo
				AT_CopyArrayElements (->$tempLongArray;$membershipsArray)
			Else 
				COPY ARRAY:C226($tempLongArray;$membershipsArray->)
			End if 
		End if 
	End if 
End if 





  // END OF METHOD