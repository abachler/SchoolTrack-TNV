C_TEXT:C284($tempRegistrada)
$tempRegistrada:=[Personas:7]Cargo:21
[Personas:7]Cargo:21:="@"
[Personas:7]Cargo:21:=IT_ShowChoices (-><>aCargo;->[Personas:7]Cargo:21;"")
If ([Personas:7]Cargo:21="")
	[Personas:7]Cargo:21:=$tempRegistrada
End if 



