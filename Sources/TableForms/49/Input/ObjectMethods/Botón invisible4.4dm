$text:=AT_array2text (-><>IdiomasEvaluacion;";")
$choice:=Pop up menu:C542($text)
If ($choice>0)
	[ADT_Candidatos:49]Idioma_Evaluacion:45:=ST_GetWord ($text;$choice;";")
End if 