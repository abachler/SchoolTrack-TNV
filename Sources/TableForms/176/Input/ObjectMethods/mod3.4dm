[ACT_Documentos_en_Cartera:182]Fecha_Doc:5:=[ACT_Documentos_de_Pago:176]Fecha:13
  //[ACT_Documentos_en_Cartera]Fecha_Vencimiento:=[ACT_Documentos_en_Cartera]Fecha_Doc+60
Case of   //20140522 RCH Cambios según ticket 132961
	: (<>gCountryCode="ar")
		[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5+30
	: (<>gCountryCode="co")
		[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5+30
	Else 
		[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5+60
End case 