//%attributes = {}
  //LOC_ObtieneReferencia

C_TEXT:C284($t_codigoLenguaje;$t_codigoPais;$t_rutaXLIFF;$t_retorno)
ARRAY TEXT:C222($at_DocumentosLocalizacion;0)
C_TEXT:C284($t_nombreCarpeta;$t_RefLocalizacion;$t_nombreCarpetaAlternativa;$t_refLocalizacionAlternativa)
ARRAY LONGINT:C221($al_ElementosEncontrados;0)

  //20180320 RCH Hago cambios porque un colegio reporta problema. Ticket 199803
  //20180220 ASM Ticket 198543
If (<>gCountryCode="")
	STR_ReadGlobals 
End if 

If (Application type:C494=4D Server:K5:6)
	$t_codigoLenguaje:=SYS_GetDefaultCountryLangage 
	$t_codigoPais:=<>gCountryCode
Else 
	If (Count parameters:C259=2)
		$t_codigoLenguaje:=$1
		$t_codigoPais:=$2
	Else 
		$t_codigoLenguaje:=<>vtXS_langage
		$t_codigoPais:=<>gCountryCode
	End if 
End if 

If (($t_codigoLenguaje#"") & ($t_codigoPais#""))
	$t_rutaXLIFF:=Get 4D folder:C485(Current resources folder:K5:16)
	FOLDER LIST:C473($t_rutaXLIFF;$at_DocumentosLocalizacion)
	
	$t_nombreCarpeta:=$t_codigoLenguaje+"-"+$t_codigoPais+".lproj"
	$t_RefLocalizacion:=$t_codigoLenguaje+"-"+$t_codigoPais
	$t_nombreCarpetaAlternativa:=$t_codigoLenguaje+".lproj"
	$t_refLocalizacionAlternativa:=$t_codigoLenguaje
	$at_DocumentosLocalizacion{0}:=$t_nombreCarpeta
	AT_SearchArray (->$at_DocumentosLocalizacion;"=";->$al_ElementosEncontrados)
	If (Size of array:C274($al_ElementosEncontrados)=0)
		$at_DocumentosLocalizacion{0}:=$t_nombreCarpetaAlternativa
		AT_SearchArray (->$at_DocumentosLocalizacion;"=";->$al_ElementosEncontrados)
		If (Size of array:C274($al_ElementosEncontrados)=0)
			$t_retorno:=""
		Else 
			$t_retorno:=$t_refLocalizacionAlternativa
		End if 
	Else 
		$t_retorno:=$t_RefLocalizacion
	End if 
End if 
$0:=$t_retorno