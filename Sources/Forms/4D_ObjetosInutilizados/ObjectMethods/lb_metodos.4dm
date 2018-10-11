  // 4D_ObjetosInutilizados.List Box()
  // Por: Alberto Bachler K.: 28-07-15, 12:05:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_fila;$l_opcion)
C_POINTER:C301($y_listBox;$y_Metodos)
C_TEXT:C284($t_texto)

ARRAY LONGINT:C221($al_filasSeleccionadas;0)

$y_Metodos:=OBJECT Get pointer:C1124(Object named:K67:5;"metodos")
$y_listBox:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_metodos")

Case of 
		
	: (Form event:C388=On Double Clicked:K2:5)
		METHOD OPEN PATH:C1213($y_Metodos->{$y_Metodos->};*)
		
	: ((Form event:C388=On Clicked:K2:4) & (Contextual click:C713))
		$l_opcion:=Pop up menu:C542("Copiar lista;Copiar selección…;(-;Quitar de la lista")
		Case of 
			: ($l_opcion=1)
				$t_texto:=AT_array2text ($y_Metodos;"\r")
				SET TEXT TO PASTEBOARD:C523($t_texto)
				
			: ($l_opcion=2)
				$l_fila:=LB_GetSelectedRows ($y_listBox;->$al_filasSeleccionadas)
				For ($i;1;Size of array:C274($al_filasSeleccionadas))
					$t_texto:=$t_texto+$y_Metodos->{$al_filasSeleccionadas{$i}}+"\r"
				End for 
				SET TEXT TO PASTEBOARD:C523($t_texto)
				
			: ($l_opcion=4)
				$l_fila:=LB_GetSelectedRows ($y_listBox;->$al_filasSeleccionadas)
				For ($i;Size of array:C274($al_filasSeleccionadas);1;-1)
					LISTBOX DELETE ROWS:C914(*;"lb_metodos";$al_filasSeleccionadas{$i})
				End for 
		End case 
		
End case 

