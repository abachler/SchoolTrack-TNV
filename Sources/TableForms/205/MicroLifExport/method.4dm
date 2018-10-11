Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vt_RST:="("+String:C10(Records in table:C83([BBL_Items:61]);"######0")+" registros)"
		If (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Items:61]))
			vt_RSE:="("+String:C10(Records in set:C195("CurrentBBLItemsSel");"######0")+" registros)"
			_O_ENABLE BUTTON:C192(fListado)
		Else 
			vt_RSE:="(0 registros)"
			_O_DISABLE BUTTON:C193(fListado)
		End if 
		vt_RSB:="(0 registros)"
		
		fTodos:=1
		fListado:=0
		fBuscar:=0
		
		OBJECT SET COLOR:C271(vt_RST;-3)
		OBJECT SET COLOR:C271(vt_RSE;-14)
		OBJECT SET COLOR:C271(vt_RSB;-14)
		OBJECT SET FONT STYLE:C166(vt_RST;Bold:K14:2+Italic:K14:3)
		OBJECT SET FONT STYLE:C166(vt_RSE;Italic:K14:3)
		OBJECT SET FONT STYLE:C166(vt_RSB;Italic:K14:3)
		
		If (SYS_IsMacintosh )
			rMac:=1
			rWin:=0
		Else 
			rMac:=0
			rWin:=1
		End if 
		IT_SetButtonState ((Num:C11(vt_RST)#0);->bOK)
		ALL RECORDS:C47([BBL_Items:61])
		CREATE SET:C116([BBL_Items:61];"exportarTodos")
		
		OBJECT SET VISIBLE:C603(*;"Busqueda";False:C215)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 