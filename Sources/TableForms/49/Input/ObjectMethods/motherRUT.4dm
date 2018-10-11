If (<>vtXS_CountryCode="cl")
	Self:C308->:=CTRY_CL_VerifRUT (Self:C308->)
End if 
If (Self:C308->#"")
	READ ONLY:C145([Personas:7])
	SET QUERY LIMIT:C395(1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
	QUERY:C277([Personas:7];[Personas:7]RUT:6=Self:C308->;*)
	QUERY:C277([Personas:7]; & ;[Personas:7]No:1#vlPST_IDMOTHER)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SET QUERY LIMIT:C395(0)
	If ($recs=1)
		CD_Dlog (0;__ ("Ya existe una persona con este ")+<>at_IDNacional_Names{1}+__ ("."))
		vbSpell_StopChecking:=True:C214
		Self:C308->:=""
		GOTO OBJECT:C206(Self:C308->)
	End if 
Else 
	GOTO OBJECT:C206(Self:C308->)
End if 
PST_UpdateParents ("Mother")