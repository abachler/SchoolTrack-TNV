C_LONGINT:C283($i)
For ($i;Size of array:C274(lb_reemplazo);1;-1)
	If (lb_reemplazo{$i})
		DELETE FROM ARRAY:C228(atSTWA2_Usuario;$i)
		DELETE FROM ARRAY:C228(adSTWA2_fechadesde;$i)
		DELETE FROM ARRAY:C228(adSTWA2_fechahasta;$i)
		DELETE FROM ARRAY:C228(atSTWA2_Asignaturas;$i)
		DELETE FROM ARRAY:C228(atSTWA2_Remplaza;$i)
		DELETE FROM ARRAY:C228(atSTWA2_IDReemplaza;$i)
		DELETE FROM ARRAY:C228(atSTWA2_IDUsuario;$i)
		DELETE FROM ARRAY:C228(atSTWA2_AsignaturasID;$i)
		lb_reemplazo{$i}:=False:C215
	End if 
End for 