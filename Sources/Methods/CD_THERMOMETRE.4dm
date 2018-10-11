//%attributes = {}
  //CD_THERMOMETRE

If (False:C215)
	  //Method: cd_THERMOMETRE
	  //Written by  Alberto Bachler on 10/3/91
	  //Module: 
	  //Purpose: 
	  //Syntax:  cd_THERMOMETRE()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v45011:=False:C215  //10/3/98 at 08:33:14 by: Alberto Bachler
	  //programming style conventions implemented
End if 


  //DECLARATIONS
C_LONGINT:C283($1;$mode)
C_REAL:C285($2;vTh)
_O_C_STRING:C293(255;$3;$msg)
C_TIME:C306(vstartTime;vElapsed;vRemain)
C_TEXT:C284(vsBWR_CurrentModule)
$mode:=$1
If (Count parameters:C259>=2)
	$thermoValue:=$2
End if 
If (Count parameters:C259=3)
	$msg:=$3
End if 
If (Count parameters:C259=4)
	$msg:=$3
	If ($4=0)
		$forceDisplayOnServer:=False:C215
	Else 
		$forceDisplayOnServer:=True:C214
	End if 
Else 
	$forceDisplayOnServer:=True:C214
End if 

If ($forceDisplayOnServer)
	Case of 
		: ($mode=1)
			If (Records in table:C83([xShell_Dialogs:114])=0)
				CREATE RECORD:C68([xShell_Dialogs:114])
				SAVE RECORD:C53([xShell_Dialogs:114])
			End if 
			
			READ ONLY:C145([xShell_Dialogs:114])
			ALL RECORDS:C47([xShell_Dialogs:114])
			FIRST RECORD:C50([xShell_Dialogs:114])
			vmessage:=$msg
			FORM SET INPUT:C55([xShell_Dialogs:114];"Message")
			  //vL_ThermWindowRef:=WDW_OpenFormWindow (->[xShell_Dialogs];"Message";4;Palette form window;vsBWR_CurrentModule)
			vL_ThermWindowRef:=WDW_OpenFormWindow (->[xShell_Dialogs:114];"Message";4;Palette window:K34:3;vsBWR_CurrentModule)
			vTh:=$thermoValue
			vRemain:=?00:00:00?
			vStartTime:=Current time:C178
			vElapsed:=?00:00:00?
			DISPLAY RECORD:C105([xShell_Dialogs:114])
		: ($mode=0)
			vTh:=$thermoValue
			If ($msg#"")
				vMessage:=$msg
			End if 
			vElapsed:=(Current time:C178-vStartTime)
			$loopTime:=vElapsed/$2
			vRemain:=(100*$loopTime)-vElapsed
			Case of 
				: (vRemain<=?00:00:01?)
					vStrRemain:="1 segundo."
				: (vRemain<?00:00:59?)
					vStrRemain:=String:C10(vRemain*1)+" segundos."
				: (vRemain<=?00:03:00?)
					vStrRemain:=String:C10(vRemain;3)
				Else 
					vStrRemain:=String:C10(vRemain;4)
			End case 
			  //DISPLAY RECORD([xShell_Dialogs])
			BRING TO FRONT:C326(Current process:C322)
		: ($mode=-1)
			CLOSE WINDOW:C154
			vL_ThermWindowRef:=0
	End case 
	  //END OF METHOD
End if 

If (False:C215)  //utilizar despues de cambiar textos a recursos...
	If (False:C215)
		  //Method: cd_THERMOMETRE
		  //Written by  Alberto Bachler on 10/3/91
		  //Module: 
		  //Purpose: 
		  //Syntax:  cd_THERMOMETRE()
		  //Parameters:
		  //Copyright 1998 Transeo Chile
		<>ST_v45011:=False:C215  //10/3/98 at 08:33:14 by: Alberto Bachler
		  //programming style conventions implemented
	End if 
	
	
	  //DECLARATIONS
	C_LONGINT:C283($1;$mode)
	C_REAL:C285($2;vTh)
	_O_C_STRING:C293(255;$3;$msg)
	C_TIME:C306(vstartTime;vElapsed;vRemain)
	C_TEXT:C284(vsBWR_CurrentModule)
	$mode:=$1
	If (Count parameters:C259>=2)
		$thermoValue:=$2
	End if 
	If (Count parameters:C259=3)
		$msg:=$3
	End if 
	If (Count parameters:C259=4)
		$msg:=$3
		If ($4=0)
			$forceDisplayOnServer:=False:C215
		Else 
			$forceDisplayOnServer:=True:C214
		End if 
	Else 
		$forceDisplayOnServer:=True:C214
	End if 
	If ($forceDisplayOnServer)
		Case of 
			: ($mode=1)
				If (Records in table:C83([xShell_Dialogs:114])=0)
					CREATE RECORD:C68([xShell_Dialogs:114])
					SAVE RECORD:C53([xShell_Dialogs:114])
				End if 
				READ ONLY:C145([xShell_Dialogs:114])
				ALL RECORDS:C47([xShell_Dialogs:114])
				FIRST RECORD:C50([xShell_Dialogs:114])
				vmessage:=$msg
				FORM SET INPUT:C55([xShell_Dialogs:114];"Message")
				vL_ThermWindowRef:=WDW_OpenFormWindow (->[xShell_Dialogs:114];"Message";4;Palette form window:K39:9;vsBWR_CurrentModule)
				vTh:=$thermoValue
				vRemain:=?00:00:00?
				vStartTime:=Current time:C178
				vElapsed:=?00:00:00?
				DISPLAY RECORD:C105([xShell_Dialogs:114])
			: ($mode=0)
				vTh:=$thermoValue
				If ($msg#"")
					vMessage:=$msg
				End if 
				vElapsed:=(Current time:C178-vStartTime)
				$loopTime:=vElapsed/$2
				vRemain:=(100*$loopTime)-vElapsed
				Case of 
					: (vRemain<=?00:00:01?)
						vStrRemain:="1 segundo."
					: (vRemain<?00:00:59?)
						vStrRemain:=String:C10(vRemain*1)+" segundos."
					: (vRemain<=?00:03:00?)
						vStrRemain:=String:C10(vRemain;3)
					Else 
						vStrRemain:=String:C10(vRemain;4)
				End case 
				DISPLAY RECORD:C105([xShell_Dialogs:114])
			: ($mode=-1)
				CLOSE WINDOW:C154
				vL_ThermWindowRef:=0
		End case 
	End if 
End if 