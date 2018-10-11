$line:=AL_GetLine (xALP_Vacunas)
AT_Delete ($line;1;->aVacuna_Edad;->aVacuna_Enfermedad;->aVacuna_SiNo;->aVacuna_Meses)
AL_UpdateArrays (xALP_Vacunas;-2)
vl_ModSalud:=vl_ModSalud ?+ 4
AL_SetLine (xALP_Vacunas;0)
_O_DISABLE BUTTON:C193(bDelSalud_Vacuna)