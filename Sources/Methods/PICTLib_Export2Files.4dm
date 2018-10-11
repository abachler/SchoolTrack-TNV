//%attributes = {}
  // PICTLib_Export2Files()
  //
  //
  // creado por: Alberto Bachler Klein: 02-09-16, 09:39:57
  // -----------------------------------------------------------
C_LONGINT:C283($i_registros;$l_ProgressProcID)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_nombreDoc;$t_ruta)

ARRAY LONGINT:C221($al_recNum;0)
ARRAY LONGINT:C221($al_recNums;0)

$t_ruta:=Get 4D folder:C485(Database folder:K5:14)+"exportImagenes"+Folder separator:K24:12
SYS_CreateFolder ($t_ruta)

ALL RECORDS:C47([xShell_PictLibrary:194])
LONGINT ARRAY FROM SELECTION:C647([xShell_PictLibrary:194];$al_recNums)


$y_tabla:=->[xShell_PictLibrary:194]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNum)
$l_ProgressProcID:=IT_Progress (1;0;0;"")
For ($i_registros;1;Size of array:C274($al_recNum))
	KRL_GotoRecord ($y_tabla;$al_recNum{$i_registros};False:C215)
	If (OK=1)
		$t_nombreDoc:=$t_ruta+String:C10([xShell_PictLibrary:194]Id_imagen:4)+"_"+[xShell_PictLibrary:194]Nombre:2
		WRITE PICTURE FILE:C680($t_nombreDoc;[xShell_PictLibrary:194]pict:3;".png")
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274($al_recNum);"")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)


