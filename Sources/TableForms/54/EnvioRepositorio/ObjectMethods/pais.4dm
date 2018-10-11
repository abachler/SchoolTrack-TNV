  // [xShell_Reports].EnvioRepositorio.pais()
  // Por: Alberto Bachler K.: 13-08-14, 12:03:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_indexPais)
C_TEXT:C284($t_pais)

$t_codigoPais:=Dynamic pop up menu:C1006(<>vmenu_paises)
If ($t_codigoPais#"")
	[xShell_Reports:54]CountryCode:1:=$t_codigoPais
End if 

If ([xShell_Reports:54]CountryCode:1#"")
	$l_indexPais:=Find in array:C230(<>atXS_PaisesCodigos;[xShell_Reports:54]CountryCode:1)
	IT_PropiedadesBotonPopup ("pais";<>atXS_PaisesNombres{$l_indexPais}+(" "*5);305)
Else 
	$l_indexPais:=Find in array:C230(<>atXS_PaisesCodigos;"All")
	IT_PropiedadesBotonPopup ("pais";__ ("Cualquier país")+(" "*5);400)
End if 
GET PICTURE FROM LIBRARY:C565(<>alXS_PaisesIconos{$l_indexPais};vBanderaPAIS)

