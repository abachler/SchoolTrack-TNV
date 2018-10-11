Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ARRAY TEXT:C222(atEM4D_Attachments_paths;0)
		ARRAY TEXT:C222(atEM4D_Attachments;0)
		ARRAY TEXT:C222($aText;0)
		OBJECT GET COORDINATES:C663(vtEM4D_Body;$left;$top;$right;$bottom)
		$width:=$right-$left-10
		vtEM4D_Body:=Replace string:C233(vtEM4D_Body;"\r\r\r";"\r\r")
		hmFree_TEXT2ARRAY ($text;aText1;$width;"Tahoma";9;0)
		
		
		vtEM4D_Body:="El "+vt_DTS+" "+vt_FROM+" escribió:\r\r"
		For ($i;1;Size of array:C274($aText))
			vtEM4D_Body:=vtEM4D_Body+">"+$aText{$i}
		End for 
		
		GOTO OBJECT:C206(vtEM4D_Body)
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 