C_LONGINT:C283($col;$line)
LISTBOX GET CELL POSITION:C971(LB_LenguaMaterna;$col;$line)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		If ($line>0)
			OBJECT SET ENABLED:C1123(*;"bRemoveIdioma";(Size of array:C274(a_LB_LenguaMaterna)>0))
		End if 
		
End case 