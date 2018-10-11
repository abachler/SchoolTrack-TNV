  // [Alumnos_Conducta].AnotExpress.lista.funcionario()
  // Por: Alberto Bachler K.: 08-05-14, 19:06:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_fecha:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha")
$y_listaProfesor:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_listaIdProfesor:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.IdProfesor")
$l_fila:=$y_listaProfesor->

Case of 
	: (Form event:C388=On Clicked:K2:4)
		
	: (Form event:C388=On Data Change:K2:15)
		
		$t_nombreProfesor:=$y_listaProfesor->{$l_fila}+"@"
		
		QUERY:C277([Profesores:4];[Profesores:4]Apellido_paterno:3;=;$t_nombreProfesor;*)
		QUERY:C277([Profesores:4]; & ;[Profesores:4]Inactivo:62=False:C215)
		
		Case of 
			: (Records in selection:C76([Profesores:4])=0)
				$y_listaIdProfesor->{$l_fila}:=0
				$y_listaProfesor->{$l_fila}:=""
				
			: (Records in selection:C76([Profesores:4])=1)
				$y_listaProfesor->{$l_fila}:=[Profesores:4]Apellidos_y_nombres:28
				$y_listaIdProfesor->{$l_fila}->:=[Profesores:4]Numero:1
				
			: (Records in selection:C76([Profesores:4])>1)
				SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;$at_nombresProfesores;[Profesores:4]Numero:1;$al_idProfesores)
				$t_textoEditado:=$y_listaProfesor->{$l_fila}+"@"
				$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_nombresProfesores;->$t_textoEditado;OBJECT Get name:C1087(Object current:K67:2))
				If ($l_itemSeleccionado>0)
					$y_listaProfesor->{$l_fila}:=$at_nombresProfesores{$l_itemSeleccionado}
					$y_listaIdProfesor->{$l_fila}->:=$al_idProfesores{$l_itemSeleccionado}
				Else 
					$y_listaIdProfesor->{$l_fila}:=0
					$y_listaProfesor->{$l_fila}:=""
				End if 
		End case 
		
		If ($y_listaProfesor->{$l_fila}="")
			EDIT ITEM:C870(*;"lista.funcionario";$l_fila)
		End if 
		
End case 

