  // [xShell_Reports].EnvioRepositorio.idioma()
  // Por: Alberto Bachler K.: 14-08-14, 13:17:16
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($l_indexIdioma)
C_TEXT:C284($t_Idioma)

$l_indexIdioma:=Find in array:C230(<>atXS_IdiomasCodigos;[xShell_Reports:54]LangageCode:10)
If ($l_indexIdioma>0)
	$t_Idioma:=<>atXS_IdiomasNombres{$l_indexIdioma}
End if 

$t_Idioma:=Choose:C955([xShell_Reports:54]LangageCode:10="";__ ("Todos");$t_Idioma)
$t_codigoIdioma:=Dynamic pop up menu:C1006(<>vmenu_Idiomas;$t_Idioma)
If ($t_codigoIdioma#"")
	[xShell_Reports:54]LangageCode:10:=$t_codigoIdioma
	$l_indexIdioma:=Find in array:C230(<>atXS_IdiomasCodigos;[xShell_Reports:54]LangageCode:10)
	If ($l_indexIdioma>0)
		$t_Idioma:=<>atXS_IdiomasNombres{$l_indexIdioma}
	End if 
	OBJECT SET TITLE:C194(*;"Idioma";$t_Idioma)
	IT_PropiedadesBotonPopup ("idioma";$t_Idioma;160)
End if 
