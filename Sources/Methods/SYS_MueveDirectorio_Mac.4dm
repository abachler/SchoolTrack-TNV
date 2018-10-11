//%attributes = {}
  // SYS_MueveDirectorio_Mac()
  // Por: Alberto Bachler: 11/07/13, 09:11:57
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_TEXT:C284($1;$t_rutaOrigen;$t_rutaDestino;$t_errorEjecucion)
If (Count parameters:C259=2)
	$t_rutaOrigen:=$1
	$t_rutaDestino:=$2
End if 

$t_rutaOrigen:=LEP_Escape_path ($t_rutaOrigen)
$t_rutaDestino:=LEP_Escape_path ($t_rutaDestino)

Case of 
	: (SYS_IsMacintosh )
		$t_comando:="mv "+$t_rutaOrigen+" "+$t_rutaDestino
		$b_Exito:=LEP_EjecutaComando ($t_comando;->$t_errorEjecucion)
		
	: (SYS_IsWindows )
		  // 
End case 
