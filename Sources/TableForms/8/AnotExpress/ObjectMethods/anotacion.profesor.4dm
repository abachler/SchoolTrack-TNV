  // [Alumnos_Conducta].AnotExpress.anotacion.profesor()
  // Por: Alberto Bachler K.: 08-05-14, 11:07:22
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$y_profesor:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_idProfesor:=OBJECT Get pointer:C1124(Object named:K67:5;"idProfesor")
$y_asignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.asignatura")

QUERY:C277([Profesores:4];[Profesores:4]Apellido_paterno:3;=;$y_profesor->+"@";*)
QUERY:C277([Profesores:4]; & ;[Profesores:4]Inactivo:62=False:C215)

Case of 
	: (Records in selection:C76([Profesores:4])=0)
		$y_idProfesor->:=0
		$y_profesor->:=""
		$y_asignatura->:=""
		
	: (Records in selection:C76([Profesores:4])=1)
		$y_profesor->:=[Profesores:4]Apellidos_y_nombres:28
		$y_idProfesor->:=[Profesores:4]Numero:1
		$y_asignatura->:=""
		
	: (Records in selection:C76([Profesores:4])>1)
		SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;$at_nombresProfesores;[Profesores:4]Numero:1;$al_idProfesores)
		$t_textoEditado:=$y_profesor->+"@"
		$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_nombresProfesores;->$t_textoEditado;OBJECT Get name:C1087(Object current:K67:2))
		If ($l_itemSeleccionado>0)
			$y_profesor->:=$at_nombresProfesores{$l_itemSeleccionado}
			$y_idProfesor->:=$al_idProfesores{$l_itemSeleccionado}
			$y_asignatura->:=""
		Else 
			$y_idProfesor->:=0
			$y_profesor->:=""
			$y_asignatura->:=""
		End if 
End case 

If ($y_profesor->="")
	GOTO OBJECT:C206(*;"anotacion.profesor")
Else 
	
	QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33;=;$y_idProfesor->;*)
	QUERY:C277([Asignaturas:18]; | ;[Asignaturas:18]profesor_numero:4=$y_idProfesor->)
	AT_DistinctsFieldValues (->[Asignaturas:18]denominacion_interna:16;->at_AsigSelProfe)
	
End if 




