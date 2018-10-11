If (KRL_RegistroFueModificado (->[xxBBL_ReglasParaItems:69]))
	If ([xxBBL_ReglasParaItems:69]Codigo_regla:1#"")
		SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
	End if 
End if 
CREATE RECORD:C68([xxBBL_ReglasParaItems:69])
[xxBBL_ReglasParaItems:69]Codigo_regla:1:="R"+String:C10(Sequence number:C244([xxBBL_ReglasParaItems:69]))
[xxBBL_ReglasParaItems:69]Nombre Regla:2:="Regla Nº"+String:C10(Sequence number:C244([xxBBL_ReglasParaItems:69]))
SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
APPEND TO ARRAY:C911(<>aPrefDoc;[xxBBL_ReglasParaItems:69]Codigo_regla:1)
APPEND TO ARRAY:C911(<>aPrefDocName;[xxBBL_ReglasParaItems:69]Nombre Regla:2)
<>aPrefDoc:=Size of array:C274(<>aPrefDoc)
<>aPrefDocName:=Size of array:C274(<>aPrefDoc)
GOTO OBJECT:C206([xxBBL_ReglasParaItems:69]Codigo_regla:1)
