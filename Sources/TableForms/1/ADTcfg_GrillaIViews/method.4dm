Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		PST_ReadParameters 
		If (Records in table:C83([ADT_Entrevistas:121])>0)
			OBJECT SET VISIBLE:C603(*;"elimina@";True:C214)
			OBJECT SET ENTERABLE:C238(*;"config@";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"elimina@";False:C215)
			OBJECT SET ENTERABLE:C238(*;"config@";True:C214)
			GET WINDOW RECT:C443($left;$top;$right;$bottom)
			SET WINDOW RECT:C444($left;$top;$right;$bottom-70)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
