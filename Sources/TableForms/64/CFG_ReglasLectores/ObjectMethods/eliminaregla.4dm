If ([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1="GEN")
	CD_Dlog (0;__ ("Esta es una regla genérica.\rNo es posible eliminarla."))
Else 
	QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Regla:4=[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
	If (Records in selection:C76([BBL_Lectores:72])=0)
		$r:=CD_Dlog (0;__ ("¿ Desea Ud. realmente eliminar la regla ")+[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1+__ ("?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			If (<>sMT_DefaultUserRule=[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
				<>sMT_DefaultUserRule:=""
			End if 
			DELETE RECORD:C58([xxBBL_ReglasParaUsuarios:64])
			AT_Delete (<>aPrefusr;1;-><>aPrefusr;-><>aPrefusrName)
			$rulePos:=<>aPrefusr
			Case of 
				: ($rulePos>1)
					<>aPrefusr:=$rulePos-1
					<>aPrefusrName:=<>aPrefusr
				: (($rulePos=1) & (Size of array:C274(<>aPrefusr)>=1))
					<>aPrefusr:=$rulePos
					<>aPrefusrName:=<>aPrefusr
			End case 
			QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1=<>aPrefusr{<>aPrefusr})
		End if 
	Else 
		CD_Dlog (0;__ ("Esta regla ha sido asignada a algunos usuarios.\rNo es posible eliminarla."))
	End if 
End if 