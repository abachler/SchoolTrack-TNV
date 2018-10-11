Case of 
	: (alProEvt=AL Single click event)
		vtLunes:=""
		vtMartes:=""
		vtMiercoles:=""
		vtJueves:=""
		vtViernes:=""
		vtSabado:=""
		vtDomingo:=""
		ARRAY LONGINT:C221($al_IDRecorridos;0)
		$line:=AL_GetLine (xALP_ListaAlumnos)
		QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Alumno:2;=;alBU_AlumnoID{$line})
		If (Records in selection:C76([BU_Rutas_Inscripciones:35])>0)
			SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Numero_Recorrido:4;$al_IDRecorridos)
			For ($i;1;Size of array:C274($al_IDRecorridos))
				
				QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1;=;$al_IDRecorridos{$i})
				
				Case of 
					: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Lunes")
						vtLunes:=vtLunes+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
						
					: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Martes")
						vtMartes:=vtMartes+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
						
					: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Miércoles")
						vtMiercoles:=vtMiercoles+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
						
					: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Jueves")
						vtJueves:=vtJueves+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
						
					: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Viernes")
						vtViernes:=vtViernes+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
						
					: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Sabado")
						vtSabado:=vtSabado+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
						
					: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Domingo")
						vtDomingo:=vtDomingo+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
						
				End case 
				
				
			End for 
			
		End if 
		
		
		
End case 

