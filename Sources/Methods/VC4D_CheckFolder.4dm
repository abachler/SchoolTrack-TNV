//%attributes = {"shared":true,"executedOnServer":true}
  // VC4D_CheckFolder()
  //
  //
  // creado por: Alberto Bachler Klein: 01-02-16, 15:36:44
  // -----------------------------------------------------------
C_LONGINT:C283($l_resultado)
C_TEXT:C284($t_rutaCarpeta;$t_rutaVC4D)

$t_rutaCarpeta:=Get 4D folder:C485(Database folder:K5:14)+"VC4D"+Folder separator:K24:12+"VC4D Data"+Folder separator:K24:12
$l_resultado:=Test path name:C476($t_rutaCarpeta)
CREATE FOLDER:C475($t_rutaCarpeta;*)
$t_rutaVC4D:=$t_rutaCarpeta+"VC4D_database"

$0:=$t_rutaVC4D

