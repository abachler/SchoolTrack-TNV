//%attributes = {}
  //ACTcfgmyt_CargaArreglos

ARRAY TEXT:C222(atACT_BankID;0)
ARRAY TEXT:C222(atACT_BankName;0)
ARRAY LONGINT:C221(alACT_BankRecNum;0)
ARRAY BOOLEAN:C223(abACT_BankEstandar;0)
ARRAY BOOLEAN:C223(abACT_BankModified;0)
ARRAY TEXT:C222(atACT_BankNumConvenio;0)
READ ONLY:C145([xxACT_Bancos:129])
QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Pais:3=<>vtXS_CountryCode)
SELECTION TO ARRAY:C260([xxACT_Bancos:129]Nombre:1;atACT_BankName;[xxACT_Bancos:129]Codigo:2;atACT_BankID;[xxACT_Bancos:129]Estandar:4;abACT_BankEstandar;[xxACT_Bancos:129]mx_NumeroConvenio:5;atACT_BankNumConvenio)
LONGINT ARRAY FROM SELECTION:C647([xxACT_Bancos:129];alACT_BankRecNum;"")
ARRAY BOOLEAN:C223(abACT_BankModified;Size of array:C274(alACT_BankRecNum))