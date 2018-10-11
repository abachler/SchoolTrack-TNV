
Case of 
	: (Form event:C388=On Load:K2:1)
		vsColorString:="0x00000000"
		OBJECT SET RGB COLORS:C628(*;"Color";0x00FFFFFF;0x0000)
		viRed:=0
		viGreen:=0
		viBlue:=0
		vlRed:=0
		vlGreen:=0
		vlBlue:=0
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		OBJECT SET RGB COLORS:C628(*;"Color";0x00FFFFFF;(viRed << 16)+(viGreen << 8)+viBlue)
		vsColorString:=String:C10((viRed << 16)+(viGreen << 8)+viBlue;"&x")
		If (viRed=0)
			vsColorString:=Substring:C12(vsColorString;1;2)+"0000"+Substring:C12(vsColorString;3)
		End if 
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 