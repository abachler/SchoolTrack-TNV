  //$currCountry:=vtMAN_CurrCountry
  //$pais:=Dynamic pop up menu(<>vmenu_paises;$currCountry)
  //If ($pais#"")
  //If (vtMAN_CurrCountry#$pais)
  //$el:=Find in array(<>atXS_PaisesCodigos;$pais)
  //If ($el#-1)
  //GET PICTURE FROM LIBRARY(<>alXS_PaisesIconos{$el};vBanderaManPAIS)
  //Else 
  //vBanderaManPAIS:=vBanderaManPAIS*0
  //End if 
  //vtMAN_CurrCountry:=$pais
  //QR_BuildReportHList (atQR_Filter-1)
  //QR_GetReportsByType (vtQR_CurrentReportType)
  //QR_LoadSelectedReport 
  //End if 
  //End if 

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
	QR_BuildReportHList 
	QR_LoadSelectedReport 
End if 
