//%attributes = {}
  // SYS_CarpetaPreferenciasLocal()
  // 
  //
  // creado por: Alberto Bachler Klein: 02-11-16, 19:33:01
  // -----------------------------------------------------------


C_TEXT:C284($0)


If (False:C215)
	C_TEXT:C284(SYS_CarpetaPreferenciasLocal ;$0)
End if 

$0:=SYS_GetFolderNam (Get 4D folder:C485(Active 4D Folder:K5:10))+"Colegium"+Folder separator:K24:12+"Client"+Folder separator:K24:12
CREATE FOLDER:C475($0;*)
