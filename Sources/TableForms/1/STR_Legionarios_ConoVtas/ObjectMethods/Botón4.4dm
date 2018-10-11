If (vt_WsFecha#"")
	PREF_Set (-555;"WSMXLEG_Fecha";vt_WsFecha)
	CD_Dlog (0;__ ("Web Service establecido"))
Else 
	CD_Dlog (0;__ ("El campo no debe estar vacio"))
End if 
