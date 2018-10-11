//%attributes = {}
  // PICTLib_ImportRecords()
  //
  //
  // creado por: Alberto Bachler Klein: 01-09-16, 11:08:49
  // -----------------------------------------------------------
C_TEXT:C284($t_rutaDocumento)

If (Count parameters:C259=1)
	$t_rutaDocumento:=$1
End if 
If (Test path name:C476($t_rutaDocumento)#Is a document:K24:1)
	$t_rutaDocumento:=""
End if 

ALL RECORDS:C47([xShell_PictLibrary:194])
KRL_DeleteSelection (->[xShell_PictLibrary:194])
IO_ImportRecords2OneTable (->[xShell_PictLibrary:194];$t_rutaDocumento)

ALL RECORDS:C47([xShell_PictLibrary:194])
ORDER BY:C49([xShell_PictLibrary:194];[xShell_PictLibrary:194]Nombre:2)


