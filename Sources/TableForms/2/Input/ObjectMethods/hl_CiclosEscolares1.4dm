C_TEXT:C284($text)
C_LONGINT:C283(vl_referenciaCiclo)

GET LIST ITEM:C378(hl_CiclosEscolares;*;vl_referenciaCiclo;$text)

If (vl_referenciaCiclo>0)
	$stringRef:=String:C10(vl_referenciaCiclo)
	vl_Year:=Num:C11(Substring:C12(String:C10(vl_referenciaCiclo);1;4))
	vl_NivelSeleccionado:=Num:C11(Substring:C12(String:C10(vl_referenciaCiclo);5;2))
	vl_periodoSeleccionado:=Num:C11($stringRef[[Length:C16($stringRef)]])
	
	
Else 
	
	$absoluteRef:=Abs:C99(vl_referenciaCiclo)
	$stringRef:=String:C10($absoluteRef)
	vl_Year:=Num:C11(Substring:C12(String:C10($absoluteRef);1;4))
	vl_NivelSeleccionado:=-Num:C11(Substring:C12(String:C10($absoluteRef);5;2))
	vl_periodoSeleccionado:=Num:C11($stringRef[[Length:C16($stringRef)]])
End if 


AL_PaginaAprendizajes 

OBJECT SET VISIBLE:C603(*;"estilos_evaluacion@";False:C215)