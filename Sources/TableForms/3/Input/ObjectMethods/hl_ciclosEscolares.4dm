  //[Cursos].Input.hl_ciclosEscolares

C_LONGINT:C283(vl_referenciaCiclo)

GET LIST ITEM:C378(hl_CiclosEscolares;*;vl_referenciaCiclo;$text)
vl_Year:=vl_referenciaCiclo
CU_LoadEventosCurso (vl_Year;[Cursos:3]Numero_del_curso:6;xALP_EventosCurso)

SELECT LIST ITEMS BY REFERENCE:C630(hl_CiclosEscolares;vl_Year)