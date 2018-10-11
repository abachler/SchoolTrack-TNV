$line:=AL_GetLine (xALP_Aparatos)
AT_Delete ($line;1;->aAparatos_Year;->aAparatos_Curso;->aAparatos_Aparato;->aAparatos_NoNivel)
AL_UpdateArrays (xALP_Aparatos;-2)
vl_ModSalud:=vl_ModSalud ?+ 5
AL_SetLine (xALP_Aparatos;0)
_O_DISABLE BUTTON:C193(Self:C308->)