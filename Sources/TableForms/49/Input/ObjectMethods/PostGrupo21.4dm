$text:=AT_array2text (-><>asPST_IViewIndicators)
$choice:=Pop up menu:C542($text)
If ($choice>0)
	[ADT_Candidatos:49]Calificación_entrevista:13:=<>asPST_IViewIndicators{$choice}
	SAVE RECORD:C53([ADT_Entrevistas:121])
End if 