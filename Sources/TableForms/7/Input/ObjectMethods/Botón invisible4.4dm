C_TEXT:C284($tempRegistrada)
$tempRegistrada:=[Personas:7]Profesion:13
[Personas:7]Profesion:13:="@"
[Personas:7]Profesion:13:=IT_ShowChoices (-><>aProfesion;->[Personas:7]Profesion:13;"")
If ([Personas:7]Profesion:13="")
	[Personas:7]Profesion:13:=$tempRegistrada
End if 



