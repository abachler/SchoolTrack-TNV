//%attributes = {}
  //IN_FirstUseWizard

$Step:=PREF_fGet (0;"Instalación";"")
vb_FirstInstall:=True:C214
If ($step="")
	INwzd_Registration 
End if 
$Step:=PREF_fGet (0;"Instalación";"")
If ($step="Cursos iniciado")
	WIZ_STR_CreacionCursos 
End if 
$Step:=PREF_fGet (0;"Instalación";"")
If ($step="Cursos Terminado")
	WIZ_STR_MallaCurricular 
End if 
$Step:=PREF_fGet (0;"Instalación";"")
If ($step="Planes Terminado")
	WIZ_STR_ImportacionAlumnos 
End if 