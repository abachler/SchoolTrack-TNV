Spell_CheckSpelling 

$fevent:=Form event:C388
Case of 
	: ($fEvent=On Load:K2:1)
		XS_SetInterface 
		REDUCE SELECTION:C351([Personas:7];0)
		vsPST_aPaterno:=""
		vsPST_aMaterno:=""
		vsPST_Nombres:=""
		vdPST_fNac:=!00-00-00!
		vsPST_Profesion:=""
		vsPST_TelPers:=""
		vsPST_TelPro:=""
		vsPST_RUT:=""
		viPST_ex:=0
		_O_DISABLE BUTTON:C193(bNew)
		_O_DISABLE BUTTON:C193(bSelect)
		OBJECT SET FONT STYLE:C166(bNew;0)
		OBJECT SET FONT STYLE:C166(bSelect;0)
	: (($fEvent=On Clicked:K2:4) | ($fEvent=On Data Change:K2:15))
		Case of 
			: ((aParentNames>0) & (vsPST_aPaterno#""))
				_O_ENABLE BUTTON:C192(bNew)
				_O_ENABLE BUTTON:C192(bSelect)
				OBJECT SET FONT STYLE:C166(bNew;0)
				OBJECT SET FONT STYLE:C166(bSelect;0)
			: (aParentNames>0)
				_O_ENABLE BUTTON:C192(bSelect)
				OBJECT SET FONT STYLE:C166(bNew;0)
				OBJECT SET FONT STYLE:C166(bSelect;1)
			: (vsPST_aPaterno#"")
				_O_DISABLE BUTTON:C193(bSelect)
				_O_ENABLE BUTTON:C192(bNew)
				OBJECT SET FONT STYLE:C166(bNew;1)
				OBJECT SET FONT STYLE:C166(bSelect;0)
			Else 
				_O_DISABLE BUTTON:C193(bNew)
				_O_DISABLE BUTTON:C193(bSelect)
				OBJECT SET FONT STYLE:C166(bNew;0)
				OBJECT SET FONT STYLE:C166(bSelect;0)
		End case 
	: ($fevent=On Close Box:K2:21)
		CANCEL:C270
End case 

