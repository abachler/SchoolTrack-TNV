  // PictureManager.Botón 3D()
  //
  //
  // creado por: Alberto Bachler Klein: 02-09-16, 11:47:26
  // -----------------------------------------------------------
C_LONGINT:C283($l_accion)

ARRAY LONGINT:C221($al_listRefs;0)
ARRAY TEXT:C222($at_listNames;0)

LIST OF CHOICE LISTS:C957($al_listRefs;$at_listNames)

If (Size of array:C274($al_listRefs)>0)
	$l_accion:=Pop up menu:C542("Analizar uso de imagenes;(-;Exportar librería…;Importar Librería…;(-;Recrear librería…")
Else 
	$l_accion:=Pop up menu:C542("(Analizar uso de imagenes;(-;Exportar librería…;Importar Librería…;(-;(Recrear librería…")
End if 

If ($l_accion>0)
	Case of 
		: ($l_accion=1)
			PICTLib_GetPictures 
			PICTLib_ReferencesInCode 
			
		: ($l_accion=3)
			PICTLib_ExportRecords 
			
		: ($l_accion=4)
			PICTLib_ImportRecords   //(Get 4D folder(Database folder)+"imagenesPictLib.txt")
			
		: ($l_accion=6)
			CONFIRM:C162("Las imagenes de la librería de imagenes 4D serán reemplazadas por las imagenes de esta lista\r\r¿Estás seguro?";"Cancelar";"OK")
			If (OK=0)
				PICTLib_Records2Library 
			End if 
	End case 
	
	READ ONLY:C145([xShell_PictLibrary:194])
	ALL RECORDS:C47([xShell_PictLibrary:194])
	ORDER BY:C49([xShell_PictLibrary:194];[xShell_PictLibrary:194]Id_imagen:4;>)
	FIRST RECORD:C50([xShell_PictLibrary:194])
	LISTBOX SELECT ROW:C912(*;"imagenes";1)
	OBJECT SET VISIBLE:C603(*;"ruta";[xShell_PictLibrary:194]Id_imagen:4=-1)
	OBJECT SET VISIBLE:C603(*;"id";[xShell_PictLibrary:194]Id_imagen:4>0)
End if 


