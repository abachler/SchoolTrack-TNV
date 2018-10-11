C_TEXT:C284($text)

For ($i;1;Size of array:C274(<>FormasComunicarResultados))
	If ([ADT_Candidatos:49]FormaComunicarResultados:58=<>FormasComunicarResultados{$i})
		$text:=$text+"!-"+<>FormasComunicarResultados{$i}+";"
	Else 
		$text:=$text+<>FormasComunicarResultados{$i}+";"
	End if 
End for 

$choice:=Pop up menu:C542($text)
If ($choice>0)
	[ADT_Candidatos:49]FormaComunicarResultados:58:=ST_GetWord ($text;$choice;";")
End if 