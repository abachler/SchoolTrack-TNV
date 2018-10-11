  //`xShell, Alberto Bachler

  //Metodo: Método de Objeto: hlQR_FieldList

  //Por abachler

  //Creada el 21/01/2004, 12:14:14

  //Modificaciones:

If ("DESCRIPCION"="")
	  //

End if 

  //****DECLARACIONES****



  //****INICIALIZACIONES****



  //****CUERPO****

Case of 
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($sourceObject;$sourceNumber;$sourceProcess)
		If ($sourceObject=(->hlQR_sortList))
			$0:=0
		Else 
			$0:=-1
		End if 
		
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($sourceObject;$sourceNumber;$sourceProcess)
		
		  //Allow the user to delete items from the Sort list by dragging them back.

		If ($sourceObject=(->hlQR_sortList))
			GET LIST ITEM:C378($sourceObject->;$sourceNumber;$itemRef;$itemText)
			DELETE FROM LIST:C624(hlQR_sortList;$itemRef)
			_O_REDRAW LIST:C382(hlQR_sortList)
			QR_SetSorts 
		End if 
End case 


  //****LIMPIEZA****

