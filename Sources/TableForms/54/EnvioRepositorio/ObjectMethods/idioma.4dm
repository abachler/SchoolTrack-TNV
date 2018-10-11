  // [xShell_Reports].EnvioRepositorio.idioma()
  // Por: Alberto Bachler K.: 14-08-14, 13:17:16
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($l_indexIdioma)
C_TEXT:C284($t_Idioma)

$t_codigoIdioma:=Dynamic pop up menu:C1006(<>vmenu_Idiomas)
If ($t_codigoIdioma#"")
	[xShell_Reports:54]LangageCode:10:=$t_codigoIdioma
End if 

If ([xShell_Reports:54]LangageCode:10#"")
	$l_indexIdioma:=Find in array:C230(<>atXS_IdiomasCodigos;[xShell_Reports:54]LangageCode:10)
	IT_PropiedadesBotonPopup ("idioma";<>atXS_IdiomasNombres{$l_indexIdioma}+(" "*5);400)
Else 
	$l_indexIdioma:=Find in array:C230(<>atXS_IdiomasCodigos;"all")
	IT_PropiedadesBotonPopup ("idioma";__ ("Cualquier idioma")+(" "*5);400)
End if 
GET PICTURE FROM LIBRARY:C565(<>alXS_IdiomasIconos{$l_indexIdioma};vBanderaIdioma)
