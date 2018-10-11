If (Form event:C388=On Data Change:K2:15)
	If (Self:C308->#"")
		SET QUERY LIMIT:C395(1)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
		QUERY:C277([Personas:7];[Personas:7]IDNacional_3:38=Self:C308->;*)
		QUERY:C277([Personas:7]; & ;[Personas:7]No:1#vlPST_IDMOTHER)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SET QUERY LIMIT:C395(0)
		If ($recs>0)
			CD_Dlog (0;__ ("Error: Ya existe una persona con ")+<>at_IDNacional_Names{3}+__ (" ")+Self:C308->+__ ("."))
			GOTO OBJECT:C206(Self:C308->)
		End if 
	End if 
	PST_UpdateParents ("Mother")
End if 