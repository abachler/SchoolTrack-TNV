$y_pais:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoPais")
$t_codigoPais:=Dynamic pop up menu:C1006(<>vmenu_paises;<>vtXS_CountryCode)
If ($t_codigoPais#"")
	$l_indexPais:=Find in array:C230(<>atXS_PaisesCodigos;$t_codigoPais)
	GET PICTURE FROM LIBRARY:C565(<>alXS_PaisesIconos{$l_indexPais};vBanderaPAIS)
	IT_PropiedadesBotonPopup ("pais";" ";120)
	$y_pais->:=<>atXS_PaisesCodigos{$l_indexPais}
	If ($y_pais->="All")
		$y_pais->:=""
	End if 
	RIN_BuscaInformes ("@"+vsearch+"@")
End if 
