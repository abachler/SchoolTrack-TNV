AL_UpdateArrays (xALP_Observaciones;0)
AT_Insert (1;1;->adFechaObservacion;->atTextoObservacion;->atUsuarioObservacion;->aiIDObservacion)
adFechaObservacion{1}:=Current date:C33(*)
atUsuarioObservacion{1}:=USR_GetUserName (<>lUSR_CurrentUserID)
aiIDObservacion{1}:=-1
AL_UpdateArrays (xALP_Observaciones;-2)
GOTO OBJECT:C206(xALP_Observaciones)
AL_GotoCell (xALP_Observaciones;1;1)

