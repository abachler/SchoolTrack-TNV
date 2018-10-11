ARRAY TEXT:C222(at_FileName;0)
ARRAY LONGINT:C221(al_idsBankFiles;0)
READ ONLY:C145([xxACT_ArchivosBancarios:118])
QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=True:C214;*)
If (bto_Exportacion=1)
	QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]ImpExp:5=False:C215;*)
	  //20121124 RCH Se pasa a ID
	QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]id_forma_de_pago:13=-17)  //Carga Archivos Bancarios
	  //QUERY([xxACT_ArchivosBancarios]; & ;[xxACT_ArchivosBancarios]Tipo="Contabilidad")  //Carga Archivos Bancarios
Else 
	  //los archivos se deben edita con la otra opcion...
	  //QUERY([xxACT_ArchivosBancarios]; & ;[xxACT_ArchivosBancarios]ImpExp=True)
	  //QUERY SELECTION([xxACT_ArchivosBancarios];[xxACT_ArchivosBancarios]Tipo="Cheque";*)  //Carga Archivos Bancarios
	  //QUERY SELECTION([xxACT_ArchivosBancarios]; | ;[xxACT_ArchivosBancarios]Tipo="Efectivo";*)
	  //QUERY SELECTION([xxACT_ArchivosBancarios]; | ;[xxACT_ArchivosBancarios]Tipo="Tarjeta de crédito")
End if 
SELECTION TO ARRAY:C260([xxACT_ArchivosBancarios:118]Nombre:3;at_FileName;[xxACT_ArchivosBancarios:118]ID:1;al_idsBankFiles)
_O_ENABLE BUTTON:C192(bModelosC)
OBJECT SET VISIBLE:C603(bModelosC;True:C214)  //imagen pop up