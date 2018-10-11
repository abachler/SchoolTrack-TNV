$selected:=Find in array:C230(lb_ColegiosGrupo;True:C214)
If ($selected>-1)
	APPEND TO ARRAY:C911(aColegiosAnteriores;aColegiosGrupo{$selected})
	SORT ARRAY:C229(aColegiosAnteriores)
	$colegio:=aColegiosGrupo{$selected}
	DELETE FROM ARRAY:C228(aColegiosGrupo;$selected;1)
	LISTBOX SELECT ROW:C912(lb_ColegiosGrupo;0;lk remove from selection:K53:3)
	$el:=Find in array:C230(aColegiosAnteriores;$colegio)
	LISTBOX SELECT ROW:C912(lb_ColegiosAnteriores;$el;lk replace selection:K53:1)
	OBJECT SET SCROLL POSITION:C906(Self:C308->;$el)
End if 