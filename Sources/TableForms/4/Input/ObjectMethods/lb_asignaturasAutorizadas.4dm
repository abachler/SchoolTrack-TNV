  // [Profesores].Input.lb_asignaturasAutorizadas()
  // Por: Alberto Bachler K.: 27-03-14, 13:01:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i)
C_POINTER:C301($y_lista)
C_TEXT:C284($t_asignaturaSeleccionada;$t_itemSeleccionado;$t_menu;$t_menuAsignaturas)

ARRAY TEXT:C222($at_asignaturas;0)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			If (USR_checkRights ("M";->[Profesores:4]))
				$y_lista:=OBJECT Get pointer:C1124(Object named:K67:5;"asignaturasAutorizadas")
				If ($y_lista->>0)
					$t_asignaturaSeleccionada:=$y_lista->{$y_lista->}
				End if 
				
				READ ONLY:C145([Asignaturas:18])
				ALL RECORDS:C47([Asignaturas:18])
				DISTINCT VALUES:C339([Asignaturas:18]Asignatura:3;$at_asignaturas)
				SORT ARRAY:C229($at_asignaturas)
				$t_menuAsignaturas:=MNU_ArrayToMenu (->$at_asignaturas)
				
				$t_menu:=Create menu:C408
				APPEND MENU ITEM:C411($t_menu;__ ("Autorizar todas las asignaturas"))
				SET MENU ITEM PARAMETER:C1004($t_menu;-1;"-1")
				APPEND MENU ITEM:C411($t_menu;__ ("Autorizar");$t_menuAsignaturas)
				SET MENU ITEM PARAMETER:C1004($t_menu;-1;"0")
				APPEND MENU ITEM:C411($t_menu;"(-")
				SET MENU ITEM PARAMETER:C1004($t_menu;-1;"0")
				
				If ($t_asignaturaSeleccionada#"")
					  //APPEND MENU ITEM($t_menu;__ ("Retirar autorización a ")+$t_asignaturaSeleccionada)
					  //20140611 ASM 133671
					If (Position:C15("(";$t_asignaturaSeleccionada)>0)
						$t_asignaturaSeleccionada:=Char:C90(1)+__ ("Retirar autorización a ")+$t_asignaturaSeleccionada
					Else 
						$t_asignaturaSeleccionada:=__ ("Retirar autorización a ")+$t_asignaturaSeleccionada
					End if 
					APPEND MENU ITEM:C411($t_menu;$t_asignaturaSeleccionada)
					SET MENU ITEM PARAMETER:C1004($t_menu;-1;String:C10($y_lista->))
				Else 
					APPEND MENU ITEM:C411($t_menu;"Retirar autorización")
					SET MENU ITEM PARAMETER:C1004($t_menu;-1;"0")
					DISABLE MENU ITEM:C150($t_menu;-1)
				End if 
			Else 
				APPEND MENU ITEM:C411($t_menu;__ ("Autorizar todas las asignaturas")+";"+__ ("Autorizar")+";(-"+__ ("Retirar autorización a "))
				DISABLE MENU ITEM:C150($t_menu;0)
			End if 
			$t_itemSeleccionado:=Dynamic pop up menu:C1006($t_menu)
			$l_refItemSeleccionado:=ST_String_IsNumber ($t_itemSeleccionado)
			
			Case of 
				: ($t_itemSeleccionado="")
					  // nada
					
				: ($t_itemSeleccionado="-1")
					For ($i;1;Size of array:C274($at_asignaturas))
						_O_QUERY SUBRECORDS:C108([Profesores:4]Asignaturas:13;[Profesores]Asignaturas'Asignatura=$at_asignaturas{$i})
						If (_O_Records in subselection:C7([Profesores:4]Asignaturas:13)=0)
							_O_CREATE SUBRECORD:C72([Profesores:4]Asignaturas:13)
							[Profesores]Asignaturas'Asignatura:=$at_asignaturas{$i}
							APPEND TO ARRAY:C911($y_lista->;$at_asignaturas{$i})
						End if 
					End for 
					SORT ARRAY:C229($y_lista->;>)
					AsigAutorizada:=True:C214
					
				: ($l_refItemSeleccionado>0)
					_O_QUERY SUBRECORDS:C108([Profesores:4]Asignaturas:13;[Profesores]Asignaturas'Asignatura=$y_lista->{$l_refItemSeleccionado})
					_O_DELETE SUBRECORD:C96([Profesores:4]Asignaturas:13)
					DELETE FROM ARRAY:C228($y_lista->;Num:C11($l_refItemSeleccionado))
					AsigAutorizada:=True:C214
					
					
				: ($t_itemSeleccionado#"")
					_O_QUERY SUBRECORDS:C108([Profesores:4]Asignaturas:13;[Profesores]Asignaturas'Asignatura=$t_itemSeleccionado)
					If (_O_Records in subselection:C7([Profesores:4]Asignaturas:13)=0)
						_O_CREATE SUBRECORD:C72([Profesores:4]Asignaturas:13)
						[Profesores]Asignaturas'Asignatura:=$t_itemSeleccionado
						APPEND TO ARRAY:C911($y_lista->;$t_itemSeleccionado)
						AsigAutorizada:=True:C214
					End if 
			End case 
		End if 
End case 

