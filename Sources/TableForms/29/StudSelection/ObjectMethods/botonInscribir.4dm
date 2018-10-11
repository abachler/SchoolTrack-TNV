  // [Actividades].StudSelection.Inscribir()
  // Por: Alberto Bachler K.: 07-06-14, 15:02:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_inscribir)
C_LONGINT:C283($i;$l_filaSeleccionada;$l_itemSeleccionado;$l_periodo)
C_POINTER:C301(vy_listaAlumnos;vy_recNumAlumnos_al)

ARRAY LONGINT:C221($al_filasSeleccionadas;0)
ARRAY TEXT:C222($at_itemsMenu;0)

ARRAY BOOLEAN:C223($ab_EliminarDeArray;0)

  //ASM 20141022 Se leen en el On load del formulario [Actividades]StudSelection
  //vy_listaAlumnos:=OBJECT Get pointer(Object named;"seleccionAlumnos")
  //vy_nivelAlumnos_at:=OBJECT Get pointer(Object named;"nivelAlumnos")
  //vy_cursoAlumnos_at:=OBJECT Get pointer(Object named;"cursoAlumnos")
  //vy_nombresAlumnos_at:=OBJECT Get pointer(Object named;"nombreAlumnos")
  //yv_recNumAlumnos_al:=OBJECT Get pointer(Object named;"recNumAlumnos")

$l_filaSeleccionada:=LB_GetSelectedRows (vy_listaAlumnos;->$al_filasSeleccionadas)

APPEND TO ARRAY:C911($at_itemsMenu;__ ("Inscribir en todos los períodos"))
APPEND TO ARRAY:C911($at_itemsMenu;"(-")
For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
	APPEND TO ARRAY:C911($at_itemsMenu;__ ("Inscribir en ")+atSTR_Periodos_Nombre{$i})
End for 
$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_itemsMenu)

Case of 
	: ($l_itemSeleccionado=0)
		$l_periodo:=-1
	: ($l_itemSeleccionado=1)
		$b_inscribir:=True:C214
		$l_periodo:=0
	Else 
		$l_periodo:=$l_itemSeleccionado-2
End case 

If ($l_periodo>=0)
	For ($i;Size of array:C274($al_filasSeleccionadas);1;-1)
		XCR_apInscribe (vy_recNumAlumnos_al->{$al_filasSeleccionadas{$i}};$l_periodo)
		  //ASM no se puede eliminar antes de inscribir, porque se cambia la posición del arreglo, y se inscribía otro alumno
		Case of 
			: ([Alumnos_Actividades:28]Periodos_Inscritos:44=1)
				APPEND TO ARRAY:C911($ab_EliminarDeArray;True:C214)
			: ([Alumnos_Actividades:28]Periodos_Inscritos:44>1)
				APPEND TO ARRAY:C911($ab_EliminarDeArray;False:C215)
		End case 
		
	End for 
	For ($i;Size of array:C274($al_filasSeleccionadas);1;-1)
		Case of 
			: ($ab_EliminarDeArray{$i})
				AT_Delete ($al_filasSeleccionadas{$i};1;vy_listaAlumnos;vy_nivelAlumnos_at;vy_cursoAlumnos_at;vy_nombresAlumnos_at;vy_recNumAlumnos_al;->XCR_estiloSeleccionAlumnos_al)
			: (Not:C34($ab_EliminarDeArray{$i}))
				XCR_estiloSeleccionAlumnos_al{$al_filasSeleccionadas{$i}}:=Italic:K14:3
		End case 
	End for 
End if 
