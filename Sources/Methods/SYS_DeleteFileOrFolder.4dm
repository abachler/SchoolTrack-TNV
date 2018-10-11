//%attributes = {}
  // SYS_DeleteFileOrFolder()
  // 
  //
  // creado por: Alberto Bachler Klein: 26-07-16, 18:45:40
  // -----------------------------------------------------------

C_TEXT:C284($1;$t_ruta)

$t_ruta:=$1

ON ERR CALL:C155("ERR_LogExecutionError")
Case of 
	: (Test path name:C476($t_ruta)=Is a document:K24:1)
		DELETE DOCUMENT:C159($t_ruta)
	: (Test path name:C476($t_ruta)=Is a folder:K24:2)
		DELETE FOLDER:C693($t_ruta)
End case 
ON ERR CALL:C155("")

