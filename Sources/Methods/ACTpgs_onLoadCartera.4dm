//%attributes = {}
  //ACTpgs_onLoadCartera

QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)

QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Documentos_de_Pago:176]ID_Apoderado:2)

vsUbicacion:=[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8

Case of 
		
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-4)
		
		OBJECT SET VISIBLE:C603(*;"ChequeLetra@";True:C214)
		FORM GOTO PAGE:C247(1)
		
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-6)
		
		OBJECT SET VISIBLE:C603(*;"ChequeLetra@";False:C215)
		FORM GOTO PAGE:C247(3)
		
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-8)
		
		OBJECT SET VISIBLE:C603(*;"ChequeLetra@";True:C214)
		FORM GOTO PAGE:C247(2)
		
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-7)
		
		OBJECT SET VISIBLE:C603(*;"ChequeLetra@";False:C215)
		FORM GOTO PAGE:C247(4)
		
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-3)
		
		OBJECT SET VISIBLE:C603(*;"ChequeLetra@";False:C215)
		FORM GOTO PAGE:C247(5)
		
End case 
