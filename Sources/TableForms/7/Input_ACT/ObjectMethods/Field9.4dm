IT_Clairvoyance (Self:C308;-><>aReligion;"Religiones")
If ([Personas:7]Religión:9#"")
	SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
	QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]Religion:2=[Personas:7]Religión:9)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($recs>0)
		OBJECT SET FONT STYLE:C166(*;"religion";Underline:K14:4)
		OBJECT SET COLOR:C271(*;"religion";-6)
		_O_ENABLE BUTTON:C192(bReligionExt)
	Else 
		OBJECT SET FONT STYLE:C166(*;"religion";Plain:K14:1)
		OBJECT SET COLOR:C271(*;"religion";-15)
		_O_DISABLE BUTTON:C193(bReligionExt)
	End if 
Else 
	OBJECT SET FONT STYLE:C166(*;"religion";Plain:K14:1)
	OBJECT SET COLOR:C271(*;"religion";-15)
	_O_DISABLE BUTTON:C193(bReligionExt)
End if 