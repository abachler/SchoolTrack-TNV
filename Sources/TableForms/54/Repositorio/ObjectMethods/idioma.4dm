$y_Idioma:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoIdioma")
$t_codigoIdioma:=Dynamic pop up menu:C1006(<>vmenu_Idiomas;<>vtXS_langage)
If ($t_codigoIdioma#"")
	$l_indexIdioma:=Find in array:C230(<>atXS_IdiomasCodigos;$t_codigoIdioma)
	GET PICTURE FROM LIBRARY:C565(<>alXS_IdiomasIconos{$l_indexIdioma};vBanderaIdioma)
	IT_PropiedadesBotonPopup ("idioma";" ";120)
	$y_Idioma->:=<>atXS_IdiomasCodigos{$l_indexIdioma}
	If ($y_Idioma->="All")
		$y_Idioma->:=""
	End if 
End if 
RIN_BuscaInformes ("@"+vsearch+"@")
