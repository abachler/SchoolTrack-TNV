$id:=ACTpp_CreateObs ([Personas:7]No:1;"";Current date:C33(*))
AL_ExitCell (xALP_Observaciones)
AL_UpdateArrays (xALP_Observaciones;0)
ACTpp_LoadObs 
AL_UpdateArrays (xALP_Observaciones;-2)
$line:=Find in array:C230(alACT_IDObsApdo;$id)
AL_GotoCell (xALP_Observaciones;2;$line)