$line:=AL_GetLine (xALP_Alergias)
DELETE FROM ARRAY:C228(aAlergiaTipo;$line)
DELETE FROM ARRAY:C228(aAlergeno;$line)
AL_UpdateArrays (xALP_Alergias;-2)
vl_ModSalud:=vl_ModSalud ?+ 2
AL_SetLine (xALP_Alergias;0)
_O_DISABLE BUTTON:C193(bDelSalud_Alergia)