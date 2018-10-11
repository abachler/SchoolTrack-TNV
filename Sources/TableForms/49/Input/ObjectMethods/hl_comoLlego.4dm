ARRAY TEXT:C222($atComoLlego;0)

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		GET LIST ITEM:C378(Self:C308->;*;$ref;$text)
		  //leer el arreglo desde [ADT_Candidatos]Como_Llego_al_Colegio
		ADT_ActualizaComoLlego ($text)
		[ADT_Candidatos:49]Como_Llego_al_Colegio:47:=$text
End case 

