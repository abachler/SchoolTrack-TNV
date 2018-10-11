$evt:=Form event:C388

Case of 
	: ($evt=On Load:K2:1)
		ADTcdd_cargaObservaciones 
		xALP_Set_ADT_Observaciones 
		cb_mostrarUsuario:=1
	: ($evt=On Unload:K2:2)
		ADTcdd_SaveObservaciones 
End case 