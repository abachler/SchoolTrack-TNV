  // SeleccionValor.lb_lista()
  // Por: Alberto Bachler K.: 12-02-15, 11:53:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Selection Change:K2:29))
		GOTO OBJECT:C206(vt_textoBuscado)
		POST KEY:C465(Character code:C91("*");Command key mask:K16:1)
		
	: (Form event:C388=On Double Clicked:K2:5)
		GOTO OBJECT:C206(vt_textoBuscado)
		POST KEY:C465(Character code:C91("*");Command key mask:K16:1)
		ACCEPT:C269
End case 