ARRAY TEXT:C222($aCountryCodes;0)
ARRAY TEXT:C222($aLanguageCodes;0)
LIST TO ARRAY:C288("XS_CountryCodes";$aCountryCodes)
LIST TO ARRAY:C288("XS_LangageCodes";$aLanguageCodes)
$proc:=IT_UThermometer (1;0;__ ("Copiando a los otros países e idiomas..."))
For ($i;1;Size of array:C274($aCountryCodes))
	$country:=ST_GetWord ($aCountryCodes{$i};1;":")
	For ($j;1;Size of array:C274($aLanguageCodes))
		$langage:=ST_GetWord ($aLanguageCodes{$j};1;":")
		VS_SaveTableProperties ($country;$langage)
	End for 
End for 
IT_UThermometer (-2;$proc)