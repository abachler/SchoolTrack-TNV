//%attributes = {}
  //CFG_STR_Periodos


If (Not:C34(IT_AltKeyIsDown ))
	
	GET WINDOW RECT:C443($left;$top;$right;$bottom)
	FORM GET PROPERTIES:C674([xxSTR_Constants:1];"STR_CFG_Periodos";$width;$height)
	  //WDW_AdjustWinHeight2FormHeight (->[xxSTR_Constants];"Periodos&Horarios")
	
	SET WINDOW RECT:C444(($left-$width+$right)/2;$top;($left+$right+$width)/2;$height+$top)
	
	ALL RECORDS:C47([xxSTR_Constants:1])
	FIRST RECORD:C50([xxSTR_Constants:1])
	READ WRITE:C146([xxSTR_Horarios:40])
	ALL RECORDS:C47([xxSTR_Horarios:40])
	ORDER BY:C49([xxSTR_Horarios:40];[xxSTR_Horarios:40]Hora:1;>)
	KRL_ModifyRecord (->[xxSTR_Constants:1];"STR_cfg_Periodos")
	READ ONLY:C145([xxSTR_Horarios:40])
	KRL_ExecuteEverywhere ("STR_LeeConfiguracion")
Else 
	CFG_STR_PeriodosEscolares_NEW 
	KRL_ExecuteEverywhere ("STR_LeeConfiguracion")
End if 


