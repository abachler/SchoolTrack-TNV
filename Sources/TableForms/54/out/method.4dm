  // [xShell_Reports].out()
  // Por: Alberto Bachler K.: 04-08-14, 16:10:50
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Form event:C388=On Display Detail:K2:22)
	If ([xShell_Reports:54]IsStandard:38)
		OBJECT SET FONT STYLE:C166(*;"@campo";Bold:K14:2)
	Else 
		OBJECT SET FONT STYLE:C166(*;"@campo";Plain:K14:1)
	End if 
End if 
