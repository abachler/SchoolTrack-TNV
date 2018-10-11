//%attributes = {}
  //ACTcfg_LoadBancos

If (Count parameters:C259=1)
	$country:=$1
Else 
	$country:=<>vtXS_CountryCode
End if 
ARRAY TEXT:C222(atACT_BankID;0)
ARRAY TEXT:C222(atACT_BankName;0)
READ ONLY:C145([xxACT_Bancos:129])
QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Pais:3=$country)
SELECTION TO ARRAY:C260([xxACT_Bancos:129]Nombre:1;atACT_BankName;[xxACT_Bancos:129]Codigo:2;atACT_BankID)
SORT ARRAY:C229(atACT_BankName;atACT_BankID;>)

ARRAY TEXT:C222(<>atACT_BankName;0)
COPY ARRAY:C226(atACT_BankName;<>atACT_BankName)