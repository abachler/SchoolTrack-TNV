  // PropiedadesBD.webIpAddressList()
  // Por: Alberto Bachler K.: 25-09-15, 10:36:19
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_error;$l_ip)
C_POINTER:C301($y_IPAddresses;$y_webCurrentIPAddress)

$y_IPAddresses:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_webCurrentIPAddress:=OBJECT Get pointer:C1124(Object named:K67:5;"webCurrentIPAddress")

If ($y_IPAddresses->=Size of array:C274($y_IPAddresses->))
	$y_webCurrentIPAddress->:=0
Else 
	$l_error:=NET_NameToAddr ($y_IPAddresses->{$y_IPAddresses->};$l_ip)
	$y_webCurrentIPAddress->:=$l_ip
End if 

OBJECT SET ENABLED:C1123(*;"btnGuardar";True:C214)