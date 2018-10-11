$line:=AL_GetLine (xALP_Castigos)
$result:=CD_Dlog (0;__ ("¿Esta seguro de querer eliminar el motivo de castigo ")+atSTRal_MotivosCastigo{$line}+__ ("?");__ ("");__ ("No");__ ("Sí"))
If ($result=2)
	AL_UpdateArrays (xALP_Castigos;0)
	DELETE FROM ARRAY:C228(atSTRal_MotivosCastigo;$line)
	AL_UpdateArrays (xALP_Castigos;-2)
	AL_SetLine (xALP_Castigos;0)
End if 




