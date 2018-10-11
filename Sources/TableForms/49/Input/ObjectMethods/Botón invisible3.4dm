vtSTR_RUT:=vsPST_RUTFATHER
vtSTR_IDNAcional2:=vsPST_IDN2FATHER
vtSTR_IDNAcional3:=vsPST_IDN3FATHER
vtSTR_Pasaporte:=vsPST_PasFATHER
vtSTR_CodigoInterno:=vsPST_CodFATHER

vsPST_Persona:="father"

WDW_OpenPopupWindow (Self:C308;->[ADT_Candidatos:49];"CustomIds";2)
DIALOG:C40([ADT_Candidatos:49];"CustomIds")
CLOSE WINDOW:C154

vsPST_RUTFATHER:=vtSTR_RUT
vsPST_IDN2FATHER:=vtSTR_IDNAcional2
vsPST_IDN3FATHER:=vtSTR_IDNAcional3
vsPST_PasFATHER:=vtSTR_Pasaporte
vsPST_CodFATHER:=vtSTR_CodigoInterno

PST_UpdateParents ("father")
ADTcdd_SetIdentificadorPrincipa 