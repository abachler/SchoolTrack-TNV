If ([xxBBL_ReglasParaItems:69]Codigo_regla:1="GEN")
	CD_Dlog (0;__ ("Esta es una regla genérica.\rNo es posible eliminarla."))
Else 
	QUERY:C277([BBL_Items:61];[BBL_Items:61]Regla:20=[xxBBL_ReglasParaItems:69]Codigo_regla:1)
	If (Records in selection:C76([BBL_Items:61])=0)
		$r:=CD_Dlog (0;__ ("¿ Desea Ud. realmente eliminar la regla ")+[xxBBL_ReglasParaItems:69]Codigo_regla:1+__ ("?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			If (<>sMT_DefaultItemRule=[xxBBL_ReglasParaItems:69]Codigo_regla:1)
				<>sMT_DefaultItemRule:=""
			End if 
			DELETE RECORD:C58([xxBBL_ReglasParaItems:69])
			AT_Delete (<>aPrefDoc;1;-><>aPrefDoc;-><>aPrefDocName)
			$rulePos:=<>aPrefDoc
			Case of 
				: ($rulePos>1)
					<>aPrefDoc:=$rulePos-1
					<>aPrefDocName:=<>aPrefDoc
				: (($rulePos=1) & (Size of array:C274(<>aPrefDoc)>=1))
					<>aPrefDoc:=$rulePos
					<>aPrefDocName:=<>aPrefDoc
			End case 
		End if 
	Else 
		CD_Dlog (0;__ ("Esta regla ha sido asignada a algunos items.\rNo es posible eliminarla."))
	End if 
End if 
