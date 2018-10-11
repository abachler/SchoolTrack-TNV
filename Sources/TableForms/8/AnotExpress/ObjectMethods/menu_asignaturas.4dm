$y_asignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.asignatura")

For ($i;1;Size of array:C274(at_AsigSelProfe))
	at_AsigSelProfe{$i}:=Replace string:C233(at_AsigSelProfe{$i};"(";"[")
	at_AsigSelProfe{$i}:=Replace string:C233(at_AsigSelProfe{$i};")";"]")
End for 

$text:=ST_GetCleanString (AT_array2text (->at_AsigSelProfe;";"))
$choice:=Pop up menu:C542($text)
If ($choice>0)
	$y_asignatura->:=at_AsigSelProfe{$choice}
End if 