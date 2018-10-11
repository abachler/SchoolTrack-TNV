ARRAY TEXT:C222(at_FileName;0)
ARRAY LONGINT:C221(al_idsBankFiles;0)
READ ONLY:C145([xxACT_ArchivosBancarios:118])
QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=True:C214)
QUERY SELECTION WITH ARRAY:C1050([xxACT_ArchivosBancarios:118]id_forma_de_pago:13;alACT_FormasdePagoID)
If (bto_Exportacion=1)
	QUERY SELECTION:C341([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ImpExp:5=False:C215)
Else 
	QUERY SELECTION:C341([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ImpExp:5=True:C214)
End if 
SELECTION TO ARRAY:C260([xxACT_ArchivosBancarios:118]Nombre:3;at_FileName;[xxACT_ArchivosBancarios:118]ID:1;al_idsBankFiles)
_O_ENABLE BUTTON:C192(bModeloTB)
OBJECT SET VISIBLE:C603(bModeloTB;True:C214)  //imagen pop up