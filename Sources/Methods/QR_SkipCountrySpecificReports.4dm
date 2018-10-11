//%attributes = {}
  // Método: QR_SkipCountrySpecificReports
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 02/11/09, 20:49:43
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones



$countryLangage:=SYS_GetDefaultCountryLangage 

If (vtMAN_CurrCountry#"all")
	If (vtMAN_CurrCountry=<>vtXS_CountryCode)
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]CountryCode:1=vtMAN_CurrCountry;*)
		QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]CountryCode:1="";*)
		QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]EnRepositorio:48=False:C215)
	Else 
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]CountryCode:1=vtMAN_CurrCountry)
	End if 
End if 
If (vtMAN_CurrLang#"all")
	If ($countryLangage=vtMAN_CurrLang)
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]LangageCode:10=vtMAN_CurrLang;*)
		QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]LangageCode:10=<>vtXS_langage;*)
		QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]LangageCode:10="")
	Else 
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]LangageCode:10=vtMAN_CurrLang)
	End if 
End if 