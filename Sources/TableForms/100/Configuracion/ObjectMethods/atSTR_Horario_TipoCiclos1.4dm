If (Self:C308->>2)
	CD_Dlog (0;__ ("No implementado en esta versión"))
	Self:C308->:=vlSTR_Horario_TipoCiclos
Else 
	vlSTR_Horario_TipoCiclos:=Self:C308->
End if 

If (vlSTR_Horario_TipoCiclos=1)
	ARRAY DATE:C224(adSTR_Periodos_InicioCiclos;0)
End if 

OBJECT SET VISIBLE:C603(*;"ResetCiclosHorario@";(vlSTR_Horario_TipoCiclos=2))