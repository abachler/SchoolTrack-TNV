  // PictureManager()
  // 
  //
  // creado por: Alberto Bachler Klein: 02-09-16, 12:11:06
  // -----------------------------------------------------------



Case of 
	: (Form event:C388=On Load:K2:1)
		READ WRITE:C146([xShell_PictLibrary:194])
		ALL RECORDS:C47([xShell_PictLibrary:194])
		ORDER BY:C49([xShell_PictLibrary:194];[xShell_PictLibrary:194]numeroObjetos:10;<)
		FIRST RECORD:C50([xShell_PictLibrary:194])
		LISTBOX SELECT ROW:C912(*;"imagenes";1)
		OBJECT SET VISIBLE:C603(*;"ruta";[xShell_PictLibrary:194]Id_imagen:4=-1)
		OBJECT SET VISIBLE:C603(*;"id";[xShell_PictLibrary:194]Id_imagen:4>0)
		
	: (Form event:C388=On Load Record:K2:38)
		
	: (Form event:C388=On Activate:K2:9)
		
	: (Form event:C388=On Deactivate:K2:10)
		
	: (Form event:C388=On Page Change:K2:54)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Unload:K2:2)
		UNLOAD RECORD:C212([xShell_PictLibrary:194])
		READ ONLY:C145([xShell_PictLibrary:194])
		
	: (Form event:C388=On Close Box:K2:21)
		
End case 
