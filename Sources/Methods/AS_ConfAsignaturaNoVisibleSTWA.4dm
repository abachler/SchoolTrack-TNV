//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 28-02-18, 07:53:25
  // ----------------------------------------------------
  // Método: AS_ConfAsignaturaNoVisibleSTWA
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_BOOLEAN:C305($b_noVisible)
C_LONGINT:C283($l_noVisible)
C_OBJECT:C1216($o_Opciones)

C_POINTER:C301($y_BWRRecordNumber)

$t_accion:=$1
If (Count parameters:C259=2)
	$y_BWRRecordNumber:=$2
End if 

Case of 
	: ($t_accion="init")
		
		ARRAY TEXT:C222(at_asignatura;0)
		ARRAY TEXT:C222(at_cursosAsignaturas;0)
		ARRAY TEXT:C222(at_cursosFiltro;0)
		ARRAY LONGINT:C221(al_asignaturasID;0)
		ARRAY OBJECT:C1221(ao_Opciones;0)
		ARRAY BOOLEAN:C223(ab_noVisible;0)
		
		CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$y_BWRRecordNumber->)
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]Asignatura:3;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;at_asignatura;[Asignaturas:18]Numero:1;al_asignaturasID;[Asignaturas:18]Curso:5;at_cursosAsignaturas;[Asignaturas:18]Opciones:57;ao_Opciones)
		
		  //dejo un arreglo con los cursos ordenados por nivel para filtro alternativo
		APPEND TO ARRAY:C911(at_cursosFiltro;__ ("Mostrar todos"))
		at_cursosFiltro{0}:=__ ("Mostrar todos")
		
		For ($i;1;Size of array:C274(at_cursosAsignaturas))
			If ((Find in array:C230(at_cursosFiltro;at_cursosAsignaturas{$i})=-1) & (at_cursosAsignaturas{$i}#""))
				APPEND TO ARRAY:C911(at_cursosFiltro;at_cursosAsignaturas{$i})
			End if 
			
			  //acá Separo las opciones
			$o_Opciones:=ao_Opciones{$i}
			OB_GET ($o_Opciones;->$b_noVisible;"NoMostrarEnSTWA")
			  //$b_noVisible:=($l_noVisible=1)
			APPEND TO ARRAY:C911(ab_noVisible;$b_noVisible)
		End for 
		
		WDW_OpenFormWindow (->[Asignaturas:18];"NoVisibleSTWA";-1;Movable form dialog box:K39:8;__ ("Configuración asignaturas no visibles en SchoolTrack WebAccess"))
		DIALOG:C40([Asignaturas:18];"NoVisibleSTWA")
		CLOSE WINDOW:C154
		AT_Initialize (->at_asignatura;->at_cursosAsignaturas;->at_cursosFiltro;->al_asignaturasID;->ao_Opciones)
		
	: ($t_accion="guardar")
		C_LONGINT:C283($l_progres)
		READ WRITE:C146([Asignaturas:18])
		
		$l_progres:=IT_Progress (1;0;0;__ ("Aplicando configuración..."))
		For ($i;1;Size of array:C274(al_asignaturasID))
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=al_asignaturasID{$i})
			$l_progres:=IT_Progress (0;$l_progres;$i/Size of array:C274(al_asignaturasID);__ ("Aplicando configuración en: ")+[Asignaturas:18]Asignatura:3)
			$o_Opciones:=[Asignaturas:18]Opciones:57
			OB SET:C1220($o_Opciones;"NoMostrarEnSTWA";ab_noVisible{$i})
			[Asignaturas:18]Opciones:57:=$o_Opciones
			SAVE RECORD:C53([Asignaturas:18])
		End for 
		$l_progres:=IT_Progress (-1;$l_progres)
		
		KRL_UnloadReadOnly (->[Asignaturas:18])
		AT_Initialize (->at_asignatura;->at_cursosAsignaturas;->at_cursosFiltro;->al_asignaturasID;->ao_Opciones)
		
		  // MOD Ticket N° 209394 PA 20180621, se elimina caso para filtrar asignaturas
		
		
End case 


