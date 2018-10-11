If ([xxBBL_ReglasParaItems:69]Default:10)
	If (<>sMT_DefaultItemRule#[xxBBL_ReglasParaItems:69]Codigo_regla:1)
		<>sMT_DefaultItemRule:=[xxBBL_ReglasParaItems:69]Codigo_regla:1
		$rec:=Record number:C243([xxBBL_ReglasParaItems:69])
		SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
		READ WRITE:C146([xxBBL_ReglasParaItems:69])
		QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1#<>sMT_DefaultItemRule)
		APPLY TO SELECTION:C70([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Default:10:=False:C215)
		GOTO RECORD:C242([xxBBL_ReglasParaItems:69];$REC)
	End if 
Else 
	<>sMT_DefaultItemRule:=""
End if 