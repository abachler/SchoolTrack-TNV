//%attributes = {}
C_BLOB:C604($gafeBlob)

$OT_Object:=OT New 
OT PutLong ($OT_Object;"userType";SN3_LoginTypeSelGAFE)
OT PutLong ($OT_Object;"userTypeAlu";SN3_LoginTypeSelAluGAFE)
OT PutLong ($OT_Object;"userTypeProf";SN3_LoginTypeSelProfGAFE)

OT PutLong ($OT_Object;"cb_GAFE_RelFam";cb_GAFE_RelFam)
OT PutLong ($OT_Object;"cb_GAFE_RelFam_Mail";cb_GAFE_RelFam_Mail)
OT PutLong ($OT_Object;"cb_GAFE_RelFam_Drive";cb_GAFE_RelFam_Drive)
OT PutLong ($OT_Object;"cb_GAFE_RelFam_Cal";cb_GAFE_RelFam_Cal)

OT PutLong ($OT_Object;"cb_GAFE_Prof";cb_GAFE_Prof)
OT PutLong ($OT_Object;"cb_GAFE_Prof_Mail";cb_GAFE_Prof_Mail)
OT PutLong ($OT_Object;"cb_GAFE_Prof_Drive";cb_GAFE_Prof_Drive)
OT PutLong ($OT_Object;"cb_GAFE_Prof_Cal";cb_GAFE_Prof_Cal)

OT PutLong ($OT_Object;"cb_GAFE_Alu";cb_GAFE_Alu)
OT PutArray ($OT_Object;"idNiveles";SN3_GAFE_Alu_IDNiveles)
OT PutArray ($OT_Object;"mail_Alumnos";SN3_GAFE_Alu_Mail)
OT PutArray ($OT_Object;"drive_Alumnos";SN3_GAFE_Alu_Drive)
OT PutArray ($OT_Object;"cal_Alumnos";SN3_GAFE_Alu_Cal)

$gafeBlob:=OT ObjectToNewBLOB ($OT_Object)
OT Clear ($OT_Object)

PREF_SetBlob (0;"SN3GAFESettings";$gafeBlob)