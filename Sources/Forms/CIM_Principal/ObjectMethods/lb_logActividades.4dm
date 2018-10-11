  // [xShell_Logs].Manager.lb_logEventos()
  //
  //
  // creado por: Alberto Bachler Klein: 06-06-16, 11:19:55
  // -----------------------------------------------------------
C_LONGINT:C283($l_columna;$l_fila)
C_TEXT:C284($t_menuRef;$t_seleccion)

Case of 
	: (Form event:C388=On Selection Change:K2:29)
		COPY SET:C600("$listboxSet0";"$seleccionActividades")
		
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			$t_menuRef:=Create menu:C408
			MNU_Append ($t_menuRef;"Mostrar eventos del mismo tipo";"mismoTipo")
			MNU_Append ($t_menuRef;"Mostrar eventos del mismo usuario";"mismoUsuario")
			MNU_Append ($t_menuRef;"Mostrar eventos en la misma fecha";"mismaFecha")
			MNU_Append ($t_menuRef;"(-";"")
			MNU_Append ($t_menuRef;"Todos los eventos";"todos";True:C214;"";"";"+";Command key mask:K16:1)
			MNU_Append ($t_menuRef;"Mostrar sólo seleccionados";"seleccion";True:C214;"";"";"-";Command key mask:K16:1)
			MNU_Append ($t_menuRef;"Excluir seleccionados";"menosSeleccion";True:C214;"";"";"-";Command key mask:K16:1+Shift key mask:K16:3)
			MNU_Append ($t_menuRef;"(-";"")
			$y_refMenuModulos:=OBJECT Get pointer:C1124(Object named:K67:5;"refMenuModulos")
			APPEND MENU ITEM:C411($t_menuRef;"Modulos";$y_refMenuModulos->)
			$y_refMenuUsuarios:=OBJECT Get pointer:C1124(Object named:K67:5;"refMenuUsuarios")
			APPEND MENU ITEM:C411($t_menuRef;"Usuarios";$y_refMenuUsuarios->)
			
			$t_seleccion:=Dynamic pop up menu:C1006($t_menuRef)
			RELEASE MENU:C978($t_menuRef)
			
			If ($t_seleccion#"")
				LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087(Object current:K67:2);$l_columna;$l_fila)
				GOTO SELECTED RECORD:C245([xShell_Logs:37];$l_fila)
				CIM_Log_FiltraEventos 
				
				
				Case of 
					: ($t_seleccion="mismoTipo")
						QUERY SELECTION:C341([xShell_Logs:37];[xShell_Logs:37]Event_Description:5=[xShell_Logs:37]Event_Description:5)
						ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
						
					: ($t_seleccion="mismoUsuario")
						QUERY SELECTION:C341([xShell_Logs:37];[xShell_Logs:37]UserName:2=[xShell_Logs:37]UserName:2)
						ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
						
					: ($t_seleccion="mismaFecha")
						QUERY SELECTION:C341([xShell_Logs:37];[xShell_Logs:37]Event_Date:3=[xShell_Logs:37]Event_Date:3)
						ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
						
					: ($t_seleccion="todos")
						POST KEY:C465(Character code:C91("+");Command key mask:K16:1)
					: ($t_seleccion="seleccion")
						POST KEY:C465(Character code:C91("-");Command key mask:K16:1)
					: ($t_seleccion="menosSeleccion")
						POST KEY:C465(Character code:C91("-");Command key mask:K16:1+Shift key mask:K16:3)
						
					: ($t_seleccion="M&@")  // modulos
						$t_modulo:=Substring:C12($t_seleccion;3)
						QUERY SELECTION:C341([xShell_Logs:37];[xShell_Logs:37]Module:8=$t_modulo)
						ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
						
					: ($t_seleccion="U&@")  // usuarios
						$t_usuario:=Substring:C12($t_seleccion;3)
						QUERY SELECTION:C341([xShell_Logs:37];[xShell_Logs:37]UserName:2=$t_usuario)
						ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
				End case 
			End if 
		End if 
		OBJECT SET TITLE:C194(*;"totalEventos";String:C10(Records in selection:C76([xShell_Logs:37]))+__ (" sobre ")+String:C10(Records in table:C83([xShell_Logs:37]))+" "+__ ("eventos"))
		
	: (Form event:C388=On Unload:K2:2)
		SET_ClearSets ("$listboxSet0";"$seleccionActividades")
End case 
