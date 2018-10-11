C_LONGINT:C283($col;$line)
LISTBOX GET CELL POSITION:C971(LB_TipoEva;$col;$line)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		If ($line>0)
			OBJECT SET ENABLED:C1123(*;"bRemoveTipoEVa";(Size of array:C274(a_LB_LenguaMaterna)>0))
		End if 
	: (Form event:C388=On Data Change:K2:15)
		
End case 