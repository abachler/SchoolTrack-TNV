//%attributes = {}
  // SN3_CheckNotColegium()
  // Por: Alberto Bachler K.: 21-10-14, 00:43:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_error)
C_TEXT:C284($t_infoRed;$t_nombreDominio;$t_nombreMaquina)

ARRAY TEXT:C222($at_infoRed;0)

C_BOOLEAN:C305(<>bXS_esServidorOficial)

If (SYS_IsWindows )
	$l_error:=sys_GetNetworkInfo ($t_infoRed)
	AT_Text2Array (->$at_infoRed;$t_infoRed;",")
	$t_nombreDominio:=$at_infoRed{2}
Else 
	$t_nombreDominio:=""
End if 
$t_nombreMaquina:=Current machine:C483


If (($t_nombreMaquina#"Colegium-@") & ($t_nombreDominio#"lester.colegium.com") & (Is compiled mode:C492) & (<>bXS_esServidorOficial))
	$0:=True:C214
Else 
	$0:=False:C215
End if 