AL_UpdateArrays (xALP_alergias;0)
INSERT IN ARRAY:C227(aAlergiaTipo;1)
INSERT IN ARRAY:C227(aAlergeno;1)
AL_UpdateArrays (xALP_alergias;-2)


GOTO OBJECT:C206(xALP_alergias)
AL_GotoCell (xALP_alergias;1;1)
AL_SetCellHigh (xALP_alergias;1;80)