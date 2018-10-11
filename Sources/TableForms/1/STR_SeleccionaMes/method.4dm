
Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283(hl_MesesSel;vi_NumeroMes)
		C_TEXT:C284(vt_NombreMes)
		
		hl_MesesSel:=New list:C375
		ARRAY TO LIST:C287(<>atXS_MonthNames;hl_MesesSel)
		
		
		SELECT LIST ITEMS BY POSITION:C381(hl_MesesSel;Month of:C24(Current date:C33(*)-1))
		vi_SelectedMonth:=Selected list items:C379(hl_MesesSel)
		GET LIST ITEM:C378(hl_MesesSel;*;vi_NumeroMes;vt_NombreMes)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		CLEAR LIST:C377(hl_MesesSel)
		
End case 
