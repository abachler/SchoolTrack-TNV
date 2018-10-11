//%attributes = {}
  //0xDEV_RGBColorSelector

$processID:=Process number:C372(Current method name:C684)
Case of 
	: ($processID=0)
		$processID:=New process:C317(Current method name:C684;Pila_256K;Current method name:C684)
		
	: ($processID>0)
		If (Process state:C330($processID)#0)
			RESUME PROCESS:C320($processID)
			SHOW PROCESS:C325($processID)
			BRING TO FRONT:C326($processID)
		Else 
			SET MENU BAR:C67(3;Current process:C322)
			WDW_OpenFormWindow (->[xShell_Dialogs:114];"RGB_Colors";-1;-Palette form window:K39:9;__ ("Colores RGB"))
			DIALOG:C40([xShell_Dialogs:114];"RGB_Colors")
			CLOSE WINDOW:C154
		End if 
End case 

