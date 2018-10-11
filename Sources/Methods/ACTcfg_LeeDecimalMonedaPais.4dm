//%attributes = {}
  //ACTcfg_LeeDecimalMonedaPais

  //20141118 RCH
C_TEXT:C284($t_key)
C_TEXT:C284(<>vtACT_monedaPais)
C_LONGINT:C283(<>vlACT_decimalesMonedaPais)
<>vtACT_monedaPais:=ST_GetWord (ACT_DivisaPais ;1;";")
$t_key:=<>gCountryCode+"."+<>vtACT_monedaPais
<>vlACT_decimalesMonedaPais:=KRL_GetNumericFieldData (->[xxACT_Monedas:146]Key:10;->$t_key;->[xxACT_Monedas:146]Numero_Decimales:8)