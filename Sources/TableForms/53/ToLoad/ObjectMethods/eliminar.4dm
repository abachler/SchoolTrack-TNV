
C_POINTER:C301($y_consultasNombre;$y_consultasNumero)

$y_consultasNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"consultas_nombre")
$y_consultasNumero:=OBJECT Get pointer:C1124(Object named:K67:5;"consultas_recNum")
$prompt:=Replace string:C233(__ ("¿Desea Usted realmente eliminar la fórmula de búsqueda ^0?");"^0";$y_consultasNombre->{$y_consultasNombre->})
$r:=CD_Dlog (2;$prompt;__ ("");__ ("No");__ ("Eliminar"))
If ($r=2)
	$recNum:=$y_consultasNumero->{$y_consultasNumero->}
	KRL_GotoRecord (->[xShell_Queries:53];$recNum;True:C214)
	If (OK=1)
		DELETE RECORD:C58([xShell_Queries:53])
		LOG_RegisterEvt ("Se elimina la consulta "+$y_consultasNombre->{$y_consultasNombre->})
		DELETE FROM ARRAY:C228($y_consultasNombre->;$y_consultasNombre->)
		DELETE FROM ARRAY:C228($y_consultasNumero->;$y_consultasNumero->)
		
	Else 
		CD_Dlog (0;__ ("Esta consulta no puede ser eliminada en este momento.\rPor favor inténtelo nuevamentemas tarde."))
	End if 
	KRL_UnloadReadOnly (->[xShell_Queries:53])
End if 