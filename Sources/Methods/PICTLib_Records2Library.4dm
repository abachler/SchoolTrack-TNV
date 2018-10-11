//%attributes = {}
  // PICTLib_Records2Library()
  //
  //
  // creado por: Alberto Bachler Klein: 01-09-16, 11:50:47
  // -----------------------------------------------------------
C_LONGINT:C283($i_registros;$l_ProgressProcID)
C_POINTER:C301($y_tabla)

ARRAY LONGINT:C221($al_idImagenes;0)
ARRAY LONGINT:C221($al_recNum;0)
ARRAY TEXT:C222($at_nombreImagenes;0)

PICTLib_ClearLibrary 


ALL RECORDS:C47([xShell_PictLibrary:194])
$y_tabla:=->[xShell_PictLibrary:194]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNum)
$l_ProgressProcID:=Progress New 
Progress SET TITLE ($l_ProgressProcID;"Recreando librería de imágenes…")
For ($i_registros;1;Size of array:C274($al_recNum))
	GOTO RECORD:C242($y_tabla->;$al_recNum{$i_registros})
	If ([xShell_PictLibrary:194]rutaExterna:9#"")
		PICTLib_WritePictureFile ([xShell_PictLibrary:194]rutaExterna:9;[xShell_PictLibrary:194]pict:3)
	Else 
		SET PICTURE TO LIBRARY:C566([xShell_PictLibrary:194]pict:3;[xShell_PictLibrary:194]Id_imagen:4;[xShell_PictLibrary:194]Nombre:2)
	End if 
	Progress SET PROGRESS ($l_ProgressProcID;$i_registros/Size of array:C274($al_recNum);"Recreando librería de imágenes…\r"+[xShell_PictLibrary:194]Nombre:2)
End for 
Progress QUIT ($l_ProgressProcID)
UNLOAD RECORD:C212($y_tabla->)

PICTURE LIBRARY LIST:C564($al_idImagenes;$at_nombreImagenes)
