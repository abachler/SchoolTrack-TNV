//%attributes = {}
  //EM_HandleError

If (False:C215)
	  // Project method: XSerr_HandleError
	  // Module: 
	  // Purpose:
	  // Syntax: XSerr_HandleError()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 29/12/01  14:55, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================


  // INITIALIZATION
  // ============================================
$message:=$1
$user:=Current user:C182
$machine:=Current machine:C483
Case of 
	: (Count parameters:C259=4)
		$methodName:=$2
		$user:=$3
		$machine:=$4
	: (Count parameters:C259>=3)
		$methodName:=$2
		$user:=$3
	: (Count parameters:C259>=2)
		$methodName:=$2
End case 



  // MAIN CODE
  // ============================================


If (<>b_XSerr_logError)
	  //log Error
Else 
	CD_Dlog (0;$message)
End if 


  // END OF METHOD