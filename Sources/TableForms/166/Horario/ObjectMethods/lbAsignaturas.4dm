  // [TMT_Horario].Horario.lbAsignaturas()
  //
  //
  // creado por: Alberto Bachler Klein: 20-07-16, 12:27:23
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_columna;$l_fila;$l_itemSeleccionado)
C_TEXT:C284($t_Asignaciones;$t_itemsPopUpMenu)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY LONGINT:C221($al_columnasResalte;0)
ARRAY INTEGER:C220($ai_dia;0)
ARRAY LONGINT:C221($al_filasResalte;0)
ARRAY INTEGER:C220($ai_Hora;0)
ARRAY POINTER:C280($ay_Columnas;0)
ARRAY POINTER:C280($ay_Encabezados;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)

LISTBOX GET ARRAYS:C832(*;"lbHorario";$at_nombreColumnas;$at_nombreEncabezados;$ay_Columnas;$ay_Encabezados;$ab_visibles;$ay_estilos)

Case of 
	: (Form event:C388=On Drag Over:K2:13)
		$0:=-1
		
		
	: (Form event:C388=On Double Clicked:K2:5)
		LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087;$l_columna;$l_fila)
		TMT_InfoAsignacionAsignatura (alSTK_IDSubsectores{$l_fila})
		
		
	: ((Form event:C388=On Clicked:K2:4) & (Contextual click:C713))
		AT_Initialize (->$al_columnasResalte;->$al_filasResalte)
		OBJECT SET VISIBLE:C603(*;"resalte@";False:C215)
		LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087;$l_columna;$l_fila)
		If ($l_fila>0)
			QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=alSTK_IDSubsectores{$l_fila})
			If (Records in selection:C76([TMT_Horario:166])>0)
				SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroDia:1;$ai_dia;[TMT_Horario:166]NumeroHora:2;$ai_Hora)
				AT_MultiLevelSort (">>";->$ai_dia;->$ai_Hora)
				$t_Asignaciones:=""
				For ($i;1;Size of array:C274($ai_dia))
					$t_Asignaciones:=$t_Asignaciones+";(  "+DT_DayNameFromISODayNumber ($ai_dia{$i})+" "+String:C10($ai_Hora{$i})+"ª hora"
					APPEND TO ARRAY:C911($al_columnasResalte;$ai_dia{$i}+3)
					APPEND TO ARRAY:C911($al_filasResalte;$ai_Hora{$i})
				End for 
				$t_itemsPopUpMenu:=Char:C90(1)+__ ("Horario y Sesiones de ")+atSTK_Subsectores_LongName{$l_fila}+"...;"+Char:C90(1)+__ ("Resaltar horario de la asignatura")+$t_Asignaciones
			Else 
				$t_itemsPopUpMenu:="("+__ ("Horario y Sesiones de ")+atSTK_Subsectores_LongName{$l_fila}+"...;"+"("+__ ("Resaltar horario de la asignatura")
			End if 
			$t_itemsPopUpMenu:=Replace string:C233($t_itemsPopUpMenu;"/";" | ")
			$t_itemsPopUpMenu:=Replace string:C233($t_itemsPopUpMenu;"-";" – ")
			$l_itemSeleccionado:=Pop up menu:C542($t_itemsPopUpMenu;0)
			
			Case of 
				: ($l_itemSeleccionado=1)
					TMT_InfoAsignacionAsignatura (alSTK_IDSubsectores{$l_fila})
				: ($l_itemSeleccionado=2)
					
					TMT_FijaAparienciaCeldas 
					TMT_ResaltaHorario (alSTK_IDSubsectores{$l_fila})
					  //For ($i;1;Size of array($al_columnasResalte))
					  //$t_nombreObjeto:=$at_nombreColumnas{$al_columnasResalte{$i}}
					  //$i_fila:=$al_filasResalte{$i}
					  //LISTBOX SET ROW COLOR(*;$t_nombreObjeto;$i_fila;IT_IndexColor2RGB (Dark green);Listbox background color)
					  //LISTBOX SET ROW COLOR(*;$t_nombreObjeto;$i_fila;0x00FFFFFF;Listbox font color)
					  //End for
			End case 
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		  //OBJECT SET VISIBLE(*;"rectanguloSeleccion";False)
		  //OBJECT SET VISIBLE(*;"resalte@";False)
		  //OBJECT SET RGB COLORS(*;"lbHorario";0;0x00FFFFFF;0x00F0F0F0)
		
		TMT_FijaAparienciaCeldas 
End case 