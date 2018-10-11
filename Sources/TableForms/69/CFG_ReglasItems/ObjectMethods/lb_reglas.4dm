  // [xxBBL_ReglasParaItems].CFG_ReglasItems.List Box()

  // Por: Alberto Bachler K.: 14-07-14, 15:53:59
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


If ((<>aPrefDocName>0) & (<>aPrefDoc{<>aPrefDocName}#[xxBBL_ReglasParaItems:69]Codigo_regla:1))
	If (KRL_RegistroFueModificado (->[xxBBL_ReglasParaItems:69]))
		If ([xxBBL_ReglasParaItems:69]Codigo_regla:1#"")
			SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
		End if 
	End if 
	READ WRITE:C146([xxBBL_ReglasParaItems:69])
	QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1=<>aPrefDoc{<>aPrefDoc})
End if 