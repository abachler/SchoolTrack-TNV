
Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET FONT STYLE:C166(*;"s1_texto";Bold:K14:2)
		OBJECT SET FONT STYLE:C166(*;"s3_texto";Plain:K14:1)
		OBJECT SET FONT STYLE:C166(*;"s4_texto";Plain:K14:1)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Unload:K2:2)
		
End case 
