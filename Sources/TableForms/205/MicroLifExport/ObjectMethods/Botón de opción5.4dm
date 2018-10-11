If (Self:C308->=1)
	OBJECT SET COLOR:C271(vt_RST;-14)
	OBJECT SET COLOR:C271(vt_RSE;-14)
	OBJECT SET COLOR:C271(vt_RSB;-3)
	OBJECT SET FONT STYLE:C166(vt_RST;Italic:K14:3)
	OBJECT SET FONT STYLE:C166(vt_RSE;Italic:K14:3)
	OBJECT SET FONT STYLE:C166(vt_RSB;Bold:K14:2+Italic:K14:3)
	
	vyQRY_TablePointer:=->[BBL_Items:61]
	wSrchInSel:=False:C215
	REDUCE SELECTION:C351([BBL_Items:61];0)
	QRY_QueryEditor 
	CREATE SET:C116([BBL_Items:61];"exportarBuscar")
	
	vt_RSB:="("+String:C10(Records in set:C195("exportarBuscar");"######0")+" registros)"
	IT_SetButtonState ((Num:C11(vt_RSB)#0);->bOK)
End if 