//%attributes = {}
  //PCS_RunProcess

If (False:C215)
	  //Method: pcs RunProcess
	  //Written by  Alberto Bachler on 15/8/98
	  //Module: ProcessManager
	  //Purpose: Start a New Process
	  //Syntax:  $result:=pcs RunProcess(string;integer;string;boolean;boolean;Boolean) 
	  //Parameters:
	  //  $1: string - procedure to run
	  //  $2: integer - stack size (memory for process variables
	  //  $3: string - name of process created
	  //  $4: boolean - (true) inform the user that there wasn't enough memory to create
	  //      the process. (false) don't inform the user
	  //  $5: boolean - if true, allow multiple views
	  //  $6: booleen - if true the process number is installed on ◊aProcID array
	  //      (courtesy of A. Bächler)
	  //  $7: boolean - if true process is executed on server
	  //-> longint - process id, zero if process wasn't created
	  //Copyright 1998 Transeo Chile
	<>ST_v461:=False:C215
End if 


  //DECLARATIONS
C_BOOLEAN:C305($4;$5;$6;$7)
C_LONGINT:C283($id)
_O_C_STRING:C293(35;$methodName;$str)
_O_C_STRING:C293(80;$processName)

  //INITIALIZATION
$MethodName:=$1  //initializing default parameters
$stackSize:=$2
$ProcessName:=$3
$informUser:=False:C215
$multipleViews:=False:C215
$registerInArray:=True:C214
$onServer:=False:C215
$ID:=0


  //MAIN CODE
Case of 
	: (Count parameters:C259<4)
		$ID:=-1
	: (Count parameters:C259=7)
		$informUser:=False:C215
		$multipleViews:=$5
		$registerInArray:=$6
		$onServer:=$7
	: (Count parameters:C259=6)
		$informUser:=$4
		$multipleViews:=$5
		$registerInArray:=$6
	: (Count parameters:C259=5)
		$informUser:=$4
		$multipleViews:=$5
	: (Count parameters:C259=4)
		$informUser:=$4
End case 
Case of 
	: ((Application type:C494#4D Remote mode:K5:5) & (Application type:C494#4D Server:K5:6))
		$onServer:=False:C215
End case 

If ($ID=0)  //if no error calling this method
	$id:=Process number:C372($processName)
	If ($id=0)
		If (Not:C34(Semaphore:C143("$QUIT")))
			CLEAR SEMAPHORE:C144("$QUIT")
			If (($onserver) & (Not:C34(<>onServer)))
				$id:=Execute on server:C373($methodName;$stackSize;$processName)
			Else 
				$id:=New process:C317($methodName;$stackSize;$processName)
			End if 
			If ($id=0)
				If ($informUser)
					$r:=CD_Dlog (0;__ ("No hay suficiente memoria para iniciar el proceso ")+$processName)
				End if 
			End if 
		End if 
	Else 
		If ($multipleViews)
			If (($onserver) & (Not:C34(<>onServer)))
				$id:=Execute on server:C373($methodName;$stackSize;$processName+String:C10(PCS_NextView ($processName)))
			Else 
				$id:=New process:C317($methodName;$stackSize;$processName+String:C10(PCS_NextView ($processName)))
			End if 
			If ($id=0)
				If ($informUser)
					$str:=__ ("")
					$r:=CD_Dlog (2;$str)
				End if 
			End if 
		Else 
			If (Not:C34($onServer))
				BRING TO FRONT:C326($id)
			End if 
		End if 
	End if 
	If (($id>0) & ($registerInArray))
		  //If (Find in array(◊aProcID;$id)=-1)  `y tiene título
		  //Insert in Array(◊aProcId;Size of array(◊aProcID)+1)  `se incrementan los arreglos
		  //◊aProcID{Size of array(◊aProcID)}:=$id  `y se inscriben las informaciones
		  //End if 
	End if 
	$0:=$id
Else 
	$0:=0
End if 
  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 





