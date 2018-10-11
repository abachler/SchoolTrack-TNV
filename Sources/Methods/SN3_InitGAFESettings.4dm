//%attributes = {}
SN3_LoginTypeSelGAFE:=1
SN3_LoginTypeSelAluGAFE:=1
SN3_LoginTypeSelProfGAFE:=1

cb_GAFE_RelFam:=0
cb_GAFE_RelFam_Mail:=0
cb_GAFE_RelFam_Drive:=0
cb_GAFE_RelFam_Cal:=0

cb_GAFE_Prof:=0
cb_GAFE_Prof_Mail:=0
cb_GAFE_Prof_Drive:=0
cb_GAFE_Prof_Cal:=0

cb_GAFE_Alu:=0
ARRAY LONGINT:C221(SN3_GAFE_Alu_IDNiveles;0)
ARRAY BOOLEAN:C223(SN3_GAFE_Alu_Mail;0)
ARRAY BOOLEAN:C223(SN3_GAFE_Alu_Drive;0)
ARRAY BOOLEAN:C223(SN3_GAFE_Alu_Cal;0)

NIV_LoadArrays 
COPY ARRAY:C226(<>al_NumeroNivelesSchoolNet;SN3_GAFE_Alu_IDNiveles)
AT_RedimArrays (Size of array:C274(SN3_GAFE_Alu_IDNiveles);->SN3_GAFE_Alu_Mail;->SN3_GAFE_Alu_Drive;->SN3_GAFE_Alu_Cal)