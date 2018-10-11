$r:=CD_Dlog (0;__ ("Esto grabará los contenidos actuales de las listas al archivo de listas del sistema. ¿Desea proseguir?");__ ("");__ ("Si");__ ("No"))
If ($r=1)
	TBL_SaveLibrary 
End if 