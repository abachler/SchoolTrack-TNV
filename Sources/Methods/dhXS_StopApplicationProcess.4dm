//%attributes = {}
  //dhXS_StopApplicationProcess
C_TEXT:C284($processName)
C_LONGINT:C283($state;$i)
C_TIME:C306($time)
<>stopDaemons:=True:C214
For ($i;Size of array:C274(<>al_ProcesosFondo_Id);1;-1)
	  // MOD Ticket N° 208109 PA 20180629
	PROCESS PROPERTIES:C336(<>al_ProcesosFondo_Id{$i};$processName;$state;$time)
	If ($processName#"$uThermometer")
		While (Process state:C330(<>al_ProcesosFondo_Id{$i})>=Executing:K13:4)
			RESUME PROCESS:C320(<>al_ProcesosFondo_Id{$i})
			POST OUTSIDE CALL:C329(<>al_ProcesosFondo_Id{$i})
			DELAY PROCESS:C323(Current process:C322;10)
		End while 
		  // MOD Ticket N° 208924 PA 20180629
		  //If (Process state(<>al_ProcesosFondo_Id{$i})<Executing)
		  //AT_Delete ($i;1;-><>al_ProcesosFondo_Id;-><>at_ProcesosFondo_Nombre)
		  //End if 
	End if 
End for 
