C_POINTER:C301($ArrayRefPointer;$tablePointer)
C_TEXT:C284($tempRegistrada)
$tempRegistrada:=[Alumnos_EventosOrientacion:21]Registrada_por:8
[Alumnos_EventosOrientacion:21]Registrada_por:8:="@"
[Alumnos_EventosOrientacion:21]Registrada_por:8:=IT_ShowChoices (->at_Profesores_Nombres;->[Alumnos_EventosOrientacion:21]Registrada_por:8;"";$ArrayRefPointer;$tablePointer;2)
If ([Alumnos_EventosOrientacion:21]Registrada_por:8="")
	[Alumnos_EventosOrientacion:21]Registrada_por:8:=$tempRegistrada
End if 
