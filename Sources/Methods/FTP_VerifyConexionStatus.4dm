//%attributes = {}
  // MÉTODO: FTP_VerifyConexionStatus
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 27/06/11, 11:56:26
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // FTP_VerifyConexionStatus()
  // ----------------------------------------------------
C_LONGINT:C283($l_ConnexID;$l_error;$l_Passive)
C_POINTER:C301($y_connectionID)
C_TEXT:C284($t_login;$t_password;$t_url)


  // CODIGO PRINCIPAL
$l_ConnexID:=$1
$t_url:=$2
$t_login:=$3
$t_password:=$4
$y_connectionID:=$5
$l_passive:=1

If (Count parameters:C259=6)
	$l_Passive:=$6
End if 

$l_error:=FTP_VerifyID ($l_ConnexID)
If ($l_error#0)
	$l_error:=FTP_Login ($t_url;$t_login;$t_password;$l_ConnexID)
	If ($l_error#0)
		CD_Dlog (0;__ ("No fue posible establecer la conexión con el servidor FTP.\r\rPor favor verifique el estado de su conexión Internet."))
	Else 
		  // MOD Ticket N° 196415 20180203 Patricio Aliaga
		  //$l_error:=FTP_SetPassive ($l_ConnexID;1)  //20170520 RCH. Se cambia a pedido de JHB
		$l_error:=FTP_SetPassive ($l_ConnexID;$l_Passive)
		$y_connectionID->:=$l_ConnexID
	End if 
End if 
$0:=$l_error