Case of 
	: (Form event:C388=On Header:K2:17)
		vPPage:="Página "+String:C10(Printing page:C275)
	: (Form event:C388=On Printing Detail:K2:18)
		QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=[ACT_Matrices:177]ID:1)
		KRL_RelateSelection (->[xxACT_Items:179]ID:1;->[xxACT_ItemsMatriz:180]ID_Item:2;"")
End case 