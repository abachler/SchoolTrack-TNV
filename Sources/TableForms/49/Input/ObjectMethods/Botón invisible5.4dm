vtSTR_RUT:=vsPST_RUTmother
vtSTR_IDNAcional2:=vsPST_IDN2mother
vtSTR_IDNAcional3:=vsPST_IDN3mother
vtSTR_Pasaporte:=vsPST_Pasmother
vtSTR_CodigoInterno:=vsPST_Codmother

vsPST_Persona:="mother"

WDW_OpenPopupWindow (Self:C308;->[ADT_Candidatos:49];"CustomIds";2)
DIALOG:C40([ADT_Candidatos:49];"CustomIds")
CLOSE WINDOW:C154

vsPST_RUTmother:=vtSTR_RUT
vsPST_IDN2mother:=vtSTR_IDNAcional2
vsPST_IDN3mother:=vtSTR_IDNAcional3
vsPST_Pasmother:=vtSTR_Pasaporte
vsPST_Codmother:=vtSTR_CodigoInterno

PST_UpdateParents ("mother")
ADTcdd_SetIdentificadorPrincipa 