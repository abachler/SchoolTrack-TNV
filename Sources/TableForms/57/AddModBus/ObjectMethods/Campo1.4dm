If (Record number:C243([BU_Rutas:26])#-3)
	If ([Buses_escolares:57]Capacidad:11#0)
		$valorvalidacion:=BU_ValidaCupo (0;[Buses_escolares:57]Capacidad:11)
		If ($valorvalidacion#0)
			OK:=CD_Dlog (1;__ ("Existe al menos un recorrido con  un número de inscripciones superior a la capacidad del Bus \rNo se podrá asignar el nuevo bus si no se eliminan las inscripciones");__ ("");__ ("Ok"))
			[Buses_escolares:57]Capacidad:11:=0
		End if 
	End if 
End if 