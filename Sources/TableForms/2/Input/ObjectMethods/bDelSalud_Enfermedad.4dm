$line:=AL_GetLine (xALP_Hospitalizaciones)
DELETE FROM ARRAY:C228(aHospFecha;$line)
DELETE FROM ARRAY:C228(aHospDiagnostico;$line)
DELETE FROM ARRAY:C228(aHospHasta;$line)
AL_UpdateArrays (xALP_Hospitalizaciones;-2)
AL_SetLine (xALP_Hospitalizaciones;0)
_O_DISABLE BUTTON:C193(bDelSalud_Hospitalizacion)
vl_ModSalud:=vl_ModSalud ?+ 1