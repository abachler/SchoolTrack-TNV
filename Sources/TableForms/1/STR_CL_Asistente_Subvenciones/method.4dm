Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		OBJECT SET VISIBLE:C603(*;"nextPrev@";False:C215)
		vi_pageNumber:=1
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		
	: (Form event:C388=On Unload:K2:2)
		
End case 
