//%attributes = {}
  // Método: SYS_GetDefaultCountryLangage
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 13/10/10, 13:26:36
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($region)

  // Código principal
If (Count parameters:C259=1)
	$region:=$1
End if 


Case of 
	: ((<>vtXS_CountryCode="cl") | (<>vtXS_CountryCode="mx") | (<>vtXS_CountryCode="pe") | (<>vtXS_CountryCode="ar") | (<>vtXS_CountryCode="co") | (<>vtXS_CountryCode="ve") | (<>vtXS_CountryCode="sp"))
		$countryLangage:="es"
		
	: ((<>vtXS_CountryCode="ph") | (<>vtXS_CountryCode="ie") | (<>vtXS_CountryCode="us") | (<>vtXS_CountryCode="uk"))
		$countryLangage:="en"
		
	: (<>vtXS_CountryCode="fr")
		
	: (<>vtXS_CountryCode="ca")
		Case of 
			: ($region="quebec")
				$countryLangage:="fr"
			Else 
				$countryLangage:="en"
		End case 
		
		
	: (<>vtXS_CountryCode="br")
		$countryLangage:="pt"
		
End case 


$0:=$countryLangage

