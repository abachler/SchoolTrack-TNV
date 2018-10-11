C_LONGINT:C283($i)
For ($i;Size of array:C274(lb_listadoIP);1;-1)
	If (lb_listadoIP{$i})
		DELETE FROM ARRAY:C228(atSTWA2_nombreCS;$i)
		DELETE FROM ARRAY:C228(atSTWA2_IPs;$i)
		DELETE FROM ARRAY:C228(abSTWA2_Activo;$i)
		lb_listadoIP{$i}:=False:C215
	End if 
End for 