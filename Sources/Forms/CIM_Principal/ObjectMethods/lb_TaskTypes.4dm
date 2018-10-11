  // CIM_Principal.lb_TaskTypes()
  // Por: Alberto Bachler K.: 23-09-15, 17:44:58
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_columna;$l_orden;$l_posicion)
C_POINTER:C301($y_Acciones;$y_Acciones_H;$y_current;$y_Ejecuciones_H)
C_TEXT:C284($t_evento)

Case of 
	: (Form event:C388=On Header Click:K2:40)
		$y_Acciones_H:=OBJECT Get pointer:C1124(Object named:K67:5;"acciones_H")
		$y_Ejecuciones_H:=OBJECT Get pointer:C1124(Object named:K67:5;"ejecuciones_H")
		$y_current:=OBJECT Get pointer:C1124(Object current:K67:2)
		$y_Acciones:=OBJECT Get pointer:C1124(Object named:K67:5;"acciones")
		
		$l_posicion:=LB_GetSelectedRows (->lb_TaskTypes)
		If ($l_posicion>0)
			$t_evento:=$y_Acciones->{$l_posicion}
		End if 
		Case of 
			: ($y_current=$y_Acciones_H)
				$l_columna:=1
				$l_orden:=Choose:C955($y_current->=1;2;1)
				$y_current->:=$l_orden
				
			: ($y_current=$y_Ejecuciones_H)
				$l_columna:=2
				$l_orden:=Choose:C955($y_current->=1;2;1)
				$y_current->:=$l_orden
		End case 
		
		If ($l_orden=1)
			LISTBOX SORT COLUMNS:C916(*;"lb_TaskTypes";$l_columna;>)
		Else 
			LISTBOX SORT COLUMNS:C916(*;"lb_TaskTypes";$l_columna;<)
		End if 
		
		If ($l_posicion>0)
			$l_posicion:=Find in array:C230($y_Acciones->;$t_evento)
			OBJECT SET SCROLL POSITION:C906(*;"lb_TaskTypes";$l_posicion)
		End if 
		
	: (Form event:C388=On Selection Change:K2:29)
		XS_CIM_ObjetMethods ("ShowUserTasks")
End case 