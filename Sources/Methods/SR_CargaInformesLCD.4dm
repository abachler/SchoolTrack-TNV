//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 23-03-18, 16:20:09
  // ----------------------------------------------------
  // Método: SR_CargaInformesLCD
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_LONGINT:C283($i;$l_therm)
C_TEXT:C284($t_uuid)

ARRAY TEXT:C222($at_informesUUID;0)

READ ONLY:C145([xShell_Reports:54])
If (<>gCountryCode="cl")
	$l_therm:=IT_UThermometer (1;0;"Descargando reportes LCD...")
	APPEND TO ARRAY:C911($at_informesUUID;"35D2EF9C4F544CE089F8D36CC522F5E5")
	APPEND TO ARRAY:C911($at_informesUUID;"0F1B8ECEE6F047F3B6FF1CEE7D88E9FE")
	APPEND TO ARRAY:C911($at_informesUUID;"0B94166FBA6E46F4833197B5D007B181")
	APPEND TO ARRAY:C911($at_informesUUID;"DD1F305D1A794D2993BA22070EE2B976")
	APPEND TO ARRAY:C911($at_informesUUID;"186DC9619CAF46EB8C139C1F486DD224")
	APPEND TO ARRAY:C911($at_informesUUID;"7ED626B0DC5F44AE9A0AE6F53F62CA2D")
	APPEND TO ARRAY:C911($at_informesUUID;"D43CCEB705C97A47848E94A54BB16C63")
	  //APPEND TO ARRAY($at_informesUUID;"5E6738BD777742B996B7DC4279081F18")//ABC//211338 // por cambio d einforme en repositorio
	For ($i;1;Size of array:C274($at_informesUUID))
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47=$at_informesUUID{$i})
		If (Records in selection:C76([xShell_Reports:54])=0)
			$t_uuid:=RIN_RefUltimaVersion ($at_informesUUID{$i})
			RIN_DescargaActualizacion ($t_uuid)
		End if 
	End for 
	IT_UThermometer (-2;$l_therm)
End if 