C_TEXT:C284($tempRegistrada)
$tempRegistrada:=auxVal
auxVal:="@"
auxVal:=IT_ShowChoices (->atblValues;->auxVal;"")
If (auxVal="")
	auxVal:=$tempRegistrada
End if 
