//%attributes = {}
  //Compiler_WEB

C_TEXT:C284(vtWS_ErrorString)
C_TEXT:C284(<>vt_NameColegio)

ARRAY TEXT:C222(atWS_NombresFamilia;0)
ARRAY LONGINT:C221(alWS_IdsFamilia;0)
ARRAY TEXT:C222(atWS_FieldValues;0)
ARRAY TEXT:C222(atWS_FieldNames;0)
If (Is compiled mode:C492)
	C_TEXT:C284(WSsend_FamilyRefs ;$schoolID;$userName;$password;$dateTime_DTS;$1;$2;$3;$4)
End if 


ARRAY TEXT:C222(aDatosLogin;0)
Compiler_STW 


ARRAY LONGINT:C221(aIDsNoExistentes;0)