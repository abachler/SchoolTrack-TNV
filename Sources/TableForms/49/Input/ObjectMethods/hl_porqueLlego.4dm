ARRAY TEXT:C222($atPorqueLlego;0)

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		GET LIST ITEM:C378(Self:C308->;*;$ref;$text)
		  //leer el arreglo desde [ADT_Candidatos]Por_que_Eligio_Colegio
		AT_AppendItems2TextArray (->$atPorqueLlego;[ADT_Candidatos:49]Por_que_Eligio_Colegio:48)
		ADT_ActualizaPorqueLlego ($text;->$atPorqueLlego)
		$text:=AT_array2text (->$atPorqueLlego;";")
		[ADT_Candidatos:49]Por_que_Eligio_Colegio:48:=$text
End case 
