//%attributes = {"executedOnServer":true}
  // BKP_InfoUltimoRespaldo()
  // Por: Alberto Bachler K.: 02-04-15, 11:07:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)

C_DATE:C307($d_fechaProximoRespaldo;$d_fechaUltimoRespaldo)
C_LONGINT:C283($l_statusRespaldo)
C_TIME:C306($h_horaProximoRespaldo;$h_horaUltimoRespaldo)
C_TEXT:C284($t_json;$t_refJson;$t_statusRespaldo;$t_texto)


If (False:C215)
	C_TEXT:C284(BKP_InfoUltimoRespaldo ;$0)
End if 

GET BACKUP INFORMATION:C888(Last backup date:K54:1;$d_fechaUltimoRespaldo;$h_horaUltimoRespaldo)
GET BACKUP INFORMATION:C888(Next backup date:K54:3;$d_fechaProximoRespaldo;$h_horaProximoRespaldo)
GET BACKUP INFORMATION:C888(Last backup status:K54:2;$l_statusRespaldo;$t_statusRespaldo)
Case of 
	: (($l_statusRespaldo=0) | ($l_statusRespaldo=1406) & ($d_fechaUltimoRespaldo#!00-00-00!))
		$t_texto:=__ ("Último respaldo: ^0")
		$t_texto:=$t_texto+"\r\r"+__ ("Próximo respaldo: ")+String:C10($d_fechaProximoRespaldo;Internal date long:K1:5)+" a las "+String:C10($h_horaProximoRespaldo;HH MM:K7:2)
	: (($l_statusRespaldo=0) & ($d_fechaUltimoRespaldo=!00-00-00!))
		$t_texto:=__ ("Último respaldo: Ninguno")
		$t_texto:=$t_texto+"\r"+__ ("Próximo respaldo: ")+String:C10($d_fechaProximoRespaldo;Internal date long:K1:5)+" a las "+String:C10($h_horaProximoRespaldo;HH MM:K7:2)
	Else 
		$t_texto:=__ ("El último respaldo iniciado el ^0 no se efectuó a causa del error Nº ^1:\r\"^2\"")
		$t_texto:=$t_texto+"\r\r"+__ ("Próximo respaldo: ")+String:C10($d_fechaProximoRespaldo;Internal date long:K1:5)+", "+String:C10($h_horaProximoRespaldo;HH MM:K7:2)
End case 
$t_texto:=Replace string:C233($t_texto;"^0";String:C10($d_fechaUltimoRespaldo;Internal date long:K1:5)+__ (" a las ")+String:C10($h_horaUltimoRespaldo;HH MM:K7:2))
$t_texto:=Replace string:C233($t_texto;"^1";String:C10($l_statusRespaldo))
$t_texto:=Replace string:C233($t_texto;"^2";$t_statusRespaldo)



$0:=$t_texto