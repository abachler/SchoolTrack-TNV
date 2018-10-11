Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283(hl_Meses)
		XS_SetInterface 
		If (Not:C34(Is a list:C621(hl_Meses)))
			hl_Meses:=AT_Array2List (-><>atXS_MonthNames)
		End if 
		SELECT LIST ITEMS BY POSITION:C381(hl_Meses;Month of:C24(Current date:C33(*)-1))
		vi_Mes:=Selected list items:C379(hl_Meses)
		wref:=WDW_GetWindowID 
		cs_1:=0
		cs_2:=0
		IT_SetButtonState (((cs_1=1) | (cs_2=1));->bOK)
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
	: (Form event:C388=On Close Box:K2:21)
		cs_Imprimir:=0
		exportReport:=0
		vt_ErrorEjecucionScript:="Cancel"
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		CLEAR LIST:C377(hl_meses)
		  // MOD ticket N° 191835 PA 20171116
		If (cs_Imprimir=1)
			vt_ErrorEjecucionScript:=""
		Else 
			vt_ErrorEjecucionScript:="Cancel or export"
		End if 
End case 
