//%attributes = {}
  //USR_NO RIGHT MSG

C_LONGINT:C283($r)
Case of 
	: ($1=0)
		$m:="Ud. no dispone de la autorización necesaria para acceder a la información"+" solicitada"
	: ($1=1)
		$m:="Acceso autorizado sólo para consulta."
	: ($1=2)
		$m:="Ud. no dispone de la autorización necesaria para agregar información a este "+"archivo."
	: ($1=3)
		$m:="Ud. no dispone de la autorización necesaria para borrar informaciones de este "+"archivo."
	: ($1=4)
		$m:="Ud. no está autorizado para utilizar esta función."
End case 
$r:=CD_Dlog (1;$m)