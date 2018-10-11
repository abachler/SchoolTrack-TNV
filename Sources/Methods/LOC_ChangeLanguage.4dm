//%attributes = {}
  // LOC_ChangeLanguage()
  // Por: Alberto Bachler K.: 10-08-15, 10:01:27
  //  ---------------------------------------------
  // normalización de código de JHB
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($t_codigoLenguaje;$t_codigoPais;$t_RefLocalizacion)
ARRAY LONGINT:C221($al_ElementosEncontrados;0)
ARRAY TEXT:C222($at_DocumentosLocalizacion;0)



If (False:C215)
	C_TEXT:C284(LOC_ChangeLanguage ;$1)
	C_TEXT:C284(LOC_ChangeLanguage ;$2)
End if 

Case of 
	: (Count parameters:C259=2)
		$t_codigoLenguaje:=$1
		$t_codigoPais:=$2
	: (Count parameters:C259=1)
		$t_codigoLenguaje:=$1
		$t_codigoPais:=<>vtXS_CountryCode
	: (Count parameters:C259=0)
		$t_codigoLenguaje:=<>vtXS_langage
		$t_codigoPais:=<>vtXS_CountryCode
	Else 
		$t_codigoPais:=<>vtXS_CountryCode
End case 

$t_RefLocalizacion:=LOC_ObtieneReferencia ($t_codigoLenguaje;$t_codigoPais)

If ($t_RefLocalizacion#"")
	SET DATABASE LOCALIZATION:C1104($t_RefLocalizacion)
	<>vtXS_langage:=$t_codigoLenguaje
	LOC_LoadFixedLocalizedStrings 
End if 