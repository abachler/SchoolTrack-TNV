$line:=AL_GetLine (xALP_ControlesMedicos)
AT_Delete ($line;1;->aCMedico_Fecha;->aCMedico_Curso;->aCMedico_Edad;->aCMedico_Talla;->aCMedico_Peso;->aCMedico_IMC;->aCMedico_ID)
AL_UpdateArrays (xALP_ControlesMedicos;-2)
vl_ModSalud:=vl_ModSalud ?+ 3
AL_SetLine (xALP_ControlesMedicos;0)
_O_DISABLE BUTTON:C193(bDelSalud_ControlMedico)