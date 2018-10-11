//%attributes = {}
  // SYS_GetRegionalSettings()
  // Por: Alberto Bachler: 05/03/13, 18:57:45
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($t_formatoFecha)


GET SYSTEM FORMAT:C994(Decimal separator:K60:1;<>tXS_RS_DecimalSeparator)
GET SYSTEM FORMAT:C994(Thousand separator:K60:2;<>tXS_RS_ThousandsSeparator)
GET SYSTEM FORMAT:C994(System date short pattern:K60:7;$t_formatoFecha)
GET SYSTEM FORMAT:C994(Date separator:K60:10;<>tXS_RS_DateSeparator)
<>tXS_RS_DateFormat:=Uppercase:C13(Replace string:C233($t_formatoFecha;<>tXS_RS_DateSeparator;"/"))
