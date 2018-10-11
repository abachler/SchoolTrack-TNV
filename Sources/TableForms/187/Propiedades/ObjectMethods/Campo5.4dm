CD_Dlog (0;__ ("No disponible"))
[MPA_DefinicionCompetencias:187]AdicionIndicadores_Autorizada:19:=False:C215
If ([MPA_DefinicionCompetencias:187]AdicionIndicadores_Autorizada:19)
	OBJECT SET ENTERABLE:C238([MPA_DefinicionCompetencias:187]Maximo_Indicadores:9;True:C214)
Else 
	OBJECT SET ENTERABLE:C238([MPA_DefinicionCompetencias:187]Maximo_Indicadores:9;False:C215)
End if 