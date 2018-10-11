//%attributes = {}
$l_therm:=IT_UThermometer (1;0;"Limpiando campo en ficha médica…")
READ WRITE:C146([Alumnos_FichaMedica:13])
ALL RECORDS:C47([Alumnos_FichaMedica:13])
APPLY TO SELECTION:C70([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]factor_riesgo:15:="")
KRL_UnloadReadOnly (->[Alumnos_FichaMedica:13])
IT_UThermometer (-2;$l_therm)