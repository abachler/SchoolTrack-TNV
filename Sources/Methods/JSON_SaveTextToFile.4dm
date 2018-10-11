//%attributes = {}
  // JSON_SaveTextToFile()
  // utilizado solo para depuracion actualmente (20160127)
  //
  // creado por: Alberto Bachler Klein: 25-11-15, 12:44:31
  // -----------------------------------------------------------




C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_parametrosEnObjeto)
C_LONGINT:C283($i;$l_error;$l_target)
C_POINTER:C301($y_parameter)
C_TEXT:C284($t_JSON;$t_metodoONErrorActual;$t_ruta;$t_rutaCarpeta)
C_OBJECT:C1216($ob_Error;$ob_parametros;$ob_resultado)


If (False:C215)
	C_LONGINT:C283(JSON_SaveTextToFile ;$0)
	C_TEXT:C284(JSON_SaveTextToFile ;$1)
	C_TEXT:C284(JSON_SaveTextToFile ;$2)
	C_LONGINT:C283(JSON_SaveTextToFile ;$3)
End if 

If (Count parameters:C259=2)
	$t_ruta:=$1
	$t_JSON:=$2
	$t_metodoONErrorActual:=Method called on error:C704
	ON ERR CALL:C155("ERR_EventoError")
	If (Test path name:C476($t_ruta)#Is a document:K24:1)
		$t_rutaCarpeta:=SYS_GetParentNme ($t_ruta)
		SYS_CreateFolder ($t_rutaCarpeta)
	End if 
	TEXT TO DOCUMENT:C1237($t_ruta;$t_JSON)
	ON ERR CALL:C155($t_metodoONErrorActual)
	$l_error:=error
Else 
	$l_error:=1
End if 

$0:=$l_error





