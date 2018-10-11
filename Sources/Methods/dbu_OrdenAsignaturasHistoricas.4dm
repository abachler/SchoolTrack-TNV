//%attributes = {}
  //dbu_OrdenAsignaturasHistoricas

$p:=IT_UThermometer (1;0;__ ("Asignando referencias de ordenamiento en asignaturas histórica..."))

READ WRITE:C146([Asignaturas_Historico:84])


For ($iNiveles;-6;12)
	
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$iNiveles)
	SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$aAsignatura;[Asignaturas:18]ordenGeneral:105;$aOrden)
	
	QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]OrdenGeneral:42="";*)
	QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Nivel:4=$iNiveles)
	
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Historico:84];$aRecNums;"")
	$ultimoNivel:=0
	For ($i;1;Size of array:C274($aRecNums))
		READ WRITE:C146([Asignaturas_Historico:84])
		GOTO RECORD:C242([Asignaturas_Historico:84];$aRecNums{$i})
		$position:=Find in array:C230($aAsignatura;[Asignaturas_Historico:84]Asignatura:2)
		If ($position>0)
			[Asignaturas_Historico:84]OrdenGeneral:42:=$aOrden{$position}
			SAVE RECORD:C53([Asignaturas_Historico:84])
		End if 
	End for 
	
	QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Nivel:4=$iNiveles)
	ORDER BY:C49([Asignaturas_Historico:84];[Asignaturas_Historico:84]OrdenGeneral:42;>;[Asignaturas_Historico:84]Asignatura:2;>)
	
	For ($i;1;Size of array:C274($aRecNums))
		READ WRITE:C146([Asignaturas_Historico:84])
		GOTO RECORD:C242([Asignaturas_Historico:84];$aRecNums{$i})
		If ([Asignaturas_Historico:84]OrdenGeneral:42="")
			[Asignaturas_Historico:84]OrdenGeneral:42:=String:C10($i;"00")
			SAVE RECORD:C53([Asignaturas_Historico:84])
		End if 
	End for 
End for 
$p:=IT_UThermometer (-2;$p)
KRL_UnloadReadOnly (->[Asignaturas_Historico:84])