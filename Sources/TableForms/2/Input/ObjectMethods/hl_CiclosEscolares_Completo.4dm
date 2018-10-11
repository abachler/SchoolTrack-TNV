C_TEXT:C284($text)
C_LONGINT:C283(vl_referenciaCiclo)



If (Application version:C493>="12@")
	  //comentar en 4D 2004
	GET LIST ITEM:C378(hl_CiclosEscolares_Completo;*;vl_referenciaCicloCompleto;$text)
	GET LIST ITEM PARAMETER:C985(hl_CiclosEscolares_Completo;*;"Año";vl_Year)
	GET LIST ITEM PARAMETER:C985(hl_CiclosEscolares_Completo;*;"Nivel";vl_NivelSeleccionado)
	GET LIST ITEM PARAMETER:C985(hl_CiclosEscolares_Completo;*;"Periodo";vl_periodoSeleccionado)
Else 
	If (vl_referenciaCicloCompleto>0)
		$stringRef:=String:C10(vl_referenciaCicloCompleto)
		vl_Year:=Num:C11(Substring:C12(String:C10(vl_referenciaCicloCompleto);1;4))
		vl_NivelSeleccionado:=Num:C11(Substring:C12(String:C10(vl_referenciaCicloCompleto);5;2))
		vl_periodoSeleccionado:=Num:C11($stringRef[[Length:C16($stringRef)]])
		
	Else 
		$absoluteRef:=Abs:C99(vl_referenciaCicloCompleto)
		$stringRef:=String:C10($absoluteRef)
		vl_Year:=Num:C11(Substring:C12(String:C10($absoluteRef);1;4))
		vl_NivelSeleccionado:=-Num:C11(Substring:C12(String:C10($absoluteRef);5;2))
		vl_periodoSeleccionado:=Num:C11($stringRef[[Length:C16($stringRef)]])
	End if 
End if 

AL_PaginaConducta_y_Asistencia 
