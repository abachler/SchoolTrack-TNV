//%attributes = {}
  //USR_ALERT_UserHasNoRights

C_LONGINT:C283($r)
Case of 
	: ($1=0)
		CD_Dlog (0;__ ("Lo siento, Ud. no dispone de la autorización necesaria para acceder a la información solicitada."))
	: ($1=1)
		CD_Dlog (0;__ ("Lo siento,  acceso autorizado sólo para consulta."))
	: ($1=2)
		CD_Dlog (0;__ ("Lo siento, Ud. no dispone de la autorización necesaria para agregar información a este archivo."))
	: ($1=3)
		CD_Dlog (0;__ ("Lo siento, Ud. no dispone de la autorización necesaria para borrar informaciones de este archivo."))
	: ($1=4)
		CD_Dlog (0;__ ("Lo siento, Ud. no está autorizado para utilizar esta función."))
End case 