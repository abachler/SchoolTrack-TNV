  // [xShell_PictLibrary].listbox.List Box()
  //
  //
  // creado por: Alberto Bachler Klein: 30-08-16, 09:50:16
  // -----------------------------------------------------------
C_LONGINT:C283($l_columna;$l_fila)


Case of 
	: (Form event:C388=On Selection Change:K2:29)
		LISTBOX GET CELL POSITION:C971(*;"imagenes";$l_columna;$l_fila)
		READ WRITE:C146([xShell_PictLibrary:194])
		GOTO SELECTED RECORD:C245([xShell_PictLibrary:194];$l_fila)
		
		OBJECT SET VISIBLE:C603(*;"ruta";[xShell_PictLibrary:194]Id_imagen:4=-1)
		OBJECT SET VISIBLE:C603(*;"id";[xShell_PictLibrary:194]Id_imagen:4>0)
		
	: ((Form event:C388=On Clicked:K2:4) & (Contextual click:C713))
		$l_accion:=Pop up menu:C542("Eliminar")
		If ($l_accion=1)
			LISTBOX GET CELL POSITION:C971(*;"imagenes";$l_columna;$l_fila)
			READ WRITE:C146([xShell_PictLibrary:194])
			GOTO SELECTED RECORD:C245([xShell_PictLibrary:194];$l_fila)
			
			Case of 
				: (([xShell_PictLibrary:194]rutaExterna:9#"") & ([xShell_PictLibrary:194]Id_imagen:4<0))
					$t_ruta:=Get 4D folder:C485(Database folder:K5:14)+Replace string:C233([xShell_PictLibrary:194]rutaExterna:9;"/";Folder separator:K24:12)
					If (Test path name:C476($t_ruta)=Is a document:K24:1)
						DELETE DOCUMENT:C159($t_ruta)
					End if 
				: ([xShell_PictLibrary:194]Id_imagen:4>0)
					REMOVE PICTURE FROM LIBRARY:C567([xShell_PictLibrary:194]Id_imagen:4)
			End case 
			DELETE RECORD:C58([xShell_PictLibrary:194])
			
			READ ONLY:C145([xShell_PictLibrary:194])
			ALL RECORDS:C47([xShell_PictLibrary:194])
			ORDER BY:C49([xShell_PictLibrary:194];[xShell_PictLibrary:194]numeroObjetos:10;<)
			GOTO SELECTED RECORD:C245([xShell_PictLibrary:194];$l_fila)
			LISTBOX SELECT ROW:C912(*;"imagenes";$l_fila)
			
		End if 
End case 
