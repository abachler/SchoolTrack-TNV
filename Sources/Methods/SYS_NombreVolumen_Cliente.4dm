//%attributes = {}
  // SYS_NombreVolumen_Cliente()
  // Por: Alberto Bachler K.: 03-09-14, 15:02:27
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($t_ruta;$t_rutaCarpetaRespaldos;$t_volumen)


If (False:C215)
	C_TEXT:C284(SYS_NombreVolumen_Servidor ;$0)
	C_TEXT:C284(SYS_NombreVolumen_Servidor ;$1)
End if 

$t_ruta:=$1

Case of 
	: ((SYS_IsWindows ) & ($t_rutaCarpetaRespaldos="@:\\@"))
		$t_volumen:=Substring:C12($t_rutaCarpetaRespaldos;1;3)
	: (SYS_IsMacintosh ) & ($t_rutaCarpetaRespaldos=":@")
		$t_volumen:=Replace string:C233(SYS_GetFolderNam (Data file:C490)+$t_rutaCarpetaRespaldos;"::";":")
		$t_volumen:=ST_GetWord ($t_volumen;1;Folder separator:K24:12)
	: (SYS_IsMacintosh )
		$t_volumen:=ST_GetWord ($t_rutaCarpetaRespaldos;1;Folder separator:K24:12)
	: (SYS_IsWindows ) & ($t_rutaCarpetaRespaldos="\\@")
		$t_volumen:=Replace string:C233(SYS_GetFolderNam (Data file:C490)+$t_rutaCarpetaRespaldos;"\\\\";"\\")
		$t_volumen:=Substring:C12($t_volumen;1;3)
	Else 
		TRACE:C157
End case 

$0:=$t_volumen