$line:=AL_GetLine (xALP_Suspensiones)
$result:=CD_Dlog (0;__ ("¿Esta seguro de querer eliminar el motivo de suspensión ")+atSTRal_MotivosSuspension{$line}+__ ("?");__ ("");__ ("No");__ ("Sí"))
If ($result=2)
	AL_UpdateArrays (xALP_Suspensiones;0)
	DELETE FROM ARRAY:C228(atSTRal_MotivosSuspension;$line)
	AL_UpdateArrays (xALP_Suspensiones;-2)
	AL_SetLine (xALP_Suspensiones;0)
End if 




