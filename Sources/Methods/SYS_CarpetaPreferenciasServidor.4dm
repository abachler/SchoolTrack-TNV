//%attributes = {"executedOnServer":true}
  // SYS_CarpetaPreferenciasServidor()
  // 
  //
  // creado por: Alberto Bachler Klein: 02-11-16, 19:31:46
  // -----------------------------------------------------------
C_TEXT:C284($0)


If (False:C215)
	C_TEXT:C284(SYS_CarpetaPreferenciasServidor ;$0)
End if 

$0:=SYS_GetFolderNam (Get 4D folder:C485(Active 4D Folder:K5:10))+"Colegium"+Folder separator:K24:12+"Server"+Folder separator:K24:12
CREATE FOLDER:C475($0;*)


