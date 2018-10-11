//%attributes = {"executedOnServer":true}
  // SYS_NombreVolumen_Servidor()
  // Por: Alberto Bachler K.: 03-09-14, 14:59:20
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($t_ruta;$t_volumen)


If (False:C215)
	C_TEXT:C284(SYS_NombreVolumen_Servidor ;$0)
	C_TEXT:C284(SYS_NombreVolumen_Servidor ;$1)
End if 

$t_ruta:=$1

Case of 
	: ((SYS_IsWindows ) & ($t_ruta="@:\\@"))
		$t_volumen:=Substring:C12($t_ruta;1;3)
	: (SYS_IsMacintosh ) & ($t_ruta=":@")
		$t_volumen:=Replace string:C233(SYS_GetFolderNam (Data file:C490)+$t_ruta;"::";":")
		$t_volumen:=ST_GetWord ($t_volumen;1;Folder separator:K24:12)
	: (SYS_IsMacintosh )
		$t_volumen:=ST_GetWord ($t_ruta;1;Folder separator:K24:12)
	: (SYS_IsWindows ) & ($t_ruta="\\@")
		$t_volumen:=Replace string:C233(SYS_GetFolderNam (Data file:C490)+$t_ruta;"\\\\";"\\")
		$t_volumen:=Substring:C12($t_volumen;1;3)
	Else 
		TRACE:C157
End case 

$0:=$t_volumen