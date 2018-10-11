//%attributes = {}
  // Licencia_ListaMacAddress()
  // Por: Alberto Bachler K.: 29-08-14, 12:03:41
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



_O_ARRAY STRING:C218(12;<>aMacAddress;0)
ARRAY TEXT:C222($at_direccionesMAC;0)
$t_MacPrincipal:=SYS_GetServerMAC (->$at_direccionesMAC)

If (Size of array:C274($at_direccionesMAC)>0)
	$t_MAC:=Replace string:C233($t_MacPrincipal;":";"")
	$t_MAC:=Substring:C12($t_MAC;1;12)
	If (($t_MAC#"") & (Find in array:C230(<>aMacAddress;$t_MAC)=-1))
		APPEND TO ARRAY:C911(<>aMacAddress;$t_MAC)
	End if 
	For ($i;1;Size of array:C274($at_direccionesMAC))
		$t_MAC:=Replace string:C233($at_direccionesMAC{$i};":";"")
		$t_MAC:=Substring:C12($t_MAC;1;12)
		If (($t_MAC#"") & (Find in array:C230(<>aMacAddress;$t_MAC)=-1))
			APPEND TO ARRAY:C911(<>aMacAddress;$t_MAC)
		End if 
	End for 
	<>vtXS_MacAddress:=<>aMacAddress{1}
Else 
	<>vtXS_MacAddress:=""
	ALERT:C41("No se detectó ninguna interfaz de red.")
End if 



