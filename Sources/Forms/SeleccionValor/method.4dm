  // SeleccionValor()
  // Por: Alberto Bachler K.: 11-02-15, 18:23:32
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($l_var)

Case of 
	: (Form event:C388=On Load:K2:1)
		LISTBOX SET TABLE SOURCE:C1013(*;"lb_lista";"$seleccionPredictivo";"$seleccionCampo")
		LISTBOX DELETE COLUMN:C830(*;"lb_lista";1)
		LISTBOX INSERT COLUMN:C829(*;"lb_lista";1;"campo";vy_CampoSeleccion->;"encabezado";$l_var)
		HIGHLIGHT TEXT:C210(vt_textoBuscado;MAXLONG:K35:2;MAXLONG:K35:2)
		(OBJECT Get pointer:C1124(Object named:K67:5;"largoTextoEditado"))->:=Length:C16(vt_textoBuscado)+1
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Deactivate:K2:10)
		vt_TextoBuscado:=""
		CANCEL:C270
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 
