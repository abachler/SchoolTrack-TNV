  // [xShell_Reports].EnvioRepositorio.pais()
  // Por: Alberto Bachler K.: 13-08-14, 12:03:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_indexPais)
C_TEXT:C284($t_pais)

$l_indexPais:=Find in array:C230(<>atXS_PaisesCodigos;[xShell_Reports:54]CountryCode:1)
If ($l_indexPais>0)
	$t_pais:=<>atXS_PaisesNombres{$l_indexPais}
End if 

$t_pais:=Choose:C955([xShell_Reports:54]CountryCode:1="";__ ("Todos");$t_pais)
$t_codigoPais:=Dynamic pop up menu:C1006(<>vmenu_paises;$t_pais)
If ($t_codigoPais#"")
	[xShell_Reports:54]CountryCode:1:=$t_codigoPais
	$l_indexPais:=Find in array:C230(<>atXS_PaisesCodigos;[xShell_Reports:54]CountryCode:1)
	If ($l_indexPais>0)
		$t_pais:=<>atXS_PaisesNombres{$l_indexPais}
	End if 
	OBJECT SET TITLE:C194(*;"pais";$t_pais)
	IT_PropiedadesBotonPopup ("pais";$t_pais;160)
End if 



