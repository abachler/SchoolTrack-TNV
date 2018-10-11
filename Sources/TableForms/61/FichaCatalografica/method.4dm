
Case of 
	: (Form event:C388=On Load:K2:1)
		If (Records in selection:C76([BBL_FichasCatalograficas:81])>1)
			_O_DISABLE BUTTON:C193(bPrev)
			GET WINDOW RECT:C443($left;$top;$right;$bottom)
			SET WINDOW RECT:C444($left;$top;$right;$bottom+30)
		End if 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (Records in selection:C76([BBL_FichasCatalograficas:81])>1)
			Case of 
				: (Selected record number:C246([BBL_FichasCatalograficas:81])=1)
					_O_DISABLE BUTTON:C193(bPrev)
					_O_ENABLE BUTTON:C192(bNext)
				: (Selected record number:C246([BBL_FichasCatalograficas:81])=Records in selection:C76([BBL_FichasCatalograficas:81]))
					_O_DISABLE BUTTON:C193(bNext)
					_O_ENABLE BUTTON:C192(bPrev)
				Else 
					_O_ENABLE BUTTON:C192(bPrev)
					_O_ENABLE BUTTON:C192(bNext)
			End case 
		End if 
	: ((Form event:C388=On Deactivate:K2:10) | (Form event:C388=On Close Box:K2:21))
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 