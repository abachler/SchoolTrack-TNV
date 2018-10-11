//%attributes = {"executedOnServer":true}
  // SYS_CreaCarpetaServidor(rutaCarpeta:&T)
  // Por: Alberto Bachler K.: 21-10-14, 11:18:49
  //  ---------------------------------------------
  // Crea la ruta pasada en rutaCarpetas en el servidor
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($t_rutaCarpeta)


If (False:C215)
	C_TEXT:C284(SYS_CreaCarpetaServidor ;$1)
End if 


$t_rutaCarpeta:=$1
If (Test path name:C476($t_rutaCarpeta)#Is a folder:K24:2)
	SYS_CreaCarpeta ($t_rutaCarpeta)
End if 


